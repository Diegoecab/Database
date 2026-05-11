# Oracle Admin Inventory

- Total files: 1827
- Exact duplicate groups: 1
- Cleanup candidates: 0
- Owned scripts missing headers: 0

Generated files:
- `oracle_admin_inventory.csv`: one row per file with kind, category, header, third-party and duplicate flags.
- `duplicates_exact.csv`: files with identical SHA-256 content.
- `cleanup_candidates.csv`: temporary files, copy-style names and exact duplicates to review.
- `missing_headers.csv`: owned scripts that need the standard header.
- `category_summary.csv`: category-level counts for planning cleanup batches.
- `proposed_moves.csv`: proposed future directory layout; review conflicts before moving.

Regenerate with:

```bash
python3 tools/oracle_admin_inventory.py
```
