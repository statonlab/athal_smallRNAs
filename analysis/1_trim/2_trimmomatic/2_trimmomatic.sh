#!/bin/bash
# submit trimmomatic jobs to the newton cluster for each trimmed fastq file in the directory
for f in `ls *.fastq.gz`
do
base=`echo $f | sed 's/\.fastq\.gz//'`
qsub -cwd -q short* -b y java -Xmx4G -jar /lustre/projects/staton/software/Trimmomatic-0.35/trimmomatic-0.35.jar SE -trimlog $base.trimlog $f $base.trimmed.fastq ILLUMINACLIP:/lustre/projects/staton/software/Trimmomatic-0.35/adapters/illuminaClipping.fa:2:30:10 >& ./$base.trimmomatic.txt
done
