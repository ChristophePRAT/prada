#!/bin/bash
# Sets up a uv-managed virtualenv for PRADA on the LTCI cluster.
# Run once on a login node, from the repo root: bash install.sh
set -euo pipefail

cd "$(dirname "$0")"

uv venv --python 3.9 .venv
source .venv/bin/activate

uv pip install --extra-index-url https://download.pytorch.org/whl/cu117 -r requirements.txt

echo "Done. Activate with: source .venv/bin/activate"
