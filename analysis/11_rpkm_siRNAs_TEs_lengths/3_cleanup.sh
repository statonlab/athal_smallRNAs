#!/bin/bash
# cleanup directory
rm -f *.clean
rm -f *.txt 
rm -f *.rpkm
# rename file to something more appropriate
mv gene_rpkms.tsv siRNA_TEs_lengths_rpkms.tsv
# fix issues in the file
sed -i 's/M	/	/g' siRNA_TEs_lengths_rpkms.tsv
sed -i 's/M$//g' siRNA_TEs_lengths_rpkms.tsv
sed -i 's/\.transposable_element//g' siRNA_TEs_lengths_rpkms.tsv
sed -i 's/\.siRNA\.//g' siRNA_TEs_lengths_rpkms.tsv
