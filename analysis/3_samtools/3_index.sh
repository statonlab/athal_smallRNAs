#!/bin/bash
# index bam files
for f in `ls *.bam`
do
base=`echo $f | sed 's/\.bam//'`
echo "#$ -N $base
#$ -q short*
#$ -cwd
#$ -o ogs_output.txt
#$ -e ogs_error.txt
module load samtools
samtools index $f
samtools view $f > $base.sorted.sam" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
