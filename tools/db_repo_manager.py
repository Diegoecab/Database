#!/usr/bin/env python3
"""Organize database script roots and generate MCP/skill metadata."""

import argparse
import csv
import hashlib
import json
import os
import re
from collections import Counter, defaultdict
from pathlib import Path


ROOTS = ["oracle/admin", "postgres", "SQLServer", "mysql", "db2", "mongodb", "aws", "os"]

SCRIPT_EXTS = {".sql", ".sh", ".ksh", ".bash", ".cmd", ".bat", ".ps1", ".py", ".pl", ".js", ".vbs", ".rman"}
DOC_EXTS = {".txt", ".md", ".doc", ".docx", ".pdf", ".html", ".htm"}
CONFIG_EXTS = {".json", ".yml", ".yaml", ".template", ".tf", ".hcl", ".par", ".cfg", ".conf"}
ARCHIVE_EXTS = {".zip", ".gz", ".rar", ".7z"}
GENERATED_EXTS = {".log", ".out", ".lst", ".trc", ".tfstate"}
NOISE_NAMES = {"afiedt.buf", "nohup.out"}

READONLY_RE = re.compile(r"\b(select|show|describe|explain|with)\b", re.I)
CHANGE_RE = re.compile(r"\b(alter|create|grant|revoke|analyze|vacuum|reindex|update|insert|merge|call|execute|exec)\b", re.I)
DESTRUCTIVE_RE = re.compile(r"\b(drop|delete|truncate|kill|terminate|shutdown|restore|recover|remove|purge)\b", re.I)
SECRET_RE = re.compile(
    r"(AKIA[0-9A-Z]{16}|"
    r"(aws_secret_access_key|secret_access_key)\s*=\s*['\"][^'\"]+['\"]|"
    r"(password|passwd|pwd|master_password)\s*=\s*['\"][^'\"<>{}$]+['\"]|"
    r"user(id)?\s*=\s*['\"]?[^\\s/]+/[^\\s@'\"$]+)",
    re.I,
)


def read_bytes(path):
    try:
        return path.read_bytes()
    except OSError:
        return b""


def read_text(path, limit=65536):
    return read_bytes(path)[:limit].decode("utf-8", errors="ignore")


def sha256(path):
    h = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def slug(value):
    value = value.replace("$", "s")
    value = re.sub(r"[^A-Za-z0-9]+", "_", value)
    return re.sub(r"_+", "_", value).strip("_").lower() or "misc"


def safe_filename(path):
    name = path.name
    name = re.sub(r"\s?\(\d+\)(?=\.)", "", name)
    if "$" in name:
        stem = path.stem
        if stem.startswith("v$"):
            stem = stem[2:] + "_vview"
        else:
            stem = stem.replace("$", "") + "_base_table"
        name = stem + path.suffix
    name = name.replace(" ", "_")
    return name


def is_generated(path):
    name = path.name
    lower = name.lower()
    if lower in NOISE_NAMES or lower.endswith(".swp"):
        return True
    if ".tfstate" in lower or lower.endswith(".backup") or re.search(r"\.backup\d+$", lower):
        return True
    if lower.endswith(".aug0324") or lower == "aurora-postgresql-us-east-1":
        return True
    if lower.startswith("--") or "|" in name or name.endswith("\\") or name in {",", "@"}:
        return True
    return path.suffix.lower() in GENERATED_EXTS


def kind_for(path):
    if is_generated(path):
        return "generated_output"
    ext = path.suffix.lower()
    if ext in SCRIPT_EXTS or (not ext and os.access(str(path), os.X_OK)):
        return "script"
    if ext in DOC_EXTS:
        return "documentation"
    if ext in CONFIG_EXTS:
        return "config"
    if ext in ARCHIVE_EXTS:
        return "archive_bundle"
    return "unknown"


def category_for(root, rel, kind):
    parts = [p.lower() for p in rel.parts]
    name = rel.name.lower()
    text = "/".join(parts)

    if parts and parts[0] in {"scripts", "docs", "config", "archive"}:
        if len(parts) >= 4 and parts[1] in {"diagnostics", "performance", "maintenance", "replication", "storage", "security", "backup_recovery", "cloud", "platform", "infra"}:
            return f"{parts[1]}/{parts[2]}"
        if len(parts) >= 2:
            return parts[1]

    if root == "aws":
        if "terraform" in parts:
            return "infra/terraform"
        if "cloudformation" in parts:
            return "infra/cloudformation"
        for service in ("dms", "rds", "ec2", "s3", "kms", "lambda", "cloud9", "cli"):
            if service in parts or service in name:
                return f"cloud/{service}"
        return "cloud/utilities"

    if root == "os":
        if "windows" in parts:
            return "platform/windows"
        if "linux" in parts:
            return "platform/linux"
        return "platform/utilities"

    if any(x in name for x in ("session", "activity", "lock", "wait", "event", "pid", "query")):
        return "diagnostics/sessions"
    if any(x in name for x in ("vacuum", "autovacuum", "stats", "stat_", "performance", "plan", "repack", "index", "bloat")):
        return "performance/tuning"
    if any(x in name for x in ("replica", "replication", "slot", "publication", "lsn", "wal", "standby", "slave")):
        return "replication"
    if any(x in name for x in ("size", "tablespace", "space", "lob", "partition", "table")):
        return "storage"
    if any(x in name for x in ("user", "grant", "role", "ssl", "auth", "password")):
        return "security"
    if any(x in name for x in ("backup", "dump", "restore", "export", "import")):
        return "backup_recovery"
    if any(x in name for x in ("cron", "extension", "parameter", "setting", "config")):
        return "maintenance"
    return "utilities"


def risk_for(path, text):
    lowered = text.lower()
    if DESTRUCTIVE_RE.search(lowered):
        return "DESTRUCTIVE"
    if CHANGE_RE.search(lowered):
        return "CHANGES"
    if READONLY_RE.search(lowered):
        return "READ_ONLY"
    if path.suffix.lower() in {".json", ".yml", ".yaml", ".tf", ".hcl", ".par"}:
        return "CONFIG"
    return "REVIEW"


def params_for(path, text):
    params = set()
    for match in re.finditer(r"\baccept\s+([A-Za-z_][A-Za-z0-9_]*)", text, re.I):
        params.add(match.group(1))
    for match in re.finditer(r"&{1,2}([A-Za-z_][A-Za-z0-9_]*)", text):
        params.add(match.group(1))
    for match in re.finditer(r":([A-Za-z_][A-Za-z0-9_]*)", text):
        if len(match.group(1)) > 1:
            params.add(match.group(1))
    for match in re.finditer(r"\$\{?([1-9][0-9]*)\}?", text):
        params.add("arg" + match.group(1))
    for match in re.finditer(r"\b([A-Z][A-Z0-9_]{2,})=", text):
        params.add(match.group(1))
    return sorted(params)[:50]


def has_header(text):
    first = "\n".join(text.splitlines()[:35]).lower()
    return sum(1 for token in ("file", "purpose", "author", "usage", "risk", "created", "version") if token in first) >= 2


def human_name(path):
    return " ".join(path.stem.replace("_", " ").replace("-", " ").replace(".", " ").split())


def description_for(root, rel, category, text):
    head = "\n".join(text.splitlines()[:80])
    for line in head.splitlines():
        match = re.match(r"\s*(?:--|#|REM|')?\s*(?:Purpose|Description|Proposito|Propósito)\s*:\s*(.+?)\s*$", line, re.I)
        if match:
            description = " ".join(match.group(1).split())
            if description:
                return description[:500]
    return f"{root} {category} helper: {human_name(rel)}."


def target_for(root, rel, kind, category):
    if rel == Path("README.md"):
        return rel
    if rel.parts and rel.parts[0] in {"scripts", "docs", "config", "archive", "_catalog", "_inventory"}:
        return rel
    safe = safe_filename(rel)
    tail = [slug(p) for p in rel.parts[:-1]]
    if kind == "script":
        return Path("scripts").joinpath(*category.split("/"), *tail, safe)
    if kind == "documentation":
        return Path("docs").joinpath(*category.split("/"), *tail, safe)
    if kind == "config":
        return Path("config").joinpath(*tail, safe)
    if kind == "archive_bundle":
        return Path("archive/bundles").joinpath(*tail, safe)
    if kind == "generated_output":
        return Path("generated").joinpath(*tail, safe)
    return Path("archive/review").joinpath(*tail, safe)


def inventory_root(root):
    base = Path(root)
    rows = []
    for path in sorted(p for p in base.rglob("*") if p.is_file()):
        if "_catalog" in path.parts or "_inventory" in path.parts:
            continue
        rel = path.relative_to(base)
        kind = kind_for(path)
        category = category_for(root, rel, kind)
        text = read_text(path)
        rows.append(
            {
                "id": f"{root}:{rel.as_posix()}",
                "engine": root,
                "path": rel.as_posix(),
                "extension": path.suffix.lower(),
                "bytes": path.stat().st_size,
                "sha256": sha256(path),
                "kind": kind,
                "category": category,
                "description": description_for(root, rel, category, text),
                "risk": risk_for(path, text),
                "has_header": has_header(text),
                "parameters": params_for(path, text),
                "secret_flags": bool(SECRET_RE.search(text)),
                "target": target_for(root, rel, kind, category).as_posix(),
            }
        )
    return rows


def write_csv(path, rows, fieldnames):
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def write_readmes(root, rows):
    base = Path(root)
    counts = Counter(r["category"] for r in rows if r["kind"] == "script")
    lines = [
        f"# {root} Scripts",
        "",
        "This directory is organized for script discovery, static validation and future MCP/skill use.",
        "",
        "## Layout",
        "",
        "- `scripts/`: executable SQL, shell, Python and command scripts.",
        "- `docs/`: notes and documentation.",
        "- `config/`: templates and parameter/configuration files.",
        "- `archive/`: bundles and material kept for reference.",
        "- `_catalog/`: generated machine-readable metadata.",
        "",
        "## Script Categories",
        "",
    ]
    for category, count in sorted(counts.items()):
        lines.append(f"- `{category}`: {count}")
    lines.extend(["", "Generated catalog:", "", "```bash", f"python3 tools/db_repo_manager.py catalog --roots {root}", "```", ""])
    readme_path = base / "README.md"
    if not (root == "oracle/admin" and readme_path.exists()):
        readme_path.write_text("\n".join(lines), encoding="utf-8")

    by_category = defaultdict(list)
    for row in rows:
        if row["kind"] == "script":
            by_category[row["category"]].append(row)
    for category, items in by_category.items():
        readme = base / "scripts" / Path(category) / "README.md"
        readme.parent.mkdir(parents=True, exist_ok=True)
        out = [f"# {root} {category}", "", "| Script | Description | Risk | Parameters |", "|---|---|---|---|"]
        for row in sorted(items, key=lambda r: r["path"]):
            description = row["description"].replace("|", "\\|")
            out.append(
                f"| `{Path(row['path']).name}` | {description} | `{row['risk']}` | `{', '.join(row['parameters']) or '-'}` |"
            )
        readme.write_text("\n".join(out) + "\n", encoding="utf-8")


def comment_prefix(path):
    ext = path.suffix.lower()
    if ext in {".sql", ".tf", ".hcl", ".yml", ".yaml"}:
        return "--" if ext == ".sql" else "#"
    if ext in {".cmd", ".bat"}:
        return "REM"
    if ext == ".vbs":
        return "'"
    return "#"


def usage_for(path):
    ext = path.suffix.lower()
    if ext == ".sql":
        return f"Run with the target database client: {path.name}"
    if ext in {".sh", ".ksh", ".bash"}:
        return f"./{path.name}"
    if ext == ".py":
        return f"python3 {path.name}"
    if ext in {".cmd", ".bat", ".ps1"}:
        return path.name
    return path.name


def add_header_to_file(path, row):
    data = path.read_bytes()
    newline = b"\r\n" if data.count(b"\r\n") > data.count(b"\n") - data.count(b"\r\n") else b"\n"
    insert_at = 0
    if data.startswith(b"#!"):
        end = data.find(b"\n")
        insert_at = len(data) if end == -1 else end + 1

    prefix = comment_prefix(path)
    border = f"{prefix} {'-' * 78}"
    lines = [
        border,
        f"{prefix} File       : {path.name}",
        f"{prefix} Purpose    : {row['engine']} {row['category']} helper: {path.stem.replace('_', ' ').replace('-', ' ')}.",
        f"{prefix} Engine     : {row['engine']}",
        f"{prefix} Category   : {row['category']}",
        f"{prefix} Author     : Diego Cabrera",
        f"{prefix} Created    : Unknown",
        f"{prefix} Version    : 1.0",
        f"{prefix} Usage      : {usage_for(path)}",
        f"{prefix} Parameters : {', '.join(row['parameters']) if row['parameters'] else 'Review script body before running.'}",
        f"{prefix} Risk       : {row['risk']}",
        f"{prefix} Output     : Client, shell or script-defined output.",
        f"{prefix} Notes      : Validate in a non-production environment before operational use.",
        f"{prefix} Source     : internal",
        f"{prefix} Change Log :",
        f"{prefix} 2026-05-11 : Diego Cabrera - Header normalization.",
        border,
        prefix,
    ]
    header = newline.join(line.encode("utf-8") for line in lines) + newline
    path.write_bytes(data[:insert_at] + header + data[insert_at:])


def add_headers(roots):
    for root in roots:
        rows = inventory_root(root)
        changed = 0
        for row in rows:
            if row["kind"] != "script" or row["has_header"]:
                continue
            path = Path(root) / row["path"]
            if path.suffix.lower() not in SCRIPT_EXTS and path.suffix:
                continue
            add_header_to_file(path, row)
            changed += 1
        print(f"{root}: headers_added={changed}")


def catalog(roots):
    all_rows = []
    for root in roots:
        rows = inventory_root(root)
        all_rows.extend(rows)
        base = Path(root)
        by_hash = Counter(r["sha256"] for r in rows)
        cleanup = [
            r
            for r in rows
            if r["kind"] == "generated_output"
            or re.search(r"(\s?\(\d+\))(?=\.)", Path(r["path"]).name)
            or ("$" in r["path"])
            or (by_hash[r["sha256"]] > 1 and not r["path"].startswith("config/"))
        ]
        write_csv(base / "_catalog" / "inventory.csv", rows, list(rows[0]) if rows else ["id"])
        write_csv(base / "_catalog" / "cleanup_candidates.csv", cleanup, list(rows[0]) if rows else ["id"])
        scripts = [r for r in rows if r["kind"] == "script"]
        (base / "_catalog" / "scripts_catalog.json").write_text(json.dumps(scripts, indent=2, sort_keys=True), encoding="utf-8")
        validation = {
            "engine": root,
            "total_files": len(rows),
            "scripts": len(scripts),
            "missing_headers": [r["path"] for r in scripts if not r["has_header"]],
            "secret_flags": [r["path"] for r in rows if r["secret_flags"]],
            "generated_outputs": [r["path"] for r in rows if r["kind"] == "generated_output"],
            "unsafe_names": [r["path"] for r in rows if "$" in r["path"] or re.search(r"(\s?\(\d+\))(?=\.)", Path(r["path"]).name)],
        }
        (base / "_catalog" / "validation_report.json").write_text(json.dumps(validation, indent=2, sort_keys=True), encoding="utf-8")
        write_readmes(root, rows)
    Path("_catalog").mkdir(exist_ok=True)
    (Path("_catalog") / "scripts_catalog.json").write_text(
        json.dumps([r for r in all_rows if r["kind"] == "script"], indent=2, sort_keys=True),
        encoding="utf-8",
    )


def organize(roots, delete_generated=False):
    for root in roots:
        base = Path(root)
        rows = inventory_root(root)
        targets = defaultdict(list)
        for row in rows:
            targets[row["target"]].append(row["path"])
        conflicts = {k: v for k, v in targets.items() if len(v) > 1}
        if conflicts:
            raise RuntimeError(f"{root} target conflicts: {conflicts}")
        for row in rows:
            src = base / row["path"]
            if delete_generated and row["kind"] == "generated_output":
                if src.exists():
                    src.unlink()
                continue
            dst = base / row["target"]
            if src == dst:
                continue
            dst.parent.mkdir(parents=True, exist_ok=True)
            src.rename(dst)
        for current, dirs, files in os.walk(str(base), topdown=False):
            p = Path(current)
            if p == base or p.name in {"_catalog", "_inventory"}:
                continue
            try:
                p.rmdir()
            except OSError:
                pass


def validate(roots):
    failed = False
    for root in roots:
        report = json.loads((Path(root) / "_catalog" / "validation_report.json").read_text(encoding="utf-8"))
        problems = {k: v for k, v in report.items() if isinstance(v, list) and v and k != "secret_flags"}
        if problems:
            failed = True
            print(root, json.dumps(problems, indent=2))
        if report.get("secret_flags"):
            print(root, "secret_flags", json.dumps(report["secret_flags"], indent=2))
    return 1 if failed else 0


def main():
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="cmd")
    for name in ("catalog", "organize", "validate", "add-headers"):
        p = sub.add_parser(name)
        p.add_argument("--roots", nargs="+", default=ROOTS)
    sub.choices["organize"].add_argument("--delete-generated", action="store_true")
    args = parser.parse_args()
    if not args.cmd:
        parser.error("a command is required")
    if args.cmd == "catalog":
        catalog(args.roots)
    elif args.cmd == "organize":
        organize(args.roots, args.delete_generated)
    elif args.cmd == "add-headers":
        add_headers(args.roots)
    elif args.cmd == "validate":
        raise SystemExit(validate(args.roots))


if __name__ == "__main__":
    main()
