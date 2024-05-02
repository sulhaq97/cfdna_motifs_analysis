#!/bin/bash

for eacho in $(ls /cluster/projects/lokgroup/baseline_relapse_cfMeDIP/BASELINE_RELAPSE_BAM/*.bam)
do
sbatch end_motifs.sh $eacho
done

