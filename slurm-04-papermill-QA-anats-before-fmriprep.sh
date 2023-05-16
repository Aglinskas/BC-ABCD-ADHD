#!/bin/bash
#SBATCH --job-name=papermill-split-frames
#SBATCH --output=./Data/papermill-output-04-QA-anats-before-fmriprep.txt
#SBATCH --error=./Data/papermill-errors-04-QA-anats-before-fmriprep.txt
#SBATCH --ntasks=1
#SBATCH --mem=64gb
#SBATCH --time=48:00:00


notebook_name=04-QA-anats-before-fmriprep.ipynb
outname=04-QA-anats-before-fmriprep-papermilled.ipynb

echo $notebook_name
echo $outname

## pip install papermill
## https://papermill.readthedocs.io/en/latest/installation.html#installing-papermill
papermill $notebook_name $outname --autosave-cell-every 5 --progress-bar









