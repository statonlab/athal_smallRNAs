####process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
declare -a arr=("three_prime_UTR" "five_prime_UTR" "exon" "promoter")
for f in `ls 2_output/*.siRNA.sam`
do
for i in {20..25} 
do
for l in "${arr[@]}"
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="9_output"
spe=$l
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.$spe.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i Parent \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.$spe.siRNA.sam \
TAIR10_genes.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.$spe.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
done
```
---
####process each of the miRNA.sam files to see what transposable_elements they overlap with each miRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
for f in `ls 2_output/*.miRNA_TAIR10.sam`
do
for i in {20..25} 
do
lib=`echo $f | sed 's/\.miRNA_TAIR10\.sam//' | sed 's/2_output\///g'`
output_dir="10_output"
spe="miRNA_TAIR10"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.miRNA_TAIR10.sam > tmp.${i}M.$lib.miRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.miRNA.sam \
tmp.${i}M.$lib.miRNA.sam \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.miRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.miRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.miRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.miRNA.sam > ./$output_dir/$lib.$spe.${i}M.miRNA.parse.sam
rm -f tmp.${i}M.$lib.miRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
```
---
####find siRNAs that overlap with genes, we are going to use this output for finding TASIs
```
for f in `ls 2_output/*.siRNA.sam`
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="11_output"
spe="gene"
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
$f \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.siRNA.sam > ./$output_dir/$lib.$spe.siRNA.parse.sam
rm -f tmp.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
```
---
####find siRNAs that overlap with genes, we are going to use this output for finding TASIs
```
for f in `ls 2_output/*.siRNA.sam`
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="11_output"
spe="gene"
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
$f \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.siRNA.sam > ./$output_dir/$lib.$spe.siRNA.parse.sam
rm -f tmp.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
```
---
####process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
for f in `ls 2_output/*.siRNA.sam`
do
for i in {20..25} 
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="13_output"
spe="intron"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i Parent \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.siRNA.sam \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
```
---
####generate htseq counts for all RNASeq results, will extract relevant TASI related genes.
```
for f in `ls *.merged.sorted.sam`
do
lib=`echo $f | sed 's/\.merged\.sorted\.sam//'`
output_dir="14_output"
if [ 1==1 ]; then
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
"
spe="gene"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
$lib.merged.sorted.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
fi > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
```
---
####find siRNAs that overlap with genes, we are going to use this output for finding TASIs
```
for f in `ls 2_output/*.siRNA.sam`
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="15_output"
spe="transposable_element"
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
$f \
${spe}_2kb.gff3 \
>& ./$output_dir/$lib.$spe.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.siRNA.sam > ./$output_dir/$lib.$spe.siRNA.parse.sam
rm -f tmp.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
```
---
####make minor modifications to gff files to work with HTSeq
```
for file in /lustre/projects/staton/projects/athal_methylation/analysis/6_methylKit/output/gff3_2/*
do
base=$(basename $file)
cat $file | sed 's/^Chr//g' | sed 's/region/DMR/g' > 16_$base.gff3
done 
```
---
####process files for reads that overlap with genes
```
s=1
for f in `ls 2_output/*.siRNA.sam`
do
for i in {20..25}
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="17_output"
spe="DMR"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt" > sub.ogs
for gff3 in `ls 16_*.gff3`
do
base=$(echo $gff3 | sed 's/16_//g' | sed 's/\.gff3//g')
echo "grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.${i}M.$base.sam \
tmp.${i}M.$lib.siRNA.sam \
$gff3 \
>& ./$output_dir/$lib.$spe.${i}M.$base.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.$base.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.$base.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.$base.sam > ./$output_dir/$lib.$spe.${i}M.$base.parse.sam
rm -f tmp.${i}M.$lib.siRNA.sam" >> sub.ogs
done
qsub sub.ogs
rm -f sub.ogs
s=$(($s+1))
echo $s
done
done
```
---
####process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
for f in `ls 2_output/*.siRNA.sam`
do
for i in {21,24,29,31} 
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="18_output"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
module load samtools
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
cat header.sam tmp.${i}M.$lib.siRNA.sam > ./${output_dir}/${i}M.$lib.siRNA.sam
rm -f tmp.${i}M.$lib.siRNA.sam
samtools view -b ./${output_dir}/${i}M.$lib.siRNA.sam |\
samtools sort -o ./${output_dir}/${i}M.$lib.siRNA.bam -
samtools index ./${output_dir}/${i}M.$lib.siRNA.bam
/lustre/projects/staton/software/htseq-count \
-s no \
-t DMR \
-i ID \
-a 0 \
./${output_dir}/${i}M.$lib.siRNA.sam \
DMR.gff3 \
>& ./$output_dir/.${i}M.$lib.htseq.txt
grep -v "processed" ./$output_dir/${i}M.$lib.htseq.txt | grep -v "^__" > ./$output_dir/${i}M.$lib.htseq.clean.txt
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
```
---
####process files for reads that overlap with genes
```
s=1
for f in `ls 2_output/*.siRNA.sam`
do
for i in {29,31}
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="19_output"
spe="DMR"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt" > sub.ogs
for gff3 in `ls 16_*.gff3`
do
base=$(echo $gff3 | sed 's/16_//g' | sed 's/\.gff3//g')
echo "grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.${i}M.$base.sam \
tmp.${i}M.$lib.siRNA.sam \
$gff3 \
>& ./$output_dir/$lib.$spe.${i}M.$base.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.$base.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.$base.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.$base.sam > ./$output_dir/$lib.$spe.${i}M.$base.parse.sam
rm -f tmp.${i}M.$lib.siRNA.sam" >> sub.ogs
done
qsub sub.ogs
rm -f sub.ogs
s=$(($s+1))
echo $s
done
done
```
---
####create directories for bedtools output
```
mkdir ogs_output
mkdir 2_output
```
####link samfiles 
```
ln -s ../3_samtools/*.merged.sorted.bam ./
```
####links for our databases
```
ln -s ../../archive/ath_miRBase.gff3 ./
ln -s ../../archive/TAIR10_GFF3_genes.gff ./
ln -s ../../archive/TAIR10_RNA.gff3 ./
```
####extract relevant classifications from the TAIR10 annotations
```
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
```
####we'll want to combine the miRNAs from TAIR10 with the ones from miRBase...
```
grep "miRNA" TAIR10_RNA.gff3 | sed 's/Chr//g'> miRNA_TAIR10.gff3
```
####we need to get rid of the Chr preceding the chromosome numbers so everything has similar #'ing conventions
```
sed 's/Chr//g' ath_miRBase.gff3 > miRNA_miRBase.gff3
```
####create a gff3 file that represents everything, we can use this to do a subtract to find everything that doesn't
```
```
####overlap with an existing rRNA, ncRNA, miRNA, tRNA, snoRNA, snRNA, etc.
```
cat tRNA.gff3 miRNA_TAIR10.gff3 miRNA_miRBase.gff3 ncRNA.gff3 rRNA.gff3 snoRNA.gff3 snRNA.gff3 | grep -v "^#" > non_siRNAs.gff3
```
####let's get rid of the symbolic links for these files we don't need
```
rm -f ath_miRBase.gff3
rm -f TAIR10_GFF3_genes.gff
rm -f TAIR10_RNA.gff3
```
---
####go through all of the merged biological replicates and run htseq for each of the filters:
```
```
####rRNA, tRNA, snoRNA, snRNA, ncRNA, miRNA (TAIR10), miRNA (miRBase)
```
```
####final resulting .sam file will be named TH-##.siRNA.sam, these will need to be filtered for length
```
#for f in `ls *.merged.sorted.bam`
#do
f=TH-01.merged.sorted.sam
lib=`echo $f | sed 's/\.merged\.sorted\.sam//'`
output_dir="2_output"
if [ 1==1 ]; then
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
"
spe="rRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-f sam \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
$lib.merged.sorted.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="tRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="snoRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="snRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="ncRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="miRNA_TAIR10"
##
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="miRNA_miRBase"
##
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
cp ./$output_dir/$lib.$spe.nohit.sam ./$output_dir/$lib.siRNA.sam"
fi > sub.ogs
qsub sub.ogs
rm -f sub.ogs
#done
```
---
####go through all of the merged biological replicates and run htseq for each of the filters: rRNA, tRNA, snoRNA, snRNA, ncRNA, miRNA (TAIR10), miRNA (miRBase) final resulting .sam file will be named TH-##.siRNA.sam, these will need to be filtered for length
```
for f in `ls *.merged.sorted.sam`
do
lib=`echo $f | sed 's/\.merged\.sorted\.sam//'`
output_dir="2_output"
if [ 1==1 ]; then
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
"
spe="rRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
$lib.merged.sorted.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="tRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="snoRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="snRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="ncRNA"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="miRNA_TAIR10"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
"
prespe=$spe
spe="miRNA_miRBase"
echo "
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
./$output_dir/$lib.$prespe.nohit.sam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam
cp ./$output_dir/$lib.$spe.nohit.sam ./$output_dir/$lib.siRNA.sam"
fi > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
```
---
####process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
declare -a arr=("three_prime_UTR" "five_prime_UTR" "exon" "promoter")
for f in `ls 2_output/*.siRNA.sam`
do
for i in {29,31} 
do
for l in "${arr[@]}"
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="30_output"
spe=$l
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.$spe.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i Parent \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.$spe.siRNA.sam \
TAIR10_genes.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.$spe.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
done
```
---
####process each of the miRNA.sam files to see what transposable_elements they overlap with each miRNA.sam file is separated into 29,31 bps.
```
for f in `ls 2_output/*.miRNA_miRBase.sam`
do
for i in {29,31} 
do
lib=`echo $f | sed 's/\.miRNA_miRBase\.sam//' | sed 's/2_output\///g'`
output_dir="32_output"
spe="miRNA_miRBase"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.$spe.sam > tmp.${i}M.$lib.$spe.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
tmp.${i}M.$lib.$spe.sam \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.sam > ./$output_dir/$lib.$spe.${i}M.parse.sam
rm -f tmp.${i}M.$lib.$spe.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
```
---
####process each of the miRNA.sam files to see what transposable_elements they overlap with each miRNA.sam file is separated into 29,31 bps.
```
for f in `ls 2_output/*.miRNA_TAIR10.sam`
do
for i in {29,31} 
do
lib=`echo $f | sed 's/\.miRNA_TAIR10\.sam//' | sed 's/2_output\///g'`
output_dir="33_output"
spe="miRNA_TAIR10"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.miRNA_TAIR10.sam > tmp.${i}M.$lib.miRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t miRNA \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.miRNA.sam \
tmp.${i}M.$lib.miRNA.sam \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.miRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.miRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.miRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.miRNA.sam > ./$output_dir/$lib.$spe.${i}M.miRNA.parse.sam
rm -f tmp.${i}M.$lib.miRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
```
---
####small script for processing htseq results (removes comment lines from files)
```
if [ $# -eq 0 ]
  then
    echo "Supply the name of the directory containing HTSEQ output. ie ./9_htseq_process TEST"
  else
    echo "Library Name	Total Reads	Feat w Reads	Ambiguous	No Features"
    for file in `ls $1/*.txt`
    do
    basename $file
    grep -v "processed.$" $file | grep -v "^__" | awk '{sum+=$2} END {print sum}'
    grep -v "processed.$" $file | grep -v "^__" | grep -v "	0$" | wc -l
    grep "__ambiguous" $file | cut -f 2
    grep "__no_feature" $file | cut -f 2
    done | paste - - - - - | sed 's/\.htseq\.txt//g' | sed 's/\./\t/g'
fi
```
---
####process files for reads that overlap with genes
```
for f in `ls *.merged.sorted.bam`
do
lib=`echo $f | sed 's/\.merged\.sorted\.bam//'`
output_dir="4_output"
spe="gene"
echo "#$ -N $lib.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-f bam \
-a 0 \
-o ./$output_dir/$lib.$spe.sam \
$lib.merged.sorted.bam \
$spe.gff3 \
>& ./$output_dir/$lib.$spe.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.sam > ./$output_dir/$lib.$spe.parse.sam" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
```
---
####script to produce input needed AND drive a perl script for producing read length distribution tables for the libraries
```
if [ $# -eq 0 ]
  then
    echo "Supply the name of the directory containing HTSEQ output. ie ./5_lengthDistribution TEST"
  else
declare -A hash
echo "Total"
	cat $1/*siRNA.sam |\
        awk '{print length($10)}' |\
        sort | uniq -c | sort |\
        sed 's/^ \+//g' | sed 's/ /\t/g' |\
        awk '{print $2,$1}'
for f in `ls $1/*siRNA.sam`
	do
	basename $f
	cat $f |\
	awk '{print length($10)}' |\
	sort | uniq -c | sort |\
	sed 's/^ \+//g' | sed 's/ /\t/g' |\
	awk '{print $2,$1}' | sort -h
	done
fi > tmp4325.txt
./5_table.pl tmp4325.txt
rm -f tmp4325.txt
```
---
####script to produce input needed AND drive a perl script for producing read length distribution tables for the libraries
```
if [ $# -eq 0 ]
  then
    echo "Supply the name of the directory containing HTSEQ output. ie ./5_lengthDistribution TEST"
  else
declare -A hash
echo "Total"
	cat $1/*$2.parse.sam |\
        awk '{print length($10)}' |\
        sort | uniq -c | sort |\
        sed 's/^ \+//g' | sed 's/ /\t/g' |\
        awk '{print $2,$1}'
for f in `ls $1/*$2.parse.sam`
	do
	basename $f
	cat $f |\
	awk '{print length($10)}' |\
	sort | uniq -c | sort |\
	sed 's/^ \+//g' | sed 's/ /\t/g' |\
	awk '{print $2,$1}' | sort -h
	done
fi > tmp4325.txt
./5_table.pl tmp4325.txt
rm -f tmp4325.txt
```
---
####process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
for f in `ls 2_output/*.siRNA.sam`
do
for i in {20..25} 
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="6_output"
spe="gene"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.siRNA.sam \
${spe}.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
```
---
####small script for processing htseq results (removes comment lines from files)
```
if [ $# -eq 0 ]
  then
    echo "Supply the name of the directory containing HTSEQ output. ie ./9_htseq_process TEST"
  else
    echo "Library Name	Total Reads	Feat w Reads	Ambiguous	No Features"
    for file in `ls $1/*.txt`
    do
    basename $file | sed 's/	/_/g'
    grep -v "processed.$" $file | grep -v "^__" | awk '{sum+=$2} END {print sum}'
    grep -v "processed.$" $file | grep -v "^__" | grep -v "	0$" | wc -l
    grep "__ambiguous" $file | cut -f 2
    grep "__no_feature" $file | cut -f 2
    done | paste - - - - - | sed 's/\.htseq\.txt//g' | sed 's/\./\t/g'
fi
```
---
####process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
for f in `ls 2_output/*.siRNA.sam`
do
for i in {20..25} 
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="7_output"
spe="transposable_element"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.siRNA.sam \
${spe}_2kb.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
```
---
####process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
for f in `ls 2_output/*.siRNA.sam`
do
for i in {20..25} 
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="8_output"
spe="gene"
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i ID \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.siRNA.sam \
${spe}_2kb.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
```
---
####process each of the siRNA.sam files to see what transposable_elements they overlap with each siRNA.sam file is separated into 20,21,22,23,24,and 25 bps.
```
declare -a arr=("three_prime_UTR" "five_prime_UTR" "exon" "promoter")
for f in `ls 2_output/*.siRNA.sam`
do
for i in {20..25} 
do
for l in "${arr[@]}"
do
lib=`echo $f | sed 's/\.siRNA\.sam//' | sed 's/2_output\///g'`
output_dir="9_output"
spe=$l
echo "#$ -N $lib.${i}M.htseq
#$ -q medium*
#$ -cwd
#$ -o ./ogs_output/ogs_output.txt
#$ -e ./ogs_output/ogs_error.txt
grep "${i}M" ./2_output/$lib.siRNA.sam > tmp.${i}M.$lib.$spe.siRNA.sam
/lustre/projects/staton/software/htseq-count \
-s no \
-t $spe \
-i Parent \
-a 0 \
-o ./$output_dir/$lib.$spe.siRNA.sam \
tmp.${i}M.$lib.$spe.siRNA.sam \
TAIR10_genes.gff3 \
>& ./$output_dir/$lib.$spe.${i}M.siRNA.htseq.txt
grep "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam | grep -o '.*[	.*$]' > ./$output_dir/$lib.$spe.${i}M.siRNA.nohit.sam
grep -v "__no_feature" ./$output_dir/$lib.$spe.${i}M.siRNA.sam > ./$output_dir/$lib.$spe.${i}M.siRNA.parse.sam
rm -f tmp.${i}M.$lib.$spe.siRNA.sam
" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
done
done
```
---
