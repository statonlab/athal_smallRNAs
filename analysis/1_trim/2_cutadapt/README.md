####create links to raw fastq.gz files and rename them
```
ln -s ../../../archive/Project_Hewezi/*/*.fastq.gz ./
mv TH-10_CTATAC_L001_R1_001.fastq.gz TH-10_001.fastq.gz
mv TH-10_CTATAC_L001_R1_002.fastq.gz TH-10_002.fastq.gz
mv TH-10_CTATAC_L001_R1_003.fastq.gz TH-10_003.fastq.gz
mv TH-10_CTATAC_L001_R1_004.fastq.gz TH-10_004.fastq.gz
mv TH-11_GACGAC_L001_R1_001.fastq.gz TH-11_001.fastq.gz
mv TH-11_GACGAC_L001_R1_002.fastq.gz TH-11_002.fastq.gz
mv TH-11_GACGAC_L001_R1_003.fastq.gz TH-11_003.fastq.gz
mv TH-11_GACGAC_L001_R1_004.fastq.gz TH-11_004.fastq.gz
mv TH-12_TATAAT_L001_R1_001.fastq.gz TH-12_001.fastq.gz
mv TH-12_TATAAT_L001_R1_002.fastq.gz TH-12_002.fastq.gz
mv TH-12_TATAAT_L001_R1_003.fastq.gz TH-12_003.fastq.gz
mv TH-12_TATAAT_L001_R1_004.fastq.gz TH-12_004.fastq.gz
mv TH-1_TGACCA_L001_R1_001.fastq.gz TH-1_001.fastq.gz
mv TH-1_TGACCA_L001_R1_002.fastq.gz TH-1_002.fastq.gz
mv TH-1_TGACCA_L001_R1_003.fastq.gz TH-1_003.fastq.gz
mv TH-2_ACAGTG_L001_R1_001.fastq.gz TH-2_001.fastq.gz
mv TH-2_ACAGTG_L001_R1_002.fastq.gz TH-2_002.fastq.gz
mv TH-2_ACAGTG_L001_R1_003.fastq.gz TH-2_003.fastq.gz
mv TH-2_ACAGTG_L001_R1_004.fastq.gz TH-2_004.fastq.gz
mv TH-3_CAGATC_L001_R1_001.fastq.gz TH-3_001.fastq.gz
mv TH-3_CAGATC_L001_R1_002.fastq.gz TH-3_002.fastq.gz
mv TH-3_CAGATC_L001_R1_003.fastq.gz TH-3_003.fastq.gz
mv TH-3_CAGATC_L001_R1_004.fastq.gz TH-3_004.fastq.gz
mv TH-4_GATCAG_L001_R1_001.fastq.gz TH-4_001.fastq.gz
mv TH-4_GATCAG_L001_R1_002.fastq.gz TH-4_002.fastq.gz
mv TH-4_GATCAG_L001_R1_003.fastq.gz TH-4_003.fastq.gz
mv TH-5_CTTGTA_L001_R1_001.fastq.gz TH-5_001.fastq.gz
mv TH-5_CTTGTA_L001_R1_002.fastq.gz TH-5_002.fastq.gz
mv TH-5_CTTGTA_L001_R1_003.fastq.gz TH-5_003.fastq.gz
mv TH-6_GTGAAA_L001_R1_001.fastq.gz TH-6_001.fastq.gz
mv TH-6_GTGAAA_L001_R1_002.fastq.gz TH-6_002.fastq.gz
mv TH-6_GTGAAA_L001_R1_003.fastq.gz TH-6_003.fastq.gz
mv TH-7_ACTGAT_L001_R1_001.fastq.gz TH-7_001.fastq.gz
mv TH-7_ACTGAT_L001_R1_002.fastq.gz TH-7_002.fastq.gz
mv TH-7_ACTGAT_L001_R1_003.fastq.gz TH-7_003.fastq.gz
mv TH-8_ATGAGC_L001_R1_001.fastq.gz TH-8_001.fastq.gz
mv TH-8_ATGAGC_L001_R1_002.fastq.gz TH-8_002.fastq.gz
mv TH-8_ATGAGC_L001_R1_003.fastq.gz TH-8_003.fastq.gz
mv TH-9_CACGAT_L001_R1_001.fastq.gz TH-9_001.fastq.gz
mv TH-9_CACGAT_L001_R1_002.fastq.gz TH-9_002.fastq.gz
mv TH-9_CACGAT_L001_R1_003.fastq.gz TH-9_003.fastq.gz
mv TH-9_CACGAT_L001_R1_004.fastq.gz TH-9_004.fastq.gz
```
---
for f in `ls *.fastq.gz`
do
base=`echo $f | sed 's/\.fastq\.gz//'`
echo "#$ -N $base
#$ -q short*
#$ -cwd
#$ -o ogs_output.txt
#$ -e ogs_error.txt
module load /lustre/projects/staton/modules/activepython/3.4.3
cutadapt \
-a GTGACTGGAGTTCCTTGGCACCCGAGAATTCCA \
-a CGACAGGTTCAGAGTTCTACAGTCCGACGATC \
-a TACAGTCCGACGATC \
-a ATCTCGTATGCCGTCTTCTGCTTG \
-b AATGATACGGCGACCACCGAGATCTACACGTTCAGAGTTCTACAGTCCGA \
-b GCCTTGGCACCCGAGAATTCCA \
-b TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACNNNNNN \
-b TGGAATTCTCGGGTGCCAAGGAACTCCAGTCAC \
-b TGGAATTCTCGGGTGCCAAGGAACTCCAGTCACNNNNNNATCTCGTATGCCGTCTTCTGCTTG \
-b TCGGACTGTAGAACTCTGAACGTGTAGATCTCGGTGGTCGCCGTATCATT \
-b TGGAATTCTCGGGTGCCAAGGC \
-b NNNNNNGTGACTGGAGTTCCTTGGCACCCGAGAATTCCA \
-b GTGACTGGAGTTCCTTGGCACCCGAGAATTCCA \
-b CAAGCAGAAGACGGCATACGAGATNNNNNNGTGACTGGAGTTCCTTGGCACCCGAGAATTCCA \
-e 0.3 \
-m 15 \
--overlap 3 \
-o $base.trimmed.fastq $f > $base.trimlog" > sub.ogs
qsub sub.ogs
rm -f sub.ogs
done
```
---
####check all the trimmed outputfiles for their total lengths
```
for f in `ls *.trimmed.fastq`
do
echo $f
/lustre/projects/staton/unpublished_lab_code/perl/fastq_scripts/avg_fastq.pl $f | grep "total length of the contigs" | cut -f 8 -d ' '
done | paste - -
```
---
