# Database Scripts

Repository of database and platform administration scripts organized for static
discovery, validation, and future MCP/skill integration.

## Engines

- `oracle/admin`: Oracle administration, RMAN, diagnostics, tuning, security,
  storage, cloud and third-party scripts.
- `postgres`: PostgreSQL and Aurora PostgreSQL scripts.
- `SQLServer`: SQL Server scripts.
- `mysql`: MySQL scripts.
- `db2`: DB2 scripts.
- `mongodb`: MongoDB/DocumentDB scripts.
- `aws`: AWS CLI, DMS, RDS, CloudFormation and Terraform material.
- `os`: Linux and Windows operational helpers.

## Layout

Each engine follows the same structure where applicable:

- `scripts/`: executable SQL, shell, Python, PowerShell, command and RMAN files.
- `docs/`: notes and reference documents.
- `config/`: parameter files, templates and infrastructure configuration.
- `archive/`: bundles or material retained for reference.
- `_catalog/`: generated metadata used for discovery and validation.

The global script catalog is `_catalog/scripts_catalog.json`.

## Maintenance

Regenerate catalogs after file moves or script edits:

```bash
python3 tools/db_repo_manager.py catalog
```

Validate headers, generated outputs, unsafe names and secret-like values:

```bash
python3 tools/db_repo_manager.py validate
```

Add standard headers to scripts missing metadata:

```bash
python3 tools/db_repo_manager.py add-headers
```

Organize new unclassified files into the standard layout:

```bash
python3 tools/db_repo_manager.py organize --delete-generated
```

No database script should be executed as part of repository validation.
