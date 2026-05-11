# postgres Scripts

This directory is organized for script discovery, static validation and future MCP/skill use.

## Layout

- `scripts/`: executable SQL, shell, Python and command scripts.
- `docs/`: notes and documentation.
- `config/`: templates and parameter/configuration files.
- `archive/`: bundles and material kept for reference.
- `_catalog/`: generated machine-readable metadata.

## Script Categories

- `backup_recovery`: 2
- `diagnostics/sessions`: 10
- `maintenance`: 5
- `performance/tuning`: 30
- `replication`: 11
- `security`: 3
- `storage`: 23
- `utilities`: 38

Generated catalog:

```bash
python3 tools/db_repo_manager.py catalog --roots postgres
```
