#!/bin/bash
# process each of the miRNA.sam files to see what transposable_elements they overlap with each miRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
for f in `ls 2_output/*.miRNA_TAIR10.sam`
do

for i in {20..25} 
do
lib=`echo $f | sed 's/\.miRNA_TAIR10\.sam//' | sed 's/2_output\///g'`
output_dir="10_output"
spe="miRNA_TAIR10"

echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.miRNA_TAIR10.sam > tmp.${i}M.$lib.miRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.miRNA.sam \
tmp.${i}M.$lib.miRNA.sam \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.miRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.miRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.miRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.miRNA.sam > ./$output_dir/$lib.$spe.${i}M.miRNA.parse.sam
rm -f tmp.${i}M.$lib.miRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
