#!/bin/bash
# sort and convert to bam
mkdir ogs_output
for f in `ls *.sam`
do
base=`echo $f | sed 's/\.sam//'`
echo "#$ -N $base
#$ -q short*
#$ -cwd
#$ -o ogs_output.txt
#$ -e ogs_error.txt
module load samtools
samtools view -b $f |\
samtools sort -O bam -T $base.tmp - > $base.bam" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
