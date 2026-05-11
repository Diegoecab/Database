#!/usr/bin/env python3
"""Add standard headers to owned oracle/admin scripts."""

import argparse
import csv
import subprocess
from pathlib import Path


ROOT = Path("oracle/admin")
INVENTORY = ROOT / "_inventory" / "missing_headers.csv"
FULL_INVENTORY = ROOT / "_inventory" / "oracle_admin_inventory.csv"
NORMALIZATION_DATE = "2026-05-11"


COMMENT_STYLE = {
    ".sql": ("--", "--"),
    ".sh": ("#", "#"),
    ".ksh": ("#", "#"),
    ".rman": ("#", "#"),
    ".cmd": ("REM", "REM"),
    ".bat": ("REM", "REM"),
    ".ps1": ("#", "#"),
    ".py": ("#", "#"),
    ".pl": ("#", "#"),
    ".vbs": ("'", "'"),
}


def risk_for_category(category):
    if category.startswith("diagnostics") or category in {"utilities", "platform/rac", "platform/exadata"}:
        return "READ ONLY"
    if category.startswith("backup_recovery") or category.startswith("storage"):
        return "REVIEW"
    if category.startswith("security") or category.startswith("maintenance"):
        return "REVIEW"
    return "REVIEW"


def purpose_for(path, category):
    name = path.stem.replace("_", " ").replace("-", " ").replace(".", " ")
    name = " ".join(name.split())
    if category == "backup_recovery/rman":
        return "Oracle RMAN backup, restore or recovery helper: {0}.".format(name)
    if category == "backup_recovery/dataguard":
        return "Oracle Data Guard administration helper: {0}.".format(name)
    if category.startswith("diagnostics"):
        return "Oracle diagnostic query/report helper: {0}.".format(name)
    if category.startswith("performance"):
        return "Oracle SQL performance and tuning helper: {0}.".format(name)
    if category.startswith("storage"):
        return "Oracle storage, ASM, ACFS or tablespace helper: {0}.".format(name)
    if category.startswith("security"):
        return "Oracle security, audit, user, role or grants helper: {0}.".format(name)
    if category.startswith("cloud/aws"):
        return "AWS/RDS/DMS Oracle administration helper: {0}.".format(name)
    if category.startswith("cloud/oci"):
        return "OCI Oracle administration helper: {0}.".format(name)
    if category.startswith("platform/rac"):
        return "Oracle RAC or cluster administration helper: {0}.".format(name)
    if category.startswith("platform/exadata"):
        return "Oracle Exadata administration helper: {0}.".format(name)
    if category.startswith("maintenance"):
        return "Oracle database maintenance helper: {0}.".format(name)
    return "Oracle administration helper: {0}.".format(name)


def parameters_for(path):
    suffix = path.suffix.lower()
    if suffix == ".sql":
        return "Review ACCEPT variables and substitution variables before running."
    if suffix in {".sh", ".ksh", ".cmd", ".bat", ".ps1", ".py", ".pl", ".vbs"}:
        return "Review script arguments and environment variables before running."
    if suffix == ".rman":
        return "Review RMAN target/catalog connection and channels before running."
    return "Review script body before running."


def requires_for(path, category):
    suffix = path.suffix.lower()
    if suffix == ".rman" or category == "backup_recovery/rman":
        return "RMAN, Oracle environment, and required backup/recovery privileges."
    if suffix in {".sh", ".ksh"}:
        return "Oracle client tools and a configured Oracle OS environment."
    if suffix in {".cmd", ".bat", ".ps1"}:
        return "Windows Oracle client/server environment as applicable."
    if suffix == ".py":
        return "Python runtime and required Oracle/client libraries."
    if suffix == ".pl":
        return "Perl runtime, SQL*Plus and required Oracle/client libraries."
    return "SQL*Plus or SQLcl and privileges required by referenced dictionary views."


def output_for(path):
    suffix = path.suffix.lower()
    if suffix == ".sql":
        return "SQL*Plus/SQLcl console or spool output."
    if suffix == ".rman":
        return "RMAN console or log output."
    if suffix in {".sh", ".ksh", ".cmd", ".bat", ".ps1", ".py", ".pl", ".vbs"}:
        return "Shell/command output and any script-defined log files."
    return "Script-defined output."


def usage_for(path):
    suffix = path.suffix.lower()
    name = path.name
    if suffix == ".sql":
        return "@" + name
    if suffix in {".sh", ".ksh"}:
        return "./" + name
    if suffix == ".py":
        return "python3 " + name
    if suffix == ".pl":
        return "perl " + name
    if suffix == ".rman":
        return "rman target / cmdfile=" + name
    if suffix in {".cmd", ".bat"}:
        return name
    if suffix == ".ps1":
        return "./" + name
    return name


def header_lines(path, category):
    prefix, border_prefix = COMMENT_STYLE[path.suffix.lower()]
    border = border_prefix + " " + ("-" * 78)
    if prefix == "REM":
        blank = "REM"
    else:
        blank = prefix

    def line(label, value):
        return "{0} {1:<11}: {2}".format(prefix, label, value)

    return [
        border,
        line("File", path.name),
        line("Purpose", purpose_for(path, category)),
        line("Category", category),
        line("Author", "Diego Cabrera"),
        line("Created", "Unknown"),
        line("Version", "1.0"),
        line("Usage", usage_for(path)),
        line("Parameters", parameters_for(path)),
        line("Requires", requires_for(path, category)),
        line("Oracle Ver.", "Review compatibility before production use."),
        line("Risk", risk_for_category(category)),
        line("Output", output_for(path)),
        line("Notes", "Validate in a non-production session before operational use."),
        line("Source", "internal"),
        line("Change Log", ""),
        line(NORMALIZATION_DATE, "Diego Cabrera - Header normalization."),
        border,
        blank,
    ]


def detect_newline(data):
    crlf = data.count(b"\r\n")
    lf = data.count(b"\n") - crlf
    return b"\r\n" if crlf > lf else b"\n"


def build_header(path, category, newline):
    return newline.join(line.encode("utf-8") for line in header_lines(path, category)) + newline


def original_bytes_from_head(path):
    git_path = path.as_posix()
    proc = subprocess.Popen(["git", "show", "HEAD:" + git_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = proc.communicate()
    if proc.returncode != 0:
        raise RuntimeError(err.decode("utf-8", errors="ignore"))
    return out


def add_header(path, category, from_head=False):
    data = original_bytes_from_head(path) if from_head else path.read_bytes()
    newline = detect_newline(data)

    insert_at = 0
    if data.startswith(b"#!"):
        line_end = data.find(b"\n")
        insert_at = len(data) if line_end == -1 else line_end + 1

    header = build_header(path, category, newline)
    path.write_bytes(data[:insert_at] + header + data[insert_at:])


def rows_for(category_prefix, limit):
    with INVENTORY.open(newline="", encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    selected = []
    for row in rows:
        path = ROOT / row["path"]
        if path.suffix.lower() not in COMMENT_STYLE:
            continue
        if category_prefix and not row["suggested_category"].startswith(category_prefix):
            continue
        selected.append(row)
        if limit and len(selected) >= limit:
            break
    return selected


def rows_for_paths(paths):
    with FULL_INVENTORY.open(newline="", encoding="utf-8") as handle:
        by_path = {row["path"]: row for row in csv.DictReader(handle)}
    selected = []
    for path in paths:
        row = by_path[path]
        selected.append(
            {
                "path": row["path"],
                "suggested_category": row["suggested_category"],
                "extension": row["extension"],
            }
        )
    return selected


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--category-prefix", default="")
    parser.add_argument("--limit", type=int, default=0)
    parser.add_argument("--apply", action="store_true")
    parser.add_argument("--from-head", action="store_true")
    parser.add_argument("--path", action="append", default=[])
    args = parser.parse_args()

    selected = rows_for_paths(args.path) if args.path else rows_for(args.category_prefix, args.limit)
    for row in selected:
        print("{0},{1}".format(row["path"], row["suggested_category"]))
        if args.apply:
            add_header(ROOT / row["path"], row["suggested_category"], from_head=args.from_head)
    print("selected={0} applied={1}".format(len(selected), "yes" if args.apply else "no"))


if __name__ == "__main__":
    main()
