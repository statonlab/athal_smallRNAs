#!/bin/bash
# run methyl_index_gene.pl @ 5 and 10 time points using the inputs AllResults from the methlation study along with a matrix of reads alinged to genes.
module load statonperl
perl methyl_index_gene.pl 5 AllResults_v2.tsv siRNA_raw.tsv
perl methyl_index_gene.pl 10 AllResults_v2.tsv siRNA_raw.tsv
