#!/bin/bash
#SBATCH --job-name=ripser      # Job name
#SBATCH --qos=bubenik-b			 # Use -b for burst queue
#SBATCH --mail-type=END
#SBATCH --mail-user=pedwards@ufl.edu
#SBATCH --ntasks=1                  # Number of MPI ranks
#SBATCH --mem=60gb          # Memory per processor
#SBATCH --time=96:00:00              # Time limit hrs:min:sec
#SBATCH --output=ripser_%j.log     # Standard output and error log
pwd; hostname; date
 

module load gcc
module load openmpi/2.1.2
module load python
 
/ufrc/bubenik/pedwards/ripser/ripser --dim 2 --format point-cloud --threshold 0.60 /ufrc/bubenik/pedwards/samp_algorithm/torus/14e-2_sample.txt > /ufrc/bubenik/pedwards/samp_algorithm/torus/14e-2_persistence.txt
 
date