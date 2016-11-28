#!/bin/bash
# process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
for f in `ls 2_output/*.siRNA.sam`
do

for i in {20..25} 
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="13_output"
spe="intron"

echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i Parent \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.siRNA.sam \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
