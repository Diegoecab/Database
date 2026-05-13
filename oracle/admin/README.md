# Oracle Admin Scripts

Oracle administration scripts normalized for discovery, static validation and
future MCP/skill use.

## Layout

- `scripts/backup_recovery`: RMAN, Data Guard, restore and export/import helpers.
- `scripts/diagnostics`: ASH, AWR, sessions, waits and troubleshooting queries.
- `scripts/performance`: SQL tuning, plans, profiles and statistics helpers.
- `scripts/storage`: ASM, ACFS, tablespace, datafile and space reports.
- `scripts/security`: audit, users, roles, grants and privilege scripts.
- `scripts/cloud`: AWS, RDS, DMS and OCI administration helpers.
- `scripts/platform`: RAC, Exadata and OS/platform-specific scripts.
- `scripts/maintenance`: scheduler, jobs, invalid objects and maintenance tasks.
- `scripts/utilities`: general SQL and shell utilities.
- `scripts/third_party`: vendor/community scripts kept separate from owned code.
- `docs/`: reference notes and documents.
- `config/`: `.par`, `.cfg`, `.ora`, JSON and other configuration files.
- `archive/`: retained bundles and review material.
- `_catalog/`: generated inventory, cleanup and validation reports.
- `_inventory/`: Oracle-specific legacy inventory reports.

## Header Standard

Owned scripts use a normalized metadata header with file, purpose, category,
author, version, usage, parameters, requirements, risk, output, notes, source and
change log. Third-party scripts are stored under `scripts/third_party/`; their
license/comment blocks should remain intact when future edits are made.

## Naming Rules

- Prefer lowercase `snake_case` names.
- Avoid spaces, accents, shell metacharacters and copy suffixes like `(1)`.
- Avoid `$` in filenames. Oracle dynamic performance view scripts use the object
  name without `v$`; collision cases use `_vview`, and internal base table cases
  use `_base_table`.
- Keep extension semantics clear: `.sql`, `.sh`, `.ksh`, `.rman`, `.cmd`,
  `.bat`, `.ps1`, `.py`, `.pl`, `.vbs`.
- Environment-specific configuration files may remain duplicated when the path
  carries operational meaning, for example `dev/`, `qa` and `prod` parfiles.

## Validation

Regenerate Oracle and global catalog metadata:

```bash
python3 tools/db_repo_manager.py catalog --roots oracle/admin
python3 tools/db_repo_manager.py catalog
```

Validate the repository:

```bash
python3 tools/db_repo_manager.py validate
```

Useful generated files:

- `oracle/admin/_catalog/scripts_catalog.json`
- `oracle/admin/_catalog/inventory.csv`
- `oracle/admin/_catalog/cleanup_candidates.csv`
- `oracle/admin/_catalog/validation_report.json`
- `_catalog/scripts_catalog.json`
