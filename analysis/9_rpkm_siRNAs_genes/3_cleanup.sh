#!/bin/bash
# cleanup directory
rm -f *.clean
rm -f *.txt 
rm -f *.rpkm
sed -i 's/\.gene\.siRNA\.//g' siRNAs_genes_rpkm.tsv
