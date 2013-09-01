#!/bin/bash
#countFolder=../PaperList/CiteCnt
countFolder=$1
for citeFile in $(ls $countFolder); do
  mkdir $countFolder/sorted 2>/dev/null
  ./sortCount < $countFolder/$citeFile > $countFolder/sorted/$citeFile
done
