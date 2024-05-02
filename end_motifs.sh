#!/bin/bash
#SBATCH -t 2:00:00
#SBATCH -p himem
#SBATCH --mem=60G
#SBATCH -c 1
#SBATCH -N 1
#SBATCH -o %x-%j.out

module load samtools
module load R

# bam file name is passed as command line argument in the runner script
motifholder=${1}.motifs.txt
touch $motifholder

samtools view -h -f 2 -F 4 -F 256 $1 | \
awk '{if($1 ~ /^@/ || length($10) < 4) next; start=substr($10, 1, 4); end=substr($10, length($10)-3); print "Start: " start ", End: " end}' | \
awk '{start=substr($0, index($0, "Start:") + 7, 4); end=substr($0, index($0, "End:") + 5); print start; print end}' | sort | uniq -c > $motifholder


