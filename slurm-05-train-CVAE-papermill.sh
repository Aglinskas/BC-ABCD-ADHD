#!/bin/bash
#SBATCH --job-name=ABCD_train_CVAE-1
#SBATCH --output=ABCD_train_CVAE_output-1.txt
#SBATCH --error=ABCD_train_CVAE_errors-1.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gpus-per-node=4
#SBATCH --time=48:00:00
#SBATCH --mem=64gb
#SBATCH --mail-user=aglinska@bc.edu
#SBATCH --mail-type=FAIL
#SBATCH --partition=gpuv100


bash
module load tensorflow/2.3.1gpu

notebook_name='09-abcd-train-cvae.ipynb'
outname='09-abcd-train-cvae-papermill-4.ipynb'

papermill $notebook_name $outname --autosave-cell-every 5 --progress-bar

