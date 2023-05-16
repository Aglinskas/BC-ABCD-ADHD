#!/bin/bash
#SBATCH --job-name=T0_ABCD_fmriprep
#SBATCH --output=./Data/slurm-01-fmriprep-anats-T0/output_fmriprep_%a
#SBATCH --error=./Data/slurm-01-fmriprep-anats-T0/error_fmriprep_%a
#SBATCH --ntasks=1
#SBATCH --time=10:00:00
#SBATCH --mem=32gb
#SBATCH --array=0-1


# 4836 subjects, AA run 2836
module load singularity/

date

SLURM_ARRAY_TASK_ID=$(($SLURM_ARRAY_TASK_ID+0))

echo $SLURM_ARRAY_TASK_ID

data_dir=./Data/ABCD-data-use-T0
output_dir=./Data/ABCD-data-use-T0-fmriprepped
sing_image=$HOME/fmriprep-22

cd $data_dir
#files=(sub*)

# 344 files
files=('sub-NDARINV3H5M0JJR')

#cd $HOME
cd /data/aglinska/BC-ABCD-ADHD

fs_lic=$HOME'/fs_licence.txt'

sub=${files[$SLURM_ARRAY_TASK_ID]} #;echo $sub

# SLURM_ARRAY_TASK_ID=0
# SLURM_ARRAY_TASK_ID=$(($SLURM_ARRAY_TASK_ID+2000))
# echo $SLURM_ARRAY_TASK_ID

working_dir=/scratch/aglinska/fmriprep-workingdir/T0_${sub}
scratch_dir=/scratch/aglinska/fmriprep-scratch/T0_${sub}

## AA TODO: ADD 'export SINGULARITY_TMPDIR=' to fix rootfs issue

mkdir -p /scratch/aglinska/fmriprep-workingdir
mkdir -p /scratch/aglinska/fmriprep-scratch

chmod 777 /scratch/aglinska/fmriprep-workingdir
chmod 777 /scratch/aglinska/fmriprep-scratch

mkdir -p $working_dir
mkdir -p $scratch_dir

chmod 777 $scratch_dir
chmod 777 $working_dir

echo "${#files[@]}"
echo $HOME
echo $data_dir
echo $output_dir
echo $sub
echo work directory is: $working_dir
echo scratch directory is: $scratch_dir

singularity run --bind $scratch_dir:/scratch --cleanenv $sing_image $data_dir $output_dir -w $working_dir participant --participant-label $sub --fs-no-reconall --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only 

rm -rf $working_dir
rm -rf $scratch_dir

# singularity run --bind /data/aglinska/scratch:/scratch --cleanenv $sing_image $data_dir $output_dir participant --participant-label $sub --fs-no-reconall --task-id 'rest' --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only


#fmriprep $data_dir $output_dir participant --participant-label $sub --fs-no-reconall --fs-license-file $fs_lic --output-spaces MNI152NLin2009cAsym:res-2 --anat-only -w



