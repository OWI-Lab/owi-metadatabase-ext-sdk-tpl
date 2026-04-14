#!/usr/bin/env bash
# Load CSV data files from /data into PostgreSQL tables.
#
# Each CSV file in /data/*.csv is loaded into a table whose name matches the
# file stem (e.g. records.csv → records).
#
# Usage:
#   This script is automatically executed by the PostgreSQL Docker entrypoint
#   when the container starts for the first time.
#
# The PGPASSWORD, PGUSER and PGDATABASE environment variables are set by
# docker-compose (via the POSTGRES_* variables) before this script runs.

set -euo pipefail

DATA_DIR="/data"

if [ ! -d "$DATA_DIR" ]; then
    echo "No data directory found at $DATA_DIR, skipping CSV load."
    exit 0
fi

shopt -s nullglob
csv_files=("$DATA_DIR"/*.csv)

if [ "${#csv_files[@]}" -eq 0 ]; then
    echo "No CSV files found in $DATA_DIR, skipping CSV load."
    exit 0
fi

for csv_file in "${csv_files[@]}"; do
    table_name="$(basename "$csv_file" .csv)"

    # Validate table name: only allow alphanumeric characters and underscores
    # to prevent SQL injection via malicious file names.
    if [[ ! "$table_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
        echo "WARNING: Skipping '$csv_file' — table name '$table_name' contains invalid characters." >&2
        continue
    fi

    echo "Loading $csv_file into table '$table_name'..."
    psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" \
        -c "\COPY ${table_name} FROM '${csv_file}' CSV HEADER"
    echo "  → Done."
done

echo "CSV data load complete."
