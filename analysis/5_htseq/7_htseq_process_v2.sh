#!/bin/bash
# small script for processing htseq results (removes comment lines from files)
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
