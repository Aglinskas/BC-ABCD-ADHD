#!/bin/bash
#SBATCH --job-name=make-brain-arr
#SBATCH --output=./Data/slrum-03-make-brain-arr/output_%a
#SBATCH --error=./Data/slrum-03-make-brain-arr/error_%a
#SBATCH --ntasks=1
#SBATCH --time=01:00:00
#SBATCH --mem=16gb
#SBATCH --array=0-2836

# 4836,2000,2836
SLURM_ARRAY_TASK_ID=$(($SLURM_ARRAY_TASK_ID+2000)) # For batching 

notebook_name=06-make-brain-arr.ipynb
outname=./Data/papermill-03-make-brain-arr/06-make-brain-arr-$SLURM_ARRAY_TASK_ID.ipynb

echo $SLURM_ARRAY_TASK_ID
echo $notebook_name
echo $outnames

papermill $notebook_name $outname --autosave-cell-every 5 --progress-bar -p s $SLURM_ARRAY_TASK_ID