#!/bin/bash
# process files for reads that overlap with genes
for f in `ls *.merged.sorted.bam`
do
lib=`echo $f | sed 's/\.merged\.sorted\.bam//'`
output_dir="4_output"
spe="gene"

echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-f bam \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
$lib.merged.sorted.bam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam" > sub.ogs
qsub sub.ogs
rm -f sub.ogs

done
