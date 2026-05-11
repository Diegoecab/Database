# aws Scripts

This directory is organized for script discovery, static validation and future MCP/skill use.

## Layout

- `scripts/`: executable SQL, shell, Python and command scripts.
- `docs/`: notes and documentation.
- `config/`: templates and parameter/configuration files.
- `archive/`: bundles and material kept for reference.
- `_catalog/`: generated machine-readable metadata.

## Script Categories

- `cloud/cli`: 4
- `cloud/cloud9`: 1
- `cloud/dms`: 17
- `cloud/ec2`: 3
- `cloud/kms`: 1
- `cloud/lambda`: 1
- `cloud/rds`: 29
- `cloud/s3`: 1
- `infra/cloudformation`: 1

Generated catalog:

```bash
python3 tools/db_repo_manager.py catalog --roots aws
```
