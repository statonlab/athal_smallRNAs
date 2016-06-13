####link htseq files
```
ln -s ../5_htseq/6_output/*htseq.txt ./
ln -s ../5_htseq/gene.gff3 ./
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
sed -i 's/\.gene\.siRNA\.//g' siRNAs_genes_rpkm.tsv
```
---
