####link htseq output files
```
ln -s ../5_htseq/2_output/*miRNA_TAIR10*htseq.txt ./
ln -s ../5_htseq/miRNA_TAIR10.gff3 ./
```
####process htseq files
```
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
```
---
####run rpkm scripts
```
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R
```
---
####cleanup directory
```
rm -f *.clean
rm -f *.txt 
rm -f *.rpkm
```
---
