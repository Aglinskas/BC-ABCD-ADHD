#!/bin/bash

#SBATCH --job-name=job_fmriprep_sfari50
#SBATCH --output=./Data/slurm-01-fmriprep-anats/output_fmriprep_%a
#SBATCH --error=./Data/slurm-01-fmriprep-anats/error_fmriprep_%a
#SBATCH --ntasks=1
#SBATCH --time=10:00:00
#SBATCH --mem=32gb
#SBATCH --array=0-10

module load singularity/

date

#echo $HOME

#cd $HOME

data_dir=./Data/ABCDdata
output_dir=./Data/ABCD-data-use-fmriprepped
sing_image=$HOME/fmriprep-22

cd $data_dir
files=(sub*)

#cd $HOME
cd /data/aglinska/BC-ABCD-ADHD

fs_lic=$HOME'/fs_licence.txt'

sub=${files[$SLURM_ARRAY_TASK_ID]} #;echo $sub

echo "${#files[@]}"
echo $HOME
echo $data_dir
echo $output_dir
echo $sub

singularity run --bind /data/aglinska/scratch:/scratch --cleanenv $sing_image $data_dir $output_dir participant --participant-label $sub --fs-no-reconall --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only

# singularity run --bind /data/aglinska/scratch:/scratch --cleanenv $sing_image $data_dir $output_dir participant --participant-label $sub --fs-no-reconall --task-id 'rest' --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only


#fmriprep $data_dir $output_dir participant --participant-label $sub --fs-no-reconall --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only



