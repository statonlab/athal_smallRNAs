#!/bin/bash
# cleanup directory
rm -f *.clean
rm -f *.txt 
rm -f *.rpkm
# fix file name
mv gene_rpkms.tsv siRNA_gene_lengths_rpkms.tsv
# cleanup output file
sed -i 's/M	/	/g' siRNA_gene_lengths_rpkms.tsv
sed -i 's/M$//g' siRNA_gene_lengths_rpkms.tsv
sed -i 's/\.gene//g' siRNA_gene_lengths_rpkms.tsv
sed -i 's/\.siRNA\.//g' siRNA_gene_lengths_rpkms.tsv
