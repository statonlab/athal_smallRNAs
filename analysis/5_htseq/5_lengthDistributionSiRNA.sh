#!/bin/bash
# script to produce input needed AND drive a perl script for producing read length distribution tables for the libraries
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
