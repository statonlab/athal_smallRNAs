#!/bin/bash
# run annotation script to add detailed descriptions of genes
for f in `ls 2_out_*`
do
base=`echo $f | sed 's/\.tsv//'`
./annotate_genes.pl $f > $base.ann.tsv
done
