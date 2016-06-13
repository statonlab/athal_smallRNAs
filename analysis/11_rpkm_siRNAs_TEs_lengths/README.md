####link htseq files
```
ln -s ../5_htseq/7_output/*htseq.txt ./
ln -s ../5_htseq/transposable_element_2kb.gff3 ./
```
####link methylation info file
```
ln -s /lustre/projects/staton/projects/athal_methylation/analysis/13_TE_regions/TE_methylation_info.tsv ./
```
####cleanup htseq files
```
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
```
---
####create raw matrix of counts
```
Rscript create_raw_matrix.R
```
---
####cleanup directory
```
rm -f *.clean
rm -f *.txt 
rm -f *.rpkm
```
####rename file to something more appropriate
```
mv gene_rpkms.tsv siRNA_TEs_lengths_rpkms.tsv
```
####fix issues in the file
```
sed -i 's/M	/	/g' siRNA_TEs_lengths_rpkms.tsv
sed -i 's/M$//g' siRNA_TEs_lengths_rpkms.tsv
sed -i 's/\.transposable_element//g' siRNA_TEs_lengths_rpkms.tsv
sed -i 's/\.siRNA\.//g' siRNA_TEs_lengths_rpkms.tsv
```
---
####run methyl_index_gene.pl @ 5 and 10 time points using the inputs AllResults from the methlation study along with a matrix of reads alinged to genes.
```
module load statonperl
perl methyl_index_TE.pl 5 TE_methylation_info.tsv siRNA_raw.tsv
perl methyl_index_TE.pl 10 TE_methylation_info.tsv siRNA_raw.tsv
```
---
