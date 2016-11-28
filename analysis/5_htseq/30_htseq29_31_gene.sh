#!/bin/bash
# process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
declare -a arr=("three_prime_UTR" "five_prime_UTR" "exon" "promoter")
for f in `ls 2_output/*.siRNA.sam`
do

for i in {29,31} 
do
for l in "${arr[@]}"
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="30_output"
spe=$l

echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.$spe.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i Parent \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.$spe.siRNA.sam \
TAIR10_genes.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.$spe.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
done
