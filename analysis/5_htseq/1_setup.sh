#!/bin/bash
# create directories for bedtools output
mkdir ogs_output
mkdir 2_output
# link samfiles 
ln -s ../3_samtools/*.merged.sorted.bam ./
# links for our databases
ln -s ../../archive/ath_miRBase.gff3 ./
ln -s ../../archive/TAIR10_GFF3_genes.gff ./
ln -s ../../archive/TAIR10_RNA.gff3 ./
# extract relevant classifications from the TAIR10 annotations
grep "transposable_element" TAIR10_GFF3_genes.gff | sed 's/Chr//g' > transposable_element.gff3
awk 'OFS="\t" {print $1,$2,$3,$4-2000,$5+2000,$6,$7,$8,$9}' transposable_element.gff3 | sed -i 's/-1677/1/g' > transposable_element_2kb.gff3
awk 'OFS="\t" {print $1,$2,$3,$4-2000,$5,$6,$7,$8,$9}' gene.gff3 | sed 's/     -[0-9]\+/       1/g' > gene_2kb.gff3
awk 'OFS="\t" {print $1,$2,$3,$4-2000,$4,$6,$7,$8,$9}' gene.gff3 | sed 's/	-[0-9]\+/v	1/g' | sed 's/gene/promoter/g' | sed 's/ID=/Parent=/g' > promoter.gff3
cat promoter.gff3 TAIR10_GFF3_genes.gff sed 's/Chr//g'> TAIR10_genes.gff3
grep "tRNA" TAIR10_RNA.gff3 | sed 's/Chr//g'> tRNA.gff3
grep "ncRNA" TAIR10_RNA.gff3 | sed 's/Chr//g'> ncRNA.gff3
grep "rRNA" TAIR10_RNA.gff3 | sed 's/Chr//g'> rRNA.gff3
grep "snoRNA" TAIR10_RNA.gff3 | sed 's/Chr//g'> snoRNA.gff3
grep "snRNA" TAIR10_RNA.gff3 | sed 's/Chr//g' > snRNA.gff3
grep "gene" TAIR10_GFF3_genes.gff | sed 's/Chr//g' > gene.gff3
./add_introns_to_gff.pl TAIR10_GFF3_genes.gff | grep " intron  " | sed 's/Chr//g' > intron.gff3
# we'll want to combine the miRNAs from TAIR10 with the ones from miRBase...
grep "miRNA" TAIR10_RNA.gff3 | sed 's/Chr//g'> miRNA_TAIR10.gff3
# we need to get rid of the Chr preceding the chromosome numbers so everything has similar #'ing conventions
sed 's/Chr//g' ath_miRBase.gff3 > miRNA_miRBase.gff3
# create a gff3 file that represents everything, we can use this to do a subtract to find everything that doesn't
# overlap with an existing rRNA, ncRNA, miRNA, tRNA, snoRNA, snRNA, etc.
cat tRNA.gff3 miRNA_TAIR10.gff3 miRNA_miRBase.gff3 ncRNA.gff3 rRNA.gff3 snoRNA.gff3 snRNA.gff3 | grep -v "^#" > non_siRNAs.gff3
# let's get rid of the symbolic links for these files we don't need
rm -f ath_miRBase.gff3
rm -f TAIR10_GFF3_genes.gff
rm -f TAIR10_RNA.gff3
