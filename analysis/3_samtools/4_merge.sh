#!/bin/bash
# need to merge technical replicates into biological replicates
for i in {1..12}
do
base=`echo $f | sed 's/\.bam//'`
files=`ls *-${i}-*.bam | sed ':a;N;$!ba;s/\n/ /g'`
if [[ $i == [1-9] ]]
then
	fix=`echo "0"$i`
else
	fix=`echo $i`
fi
echo "#$ -N TH-${fix}
#$ -q short*
#$ -cwd
#$ -o ogs_output.txt
#$ -e ogs_error.txt
module load samtools
samtools merge TH-${fix}.merged.bam $files
samtools sort -n TH-${fix}.merged.bam > TH-$fix.merged.sorted.bam
samtools index TH-${fix}.merged.sorted.bam
samtools view -h TH-${fix}.merged.sorted.bam > TH-${fix}.merged.sorted.sam" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
rm -f TH-${fix}.merged.bam
done
