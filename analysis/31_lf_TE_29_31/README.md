####setup directory
```
ln -s ../5_htseq/transposable_element_2kb.gff3 ./
ln -s ../5_htseq/31_output/*.htseq.txt ./
```
####cleanup htseq files
```
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
```
####create matrix of results
```
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R TE.tsv
```
####cleanup intermediate files
```
rm -f *.clean
rm -f *.txt
rm -f *.rpkm
```
---
####create matricies of output
```
module load statonperl
perl matrix_index_29_31.pl TE.tsv > 2_out_TE.tsv
#perl matrix_index_new.pl miRNA.tsv
```
---
####run annotation script to add detailed descriptions of genes
```
for f in `ls 2_out_*`
do
base=`echo $f | sed 's/\.tsv//'`
./annotate_genes.pl $f > $base.ann.tsv
done
```
---
