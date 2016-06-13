####link htseq files
```
ln -s ../5_htseq/7_output/*htseq.txt ./
ln -s ../5_htseq/transposable_element.gff3 ./
```
####cleanup htseq files
```
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
```
---
####calculate rpkms
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
sed -i 's/\.transposable_element\.siRNA\.//g' siRNA_TEs_rpkms.tsv
```
---
