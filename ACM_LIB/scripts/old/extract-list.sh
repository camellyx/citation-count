#!/usr/bin/env bash
./extract-list.pl MICRO > tmp.txt
#sort -nk 3 tmp.txt > tmp1.txt
sed -f add-year.sed < tmp.txt > tmp1.txt
sed -f html-format.sed < tmp1.txt > list-new.html
#rm tmp.txt tmp1.txt -f
