#!/bin/bash
# loop through all the compressed files and run quality checks on them
for f in `ls *.fastq.gz`
do
qsub -cwd -q short* -b y /lustre/projects/staton/software/FastQC-v0.11.4/fastqc -o ./ $f
done
