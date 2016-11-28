#!/bin/bash
# setup directory
declare -a arr=("three_prime_UTR" "five_prime_UTR" "exon" "promoter")
ln -s ../5_htseq/TAIR10_genes.gff3 ./
for l in "${arr[@]}"
do

ln -s ../5_htseq/30_output/*$l*htseq.txt ./
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R $l.tsv
rm -f *.clean
rm -f *.txt
rm -f *.rpkm

done
