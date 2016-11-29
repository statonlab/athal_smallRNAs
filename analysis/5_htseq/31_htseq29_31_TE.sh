#!/bin/bash
# process each of the miRNA.sam files to see what transposable_elements they overlap with each miRNA.sam file is separated into 29,31 bps.
for f in `ls 2_output/*.siRNA.sam`
do

for i in {29,31} 
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="31_output"
spe="transposable_element"

echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.$spe.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t transposable_element_gene \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
tmp.${i}M.$lib.$spe.sam \
./transposable_element_2kb.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.sam > ./$output_dir/$lib.$spe.${i}M.parse.sam
rm -f tmp.${i}M.$lib.$spe.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
