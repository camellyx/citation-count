#!/bin/bash
#countFolder=../PaperList/CiteCnt
countFolder=$1
rm -rf $countFolder/sorted
countFileList=$(ls $countFolder)
mkdir $countFolder/sorted
for countFile in $countFileList; do
  conference=${countFile/%.count/}
  echo $conference > $countFolder/sorted/$countFile
  ./sortCount < $countFolder/$countFile >> $countFolder/sorted/$countFile
done
