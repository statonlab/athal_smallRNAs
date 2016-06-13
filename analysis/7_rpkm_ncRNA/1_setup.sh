#!/bin/bash
# link htseq files
ln -s ../5_htseq/2_output/*ncRNA*htseq.txt ./
ln -s ../5_htseq/ncRNA.gff3 ./
# process htseq files
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
