# SQLServer Scripts

This directory is organized for script discovery, static validation and future MCP/skill use.

## Layout

- `scripts/`: executable SQL, shell, Python and command scripts.
- `docs/`: notes and documentation.
- `config/`: templates and parameter/configuration files.
- `archive/`: bundles and material kept for reference.
- `_catalog/`: generated machine-readable metadata.

## Script Categories

- `diagnostics/sessions`: 1
- `storage`: 1
- `utilities`: 2

Generated catalog:

```bash
python3 tools/db_repo_manager.py catalog --roots SQLServer
```
