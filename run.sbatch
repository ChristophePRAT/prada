#!/bin/bash
#SBATCH --job-name=prada
#SBATCH --partition=3090          # student dev/prototyping GPUs; see squeue -p 3090 / -p P100 for the shorter queue
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=02:00:00           # keep this honest and short: short walltimes backfill first
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --requeue
#
# Usage (run on the login node; create logs/ first, sbatch opens --output/--error before the
# script body runs):
#   mkdir -p logs
#   sbatch run.sbatch run_prada.py -ds compressed_datasets/enzymes_dataset.zip
#   sbatch run.sbatch run_classifier.py -ds compressed_datasets/enzymes_dataset.zip
#   sbatch run.sbatch run_ngrams.py -ds compressed_datasets/enzymes_dataset.zip

set -euo pipefail
mkdir -p logs

cd "$SLURM_SUBMIT_DIR"
source .venv/bin/activate

ENTRYPOINT="${1:?Usage: sbatch run.sbatch <run_prada.py|run_classifier.py|run_ngrams.py> [args...]}"
shift

python "$ENTRYPOINT" "$@"

echo "Job ${SLURM_JOB_ID} finished: $(date -u +%Y-%m-%dT%H:%MZ)"
