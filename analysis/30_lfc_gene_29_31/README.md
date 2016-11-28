####setup directory
```
declare -a arr=("three_prime_UTR" "five_prime_UTR" "exon" "promoter")
ln -s ../5_htseq/TAIR10_genes.gff3 ./
for l in "${arr[@]}"
do
ln -s ../5_htseq/30_output/*$l*htseq.txt ./
for f in *.txt
do
grep -v "processed" $f | grep -v "^__" > $f.clean
done
perl calculate_rpkms.pl
Rscript create_rpkm_matrix.R $l.tsv
rm -f *.clean
rm -f *.txt
rm -f *.rpkm
done
```
---
####create matricies of output
```
module load statonperl
#perl methyl_index.pl TE_methylation_info.tsv siRNA_TEs_lengths_rpkms.tsv
#perl methyl_index.pl TE_methylation_info.tsv TEST_siRNA.tsv
#perl methyl_index.pl TE_methylation_info.tsv siRNA_gene_lengths_rpkms.tsv
#perl matrix_index.pl siRNA_raw_TEST.tsv
#perl matrix_index.pl siRNA_raw.tsv
#perl matrix_index.pl five_prime_UTR.tsv > 2_out_5UTR.tsv
perl matrix_index_29_31.pl exon.tsv > 2_out_exon.tsv
perl matrix_index_29_31.pl five_prime_UTR.tsv > 2_out_5UTR.tsv
perl matrix_index_29_31.pl three_prime_UTR.tsv > 2_out_3UTR.tsv
perl matrix_index_29_31.pl promoter.tsv > 2_out_promoter.tsv
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
