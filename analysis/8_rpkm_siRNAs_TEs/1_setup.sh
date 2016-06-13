#!/bin/bash
# link htseq files
ln -s ../5_htseq/7_output/*htseq.txt ./
ln -s ../5_htseq/transposable_element.gff3 ./
# cleanup htseq files
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
