#!/bin/bash
# setup directory
ln -s ../5_htseq/miRNA_TAIR10.gff3 ./
ln -s ../5_htseq/33_output/*miRNA.htseq.txt ./
# cleanup htseq files
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
# create matrix of results
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R miRNA.tsv
# cleanup intermediate files
rm -f *.clean
rm -f *.txt
rm -f *.rpkm
