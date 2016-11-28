#!/bin/bash
# find siRNAs that overlap with genes, we are going to use this output for finding TASIs
for f in `ls 2_output/*.siRNA.sam`
do

lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="11_output"
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
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
$f \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.siRNA.sam > ./$output_dir/$lib.$spe.siRNA.parse.sam
rm -f tmp.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
