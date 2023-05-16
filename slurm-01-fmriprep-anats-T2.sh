#!/bin/bash

#SBATCH --job-name=T2-ABCD-fmriprep
#SBATCH --output=./Data/slurm-01-fmriprep-anats-T2/output_fmriprep_%a
#SBATCH --error=./Data/slurm-01-fmriprep-anats-T2/error_fmriprep_%a
#SBATCH --ntasks=1
#SBATCH --time=10:00:00
#SBATCH --mem=32gb
#SBATCH --array=11-4836%50


# 4034 subjects
module load singularity/

date


data_dir=./Data/ABCD-data-use-T2
output_dir=./Data/ABCD-data-use-T2-fmriprepped
sing_image=$HOME/fmriprep-22

cd $data_dir
files=(sub*)

#cd $HOME
cd /data/aglinska/BC-ABCD-ADHD

fs_lic=$HOME'/fs_licence.txt'

sub=${files[$SLURM_ARRAY_TASK_ID]} #;echo $sub

working_dir=./Data/fmriprep-workingdir/T2_${sub}
mkdir -p $working_dir

echo "${#files[@]}"
echo $HOME
echo $data_dir
echo $output_dir
echo $sub
echo work directory is: $working_dir

singularity run --bind /data/aglinska/scratch:/scratch --cleanenv $sing_image $data_dir $output_dir -w $working_dir participant --participant-label $sub --fs-no-reconall --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only

rm -rf $working_dir

# singularity run --bind /data/aglinska/scratch:/scratch --cleanenv $sing_image $data_dir $output_dir participant --participant-label $sub --fs-no-reconall --task-id 'rest' --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only



#fmriprep $data_dir $output_dir participant --participant-label $sub --fs-no-reconall --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only



