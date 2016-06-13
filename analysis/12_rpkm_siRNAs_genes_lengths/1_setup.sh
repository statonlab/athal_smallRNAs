#!/bin/bash
# link htseq files
ln -s ../5_htseq/8_output/*htseq.txt ./
# link "promoter" (2kb region upstream of gene) gff
ln -s ../5_htseq/gene_2kb.gff3 ./
# link DMRs from methylation project
ln -s /lustre/projects/staton/projects/athal_methylation/analysis/7_overlaps_with_genes/AllResults_v2.tsv ./
# cleanup htseq files
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
