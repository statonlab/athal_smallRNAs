#!/bin/bash
# cleanup directory
rm -f *.clean
rm -f *.txt 
rm -f *.rpkm
sed -i 's/\.transposable_element\.siRNA\.//g' siRNA_TEs_rpkms.tsv
