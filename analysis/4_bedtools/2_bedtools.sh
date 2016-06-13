#!/bin/bash
# 
for f in `ls *.bam`
do
base=`echo $f | sed 's/\.bam//'`
echo "#$ -N $base
#$ -q short*
#$ -cwd
#$ -l mem=40G,cores_per_node=24
#$ -o ogs_output.txt
#$ -e ogs_error.txt

# extract siRNAs
# subtract, remove any reads that overlap AT ALL (this is what -A does)
# with any features.
# non_siRNAs.bed in a concatentation of TAIR10 annotations of tRNAs,
# miRNAs, ncRNAs, rRNAs, snoRNAs, snRNAs, and the contents of miRBase.
/lustre/projects/staton/software/bedtools-2.25/bin/bedtools subtract \
-a $base.bam \
-A \
-b non_siRNAs.gff3 > ./2_output/siRNA.$base.bam

# extract tRNAs
# by using the -f 1 flag we insure that for the read to be counted it has to have
# complete overlap with the feature from the gff3 file.
/lustre/projects/staton/software/bedtools-2.25/bin/bedtools intersect \
-abam $base.bam \
-b tRNA.gff3 \
-f 1 > ./2_output/tRNA.$base.bam

# extract miRNA
/lustre/projects/staton/software/bedtools-2.25/bin/bedtools intersect \
-abam $base.bam \
-b miRNA.gff3 \
-f 1 > ./2_output/miRNA.$base.bam

# ncRNA
/lustre/projects/staton/software/bedtools-2.25/bin/bedtools intersect \
-abam $base.bam \
-b ncRNA.gff3 \
-f 1 > ./2_output/ncRNA.$base.bam

# rRNA
/lustre/projects/staton/software/bedtools-2.25/bin/bedtools intersect \
-abam $base.bam \
-b rRNA.gff3 \
-f 1 > ./2_output/rRNA.$base.bam

# snoRNA
/lustre/projects/staton/software/bedtools-2.25/bin/bedtools intersect \
-abam $base.bam \
-b snoRNA.gff3 \
-f 1 > ./2_output/snoRNA.$base.bam

# snRNA
/lustre/projects/staton/software/bedtools-2.25/bin/bedtools intersect \
-abam $base.bam \
-b snRNA.gff3 \
-f 1 > ./2_output/snRNA.$base.bam" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
