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
uv sync --dev
/bin/python3 scripts/validate_template.py
```

## Template Validation

The template repository validates itself by rendering a temporary sample
extension and running its generated test suite.

Run it locally with:

```bash
/bin/python3 scripts/validate_template.py
```

The same check also runs in GitHub Actions via
`.github/workflows/template-validation.yml`.

## What You Get

- PEP 420-compatible package layout under `owi.metadatabase.<extension>`
- uv + invoke + pre-commit setup for development workflow
- ruff + ty quality checks
- pytest with doctest support
- MkDocs skeleton
- Release-first GitHub Actions workflows matching the live extension repos
