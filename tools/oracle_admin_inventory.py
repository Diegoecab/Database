#!/usr/bin/env python3
"""Build inventory reports for oracle/admin."""

import csv
import hashlib
import re
from collections import defaultdict
from pathlib import Path
from typing import Dict, List


ROOT = Path("oracle/admin")
OUT = ROOT / "_inventory"

SCRIPT_EXTENSIONS = {".sql", ".sh", ".rman", ".cmd", ".bat", ".ksh", ".ps1", ".py", ".pl", ".vbs", ""}
GENERATED_EXTENSIONS = {".log", ".lst", ".out", ".html", ".htm", ".trc"}
DOC_EXTENSIONS = {".txt", ".doc", ".docx", ".pdf", ".xls", ".xlsx"}
ARCHIVE_EXTENSIONS = {".zip", ".rar", ".gz"}

THIRD_PARTY_MARKERS = (
    "tanel poder",
    "timothy s hall",
    "tim hall",
    "apache license",
    "kerry osborne",
    "tom kyte",
    "trivadis",
)

HEADER_MARKERS = (
    "purpose",
    "proposito",
    "propósito",
    "author",
    "autor",
    "usage",
    "uso",
    "created",
    "creado",
    "description",
    "descripcion",
    "descripción",
)


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def sample_text(path: Path, limit: int = 8192) -> str:
    try:
        return path.read_text(encoding="utf-8", errors="ignore")[:limit].lower()
    except OSError:
        return ""


def starts_with_rtf(path: Path) -> bool:
    try:
        return path.read_bytes()[:6].lower().startswith(b"{\\rtf")
    except OSError:
        return False


def file_kind(path: Path) -> str:
    ext = path.suffix.lower()
    name = path.name.lower()
    if starts_with_rtf(path):
        return "documentation"
    if name in {"afiedt.buf"} or ext == ".swp":
        return "editor_temp"
    if ext in GENERATED_EXTENSIONS:
        return "generated_output"
    if ext in DOC_EXTENSIONS:
        return "documentation"
    if ext in ARCHIVE_EXTENSIONS:
        return "archive_bundle"
    if ext in SCRIPT_EXTENSIONS:
        return "script"
    if ext in {".ora", ".cfg", ".json", ".par", ".pfile"}:
        return "config"
    return "unknown"


def category(path: Path) -> str:
    rel = path.relative_to(ROOT)
    parts = [p.lower() for p in rel.parts]
    text = "/".join(parts)
    name = path.name.lower()

    for root in ("scripts", "docs"):
        if len(parts) >= 3 and parts[0] == root:
            if parts[1] in {
                "backup_recovery",
                "cloud",
                "diagnostics",
                "maintenance",
                "performance",
                "platform",
            }:
                return f"{parts[1]}/{parts[2]}"
            if parts[1] in {"security", "storage", "utilities"}:
                return parts[1]

    if parts[0] == "rman" or "rman" in name:
        return "backup_recovery/rman"
    if any(p in parts for p in ("ash", "awr")):
        return f"diagnostics/{parts[0] if parts[0] in {'ash', 'awr'} else next(p for p in parts if p in {'ash', 'awr'})}"
    if "dataguard" in text or "standby" in text or "archive" in name or "archivelog" in name:
        return "backup_recovery/dataguard"
    if "asm" in name or "acfs" in name or "tablespace" in name or name.startswith("tbs"):
        return "storage"
    if "session" in name or "sess" in name or "wait" in name:
        return "diagnostics/sessions_waits"
    if "sql" in name and any(token in name for token in ("plan", "profile", "tune", "monitor", "stats")):
        return "performance/sql_tuning"
    if any(token in name for token in ("audit", "grant", "role", "priv", "user")):
        return "security"
    if any(token in text for token in ("aws", "rds", "dms")):
        return "cloud/aws"
    if "oci" in text:
        return "cloud/oci"
    if "exadata" in text:
        return "platform/exadata"
    if "rac" in text or "cluster" in name:
        return "platform/rac"
    if any(token in name for token in ("stats", "analyze", "gather")):
        return "maintenance/stats"
    if any(token in name for token in ("job", "scheduler")):
        return "maintenance/scheduler"
    return "utilities"


def has_header(text: str) -> bool:
    first_lines = "\n".join(text.splitlines()[:40])
    return sum(1 for marker in HEADER_MARKERS if marker in first_lines) >= 2


def is_third_party(text: str) -> bool:
    first_lines = "\n".join(text.splitlines()[:80])
    return any(marker in first_lines for marker in THIRD_PARTY_MARKERS)


def duplicate_style(path: Path) -> bool:
    return bool(re.search(r"(\s\(\d+\)|\(\d+\))(?=\.)", path.name))


def cleanup_reason(path: Path, kind: str, duplicate_hash_count: int) -> str:
    reasons = []  # type: List[str]
    rel = path.relative_to(ROOT).as_posix()
    semantic_duplicate = rel.startswith("config/shell/acs_exp_oci/par/")
    if kind == "editor_temp":
        reasons.append("editor temporary file")
    if path.name.lower() in {"sqlnet.log"}:
        reasons.append("runtime sqlnet log")
    if duplicate_style(path):
        reasons.append("copy-style filename")
    if duplicate_hash_count > 1 and not semantic_duplicate:
        reasons.append("exact duplicate content")
    return "; ".join(reasons)


def proposed_target(row):
    path = Path(row["path"])
    kind = row["kind"]
    category_name = row["suggested_category"]

    if row["path"] == "README.md":
        return row["path"]
    if path.parts and path.parts[0] in {"scripts", "docs", "generated", "archive", "config"}:
        return row["path"]

    if path.parts and path.parts[0] == "_inventory":
        return row["path"]

    def safe_name(current: Path) -> str:
        name = current.name
        if "$" not in name:
            return name
        stem = current.stem
        if stem.startswith("v$"):
            stem = stem[2:] + "_vview"
        else:
            stem = stem.replace("$", "") + "_base_table"
        stem = stem.replace(" (1)", "").replace("(1)", "")
        return stem + current.suffix

    if row["third_party"] == "yes":
        return "scripts/third_party/" + safe_name(path)
    if kind == "script":
        return "scripts/" + category_name + "/" + safe_name(path)
    if kind == "documentation":
        return "docs/" + category_name + "/" + safe_name(path)
    if kind == "generated_output":
        return "generated/" + safe_name(path)
    if kind == "archive_bundle":
        return "archive/bundles/" + safe_name(path)
    if kind == "config":
        return "config/" + safe_name(path)
    return "archive/review/" + safe_name(path)


def main() -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    files = sorted(path for path in ROOT.rglob("*") if path.is_file() and "_inventory" not in path.parts)

    hashes = {}  # type: Dict[Path, str]
    by_hash = defaultdict(list)
    for path in files:
        digest = sha256(path)
        hashes[path] = digest
        by_hash[digest].append(path)

    rows = []
    for path in files:
        rel = path.relative_to(ROOT).as_posix()
        ext = path.suffix.lower()
        kind = file_kind(path)
        text = sample_text(path) if kind in {"script", "config", "unknown"} else ""
        rows.append(
            {
                "path": rel,
                "extension": ext,
                "bytes": path.stat().st_size,
                "sha256": hashes[path],
                "kind": kind,
                "suggested_category": category(path),
                "has_header": "yes" if has_header(text) else "no",
                "third_party": "yes" if is_third_party(text) else "no",
                "duplicate_count": len(by_hash[hashes[path]]),
                "copy_style_name": "yes" if duplicate_style(path) else "no",
            }
        )

    with (OUT / "oracle_admin_inventory.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)

    with (OUT / "duplicates_exact.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["sha256", "bytes", "path"])
        writer.writeheader()
        for digest, paths in sorted(by_hash.items()):
            if len(paths) < 2:
                continue
            for path in paths:
                writer.writerow({"sha256": digest, "bytes": path.stat().st_size, "path": path.relative_to(ROOT).as_posix()})

    cleanup_rows = []
    for path in files:
        kind = file_kind(path)
        reason = cleanup_reason(path, kind, len(by_hash[hashes[path]]))
        if reason:
            cleanup_rows.append(
                {
                    "path": path.relative_to(ROOT).as_posix(),
                    "kind": kind,
                    "reason": reason,
                    "sha256": hashes[path],
                }
            )

    with (OUT / "cleanup_candidates.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["path", "kind", "reason", "sha256"])
        writer.writeheader()
        writer.writerows(cleanup_rows)

    missing_header_rows = [
        {
            "path": row["path"],
            "suggested_category": row["suggested_category"],
            "extension": row["extension"],
        }
        for row in rows
        if row["kind"] == "script" and row["has_header"] == "no" and row["third_party"] == "no"
    ]
    with (OUT / "missing_headers.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["path", "suggested_category", "extension"])
        writer.writeheader()
        writer.writerows(missing_header_rows)

    category_counts = defaultdict(lambda: {"total": 0, "scripts": 0, "missing_headers": 0})
    for row in rows:
        bucket = category_counts[row["suggested_category"]]
        bucket["total"] += 1
        if row["kind"] == "script":
            bucket["scripts"] += 1
            if row["has_header"] == "no" and row["third_party"] == "no":
                bucket["missing_headers"] += 1

    with (OUT / "category_summary.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=["suggested_category", "total", "scripts", "missing_headers"])
        writer.writeheader()
        for suggested_category, counts in sorted(category_counts.items()):
            writer.writerow({"suggested_category": suggested_category, **counts})

    target_counts = defaultdict(int)
    move_rows = []
    for row in rows:
        target = proposed_target(row)
        target_counts[target] += 1
        move_rows.append(
            {
                "current_path": row["path"],
                "proposed_path": target,
                "kind": row["kind"],
                "suggested_category": row["suggested_category"],
                "third_party": row["third_party"],
                "conflict": "pending",
            }
        )
    for row in move_rows:
        row["conflict"] = "yes" if target_counts[row["proposed_path"]] > 1 else "no"

    with (OUT / "proposed_moves.csv").open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["current_path", "proposed_path", "kind", "suggested_category", "third_party", "conflict"],
        )
        writer.writeheader()
        writer.writerows(move_rows)

    summary = [
        "# Oracle Admin Inventory",
        "",
        f"- Total files: {len(rows)}",
        f"- Exact duplicate groups: {sum(1 for paths in by_hash.values() if len(paths) > 1)}",
        f"- Cleanup candidates: {len(cleanup_rows)}",
        f"- Owned scripts missing headers: {len(missing_header_rows)}",
        "",
        "Generated files:",
        "- `oracle_admin_inventory.csv`: one row per file with kind, category, header, third-party and duplicate flags.",
        "- `duplicates_exact.csv`: files with identical SHA-256 content.",
        "- `cleanup_candidates.csv`: temporary files, copy-style names and exact duplicates to review.",
        "- `missing_headers.csv`: owned scripts that need the standard header.",
        "- `category_summary.csv`: category-level counts for planning cleanup batches.",
        "- `proposed_moves.csv`: proposed future directory layout; review conflicts before moving.",
        "",
        "Regenerate with:",
        "",
        "```bash",
        "python3 tools/oracle_admin_inventory.py",
        "```",
        "",
    ]
    (OUT / "README.md").write_text("\n".join(summary), encoding="utf-8")


if __name__ == "__main__":
    main()
