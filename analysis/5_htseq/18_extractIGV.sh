#!/bin/bash
# process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
for f in `ls 2_output/*.siRNA.sam`
do

for i in {21,24,29,31} 
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="18_output"

echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
module load samtools
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
cat header.sam tmp.${i}M.$lib.siRNA.sam > ./${output_dir}/${i}M.$lib.siRNA.sam
rm -f tmp.${i}M.$lib.siRNA.sam
samtools view -b ./${output_dir}/${i}M.$lib.siRNA.sam |\
samtools sort -o ./${output_dir}/${i}M.$lib.siRNA.bam -
samtools index ./${output_dir}/${i}M.$lib.siRNA.bam
/lustre/projects/staton/software/htseq-count \
-s no \
-t DMR \
-i ID \
-a 0 \
./${output_dir}/${i}M.$lib.siRNA.sam \
DMR.gff3 \
>& ./$output_dir/.${i}M.$lib.htseq.txt
grep -v "processed" ./$output_dir/${i}M.$lib.htseq.txt | grep -v "^__" > ./$output_dir/${i}M.$lib.htseq.clean.txt
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
