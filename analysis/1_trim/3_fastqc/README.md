####links the cutadapt trimmed fastq files
```
ln -s ../2_cutadapt/*.fastq ./
```
---
####run fastqc on all cutadapt trimmed files
```
for f in `ls *.fastq`
do
qsub -cwd -q short* -b y /lustre/projects/staton/software/FastQC-v0.11.4/fastqc -o ./ $f
done
```
---
