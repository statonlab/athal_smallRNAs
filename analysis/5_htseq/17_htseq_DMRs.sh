#!/bin/bash
# process files for reads that overlap with genes
s=1
for f in `ls 2_output/*.siRNA.sam`
do
for i in {20..25}
do

lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="17_output"
spe="DMR"

echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt" > sub.ogs

for gff3 in `ls 16_*.gff3`
do
base=$(echo $gff3 | sed 's/16_//g' | sed 's/\.gff3//g')

echo "grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.${i}M.$base.sam \
tmp.${i}M.$lib.siRNA.sam \
$gff3 \
>& ./$output_dir/$lib.$spe.${i}M.$base.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.$base.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.$base.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.$base.sam > ./$output_dir/$lib.$spe.${i}M.$base.parse.sam
rm -f tmp.${i}M.$lib.siRNA.sam" >> sub.ogs
done
qsub sub.ogs
rm -f sub.ogs
s=$(($s+1))
echo $s
done
done
