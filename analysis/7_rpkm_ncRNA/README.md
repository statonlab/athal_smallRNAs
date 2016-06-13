####link htseq files
```
ln -s ../5_htseq/2_output/*ncRNA*htseq.txt ./
ln -s ../5_htseq/ncRNA.gff3 ./
```
####process htseq files
```
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
```
---
####run rpkm calculation scripts
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
