#!/bin/bash
# make minor modifications to gff files to work with HTSeq
for file in /lustre/projects/staton/projects/athal_methylation/analysis/6_methylKit/output/gff3_2/*
do
base=$(basename $file)
cat $file | sed 's/^Chr//g' | sed 's/region/DMR/g' > 16_$base.gff3
done 
