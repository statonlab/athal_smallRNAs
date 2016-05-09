####create links to the trimmed fastq files
```
ln -s ../2_trimmomatic/*.fastq ./
```
---
####loop through all the trimmed fastq files and run quality checks on them
```
for f in `ls *.fastq`
do
qsub -cwd -q short* -b y /lustre/projects/staton/software/FastQC-v0.11.4/fastqc -o ./ $f
done
```
---
