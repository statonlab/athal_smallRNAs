####link htseq files
```
ln -s ../5_htseq/8_output/*htseq.txt ./
```
####link "promoter" (2kb region upstream of gene) gff
```
ln -s ../5_htseq/gene_2kb.gff3 ./
```
####link DMRs from methylation project
```
ln -s /lustre/projects/staton/projects/athal_methylation/analysis/7_overlaps_with_genes/AllResults_v2.tsv ./
```
####cleanup htseq files
```
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
```
---
####calculate rpkms and create matrix. Also create matrix of raw counts
```
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R
Rscript create_raw_matrix.R
```
---
####cleanup directory
```
rm -f *.clean
rm -f *.txt 
rm -f *.rpkm
```
####fix file name
```
mv gene_rpkms.tsv siRNA_gene_lengths_rpkms.tsv
```
####cleanup output file
```
sed -i 's/M	/	/g' siRNA_gene_lengths_rpkms.tsv
sed -i 's/M$//g' siRNA_gene_lengths_rpkms.tsv
sed -i 's/\.gene//g' siRNA_gene_lengths_rpkms.tsv
sed -i 's/\.siRNA\.//g' siRNA_gene_lengths_rpkms.tsv
```
---
####run methyl_index_gene.pl @ 5 and 10 time points using the inputs AllResults from the methlation study along with a matrix of reads alinged to genes.
```
module load statonperl
perl methyl_index_gene.pl 5 AllResults_v2.tsv siRNA_raw.tsv
perl methyl_index_gene.pl 10 AllResults_v2.tsv siRNA_raw.tsv
```
---
