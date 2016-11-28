#!/bin/bash
# generate htseq counts for all RNASeq results, will extract relevant TASI related genes.
for f in `ls *.merged.sorted.sam`
do

lib=`echo $f | sed 's/\.merged\.sorted\.sam//'`
output_dir="14_output"

if [ 1==1 ]; then
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
"
spe="gene"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
$lib.merged.sorted.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
fi > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
