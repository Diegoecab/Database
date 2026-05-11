#!/usr/bin/env python3
"""Apply the oracle/admin directory layout described by the inventory."""

import argparse
import csv
import os
import re
from collections import defaultdict
from pathlib import Path


ROOT = Path("oracle/admin")
INVENTORY = ROOT / "_inventory" / "oracle_admin_inventory.csv"
OUT = ROOT / "_inventory" / "applied_moves.csv"


DROP_SOURCE_DIRS = {
    "ash",
    "ast",
    "awr",
    "aws",
    "exadata",
    "oci",
    "os",
    "rac",
}


def slug_dir(value):
    value = value.strip().replace("$", "s")
    value = re.sub(r"[^A-Za-z0-9]+", "_", value)
    value = re.sub(r"_+", "_", value).strip("_").lower()
    return value or "misc"


def safe_filename(path):
    name = path.name
    if "$" not in name:
        return name
    stem = path.stem
    suffix = path.suffix
    if stem.startswith("v$"):
        stem = stem[2:] + "_vview"
    else:
        stem = stem.replace("$", "") + "_base_table"
    stem = stem.replace(" (1)", "").replace("(1)", "")
    return stem + suffix


def source_tail(path):
    parts = list(path.parent.parts)
    if parts and parts[0] in {"scripts", "RMAN", "shell_scripts"}:
        root = parts.pop(0)
        prefix = []
        if root == "RMAN":
            prefix = ["legacy_rman"]
        elif root == "shell_scripts":
            prefix = ["shell"]
        if root == "scripts" and parts and parts[0] in DROP_SOURCE_DIRS:
            parts.pop(0)
        if root == "RMAN" and parts and parts[0] == "RMAN":
            parts.pop(0)
        return prefix + [slug_dir(part) for part in parts if part]
    return [slug_dir(part) for part in parts if part]


def third_party_bucket(path, text_category):
    parts = list(path.parts)
    lowered = [p.lower() for p in parts]
    if "ash" in lowered:
        return ["tanel_poder", "ash"]
    if "awr" in lowered:
        return ["tanel_poder", "awr"]
    if "ast" in lowered:
        return ["tanel_poder", "ast"]
    if "exadata" in lowered:
        return ["tanel_poder", "exadata"]
    return [slug_dir(text_category.replace("/", "_"))]


def proposed_target(row):
    current = Path(row["path"])
    kind = row["kind"]
    category = row["suggested_category"]
    tail = source_tail(current)

    if row["path"] == "README.md" or row["path"].startswith("_inventory/"):
        return current

    if row["third_party"] == "yes":
        return Path("scripts/third_party").joinpath(*third_party_bucket(current, category), *tail, safe_filename(current))

    if kind == "script":
        return Path("scripts").joinpath(*category.split("/"), *tail, safe_filename(current))
    if kind == "documentation":
        return Path("docs").joinpath(*category.split("/"), *tail, safe_filename(current))
    if kind == "generated_output":
        return Path("generated").joinpath(*tail, safe_filename(current))
    if kind == "archive_bundle":
        return Path("archive/bundles").joinpath(*tail, safe_filename(current))
    if kind == "config":
        return Path("config").joinpath(*tail, safe_filename(current))
    return Path("archive/review").joinpath(*tail, safe_filename(current))


def load_rows():
    with INVENTORY.open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def build_plan(rows):
    plan = []
    used = defaultdict(list)
    for row in rows:
        src = Path(row["path"])
        dst = proposed_target(row)
        used[dst.as_posix()].append(src.as_posix())
        if src != dst:
            plan.append((src, dst, row))

    conflicts = {dst: srcs for dst, srcs in used.items() if len(srcs) > 1}
    if conflicts:
        details = []
        for dst, srcs in sorted(conflicts.items()):
            details.append("{0} <= {1}".format(dst, " | ".join(srcs)))
        raise RuntimeError("Move plan has destination conflicts:\n" + "\n".join(details[:50]))
    return plan


def remove_empty_dirs():
    protected = {
        ROOT,
        ROOT / "_inventory",
        ROOT / "scripts",
        ROOT / "docs",
        ROOT / "generated",
        ROOT / "archive",
        ROOT / "config",
    }
    for current, dirs, files in os.walk(str(ROOT), topdown=False):
        path = Path(current)
        if path in protected:
            continue
        try:
            path.rmdir()
        except OSError:
            pass


def write_report(plan, applied):
    with OUT.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["source", "destination", "kind", "category", "applied"])
        writer.writeheader()
        for src, dst, row in plan:
            writer.writerow(
                {
                    "source": src.as_posix(),
                    "destination": dst.as_posix(),
                    "kind": row["kind"],
                    "category": row["suggested_category"],
                    "applied": "yes" if applied else "no",
                }
            )


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()

    plan = build_plan(load_rows())
    for src, dst, row in plan:
        print("{0} -> {1}".format(src.as_posix(), dst.as_posix()))
        if args.apply:
            absolute_src = ROOT / src
            absolute_dst = ROOT / dst
            absolute_dst.parent.mkdir(parents=True, exist_ok=True)
            absolute_src.rename(absolute_dst)

    if args.apply:
        remove_empty_dirs()
    write_report(plan, args.apply)
    print("moves={0} applied={1}".format(len(plan), "yes" if args.apply else "no"))


if __name__ == "__main__":
    main()
