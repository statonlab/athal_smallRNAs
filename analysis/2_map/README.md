mkdir ogs_output
#ln -s ../1_trim/2_trimmomatic/*.fastq ./
ln -s ../../archive/Project_Hewezi/*/*.fastq.gz ./
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
#ln -s ../
#cat s2.trim.fastq s3.trim.fastq > s23.trim.fastq
#rm -f s2.fastq s3.fastq
####this is done purely for my sanity in all later steps
```
```
####s1.fastq becomes s2.fastq and s2+3.fastq becomes s3.fastq 
```
```
####now all ogs jobs should be an array 2-5 instead of 1-5
```
#mv s1.trim.fastq s2.trim.fastq
#mv s23.trim.fastq s3.trim.fastq
```
---
echo "library	total reads	aligned 0 times	aligned exactly 1 time	aligned >1 times	overall alignment rate"
for file in `ls ogs_output/*bowtie2*`
do
base=$(basename $file | sed 's/\..*//g')
echo -n "$base	"
sed 's/^ *//g' $file | cut -f 1 -d ' ' | paste - - - - - -
done | cut -f 1,3-
```
---
