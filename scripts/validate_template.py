"""Render the copier template and run a smoke-test suite on the generated project."""

from __future__ import annotations

import shutil
import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def run_command(*args: str, cwd: Path) -> None:
    """Run a subprocess and fail fast on any non-zero exit code."""
    subprocess.run(args, cwd=cwd, check=True)


def main() -> int:
    """Render a sample extension from the template and run its tests."""
    temp_root = Path(tempfile.mkdtemp(prefix="owi-metadatabase-template-"))
    sample_project = temp_root / "sample-extension"

    try:
        run_command(
            "uvx",
            "copier",
            "copy",
            "-f",
            str(ROOT),
            str(sample_project),
            "--data",
            "project_name=sample",
            "--data",
            "project_slug=sample",
            "--data",
            "project_description=Sample extension for OWI Metadatabase SDK",
            "--data",
            "author_name=OWI-Lab",
            "--data",
            "author_email=info@owi-lab.be",
            "--data",
            "python_version=3.9",
            "--data",
            "base_package_version=0.1.0",
            "--data",
            "include_visualization=false",
            "--data",
            "include_numerical=false",
            cwd=ROOT,
        )
        run_command("uv", "sync", "--all-packages", "--all-extras", "--all-groups", cwd=sample_project)
        run_command("uv", "run", "pytest", cwd=sample_project)
        return 0
    finally:
        shutil.rmtree(temp_root, ignore_errors=True)


if __name__ == "__main__":
    raise SystemExit(main())