#!/bin/bash
#SBATCH --job-name=clear_scratch
#SBATCH --output=./Data/slurm-02-clear-scratch-output.txt
#SBATCH --error=./Data/slurm-02-clear-scratch-errors.txt
#SBATCH --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --mem=64gb

cd /scratch/aglinska/
conts=(./rootfs*)
echo ${conts[0]}
n=${#conts[@]}
echo $n

i=0
for cont in "${conts[@]}"
do
	i=$((i+1))

	echo removing $cont $i/$n
	date
	rm -rf $cont
	echo removed $cont $i/$n
	date

done


