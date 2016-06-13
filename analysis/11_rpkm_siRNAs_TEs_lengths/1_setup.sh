#!/bin/bash
# link htseq files
ln -s ../5_htseq/7_output/*htseq.txt ./
ln -s ../5_htseq/transposable_element_2kb.gff3 ./
# link methylation info file
ln -s /lustre/projects/staton/projects/athal_methylation/analysis/13_TE_regions/TE_methylation_info.tsv ./
# cleanup htseq files
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
