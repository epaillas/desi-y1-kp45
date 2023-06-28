#!/bin/bash
#SBATCH -J xi_cubic_post_lrg
#SBATCH -q regular
#SBATCH -N 4
#SBATCH --array=0-4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=256
#SBATCH -t 01:00:00
#SBATCH -o ./out_files/%x_%j.out
#SBATCH -e ./out_files/%x_%j.err
#SBATCH -C cpu
#SBATCH -L SCRATCH
#SBATCH -A desi

source /global/common/software/desi/users/adematti/cosmodesi_environment.sh main

c=${SLURM_ARRAY_TASK_ID}
tracer=lrg

torun="/global/homes/a/alexpzfz/alexpzfz/FiducialCosmology/correlation_function.py"

for ph in {17..24};
  do
  srun -n 4 python $torun cubicbox $tracer firstgen $ph -r recsym -ct 000 -cg 00${c}
  done
