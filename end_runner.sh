#!/bin/bash

# batch run a buncha of bam files
for eacho in $(ls /DIRECTORY_WITH_BAM_FILES/*.bam)
do
# each bam file name passed as command line argument for the end_motifs.sh script
sbatch end_motifs.sh $eacho
done

