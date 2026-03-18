# OWI Metadatabase Extension SDK Template

Copier template for creating extension packages that plug into the
`owi.metadatabase` namespace.

## Usage

```bash
# Install copier
uv tool install copier

# Generate a new extension (example: soil)
copier copy \
  /path/to/owi-metadatabase-extension-sdk-template \
  owi-metadatabase-soil-sdk
```

## Local Development

```bash
cd owi-metadatabase-soil
uv sync --dev
uv run invoke test.run
uv run invoke qa.all
uv run invoke docs.build
```

## What You Get

- PEP 420-compatible package layout under `owi.metadatabase.<extension>`
- uv + invoke + pre-commit setup for development workflow
- ruff + ty quality checks
- pytest with doctest support
- MkDocs skeleton
