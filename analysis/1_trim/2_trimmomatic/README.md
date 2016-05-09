####create a link to all the raw input files
```
ln -s ../../../archive/Project_Hewezi/*/*.fastq.gz ./
```
####rename links to a more manageable name
```
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
####submit trimmomatic jobs to the newton cluster for each trimmed fastq file in the directory
```
for f in `ls *.fastq.gz`
do
base=`echo $f | sed 's/\.fastq\.gz//'`
qsub -cwd -q short* -b y java -Xmx4G -jar /lustre/projects/staton/software/Trimmomatic-0.35/trimmomatic-0.35.jar SE -trimlog $base.trimlog $f $base.trimmed.fastq ILLUMINACLIP:/lustre/projects/staton/software/Trimmomatic-0.35/adapters/illuminaClipping.fa:2:30:10 >& ./$base.trimmomatic.txt
done
```
---
