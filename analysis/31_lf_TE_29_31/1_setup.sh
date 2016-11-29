#!/bin/bash
# setup directory
ln -s ../5_htseq/transposable_element_2kb.gff3 ./
ln -s ../5_htseq/31_output/*.htseq.txt ./
# cleanup htseq files
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
# create matrix of results
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R TE.tsv
# cleanup intermediate files
rm -f *.clean
rm -f *.txt
rm -f *.rpkm
