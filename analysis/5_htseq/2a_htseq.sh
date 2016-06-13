#!/bin/bash
# go through all of the merged biological replicates and run htseq for each of the filters:
# rRNA, tRNA, snoRNA, snRNA, ncRNA, miRNA (TAIR10), miRNA (miRBase)
# final resulting .sam file will be named TH-##.siRNA.sam, these will need to be filtered for length
#for f in `ls *.merged.sorted.bam`
#do

f=TH-01.merged.sorted.sam

lib=`echo $f | sed 's/\.merged\.sorted\.sam//'`
output_dir="2_output"

if [ 1==1 ]; then
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
"
spe="rRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-f sam \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
$lib.merged.sorted.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="tRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"

prespe=$spe
spe="snoRNA"

echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"

prespe=$spe
spe="snRNA"

echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"

prespe=$spe
spe="ncRNA"

echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"

prespe=$spe
spe="miRNA_TAIR10"
##
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"

prespe=$spe
spe="miRNA_miRBase"
##
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt

grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
cp ./$output_dir/$lib.$spe.nohit.sam ./$output_dir/$lib.siRNA.sam"
fi > sub.ogs
qsub sub.ogs
rm -f sub.ogs
#done
