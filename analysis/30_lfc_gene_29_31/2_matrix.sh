#!/bin/bash
# create matricies of output
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
