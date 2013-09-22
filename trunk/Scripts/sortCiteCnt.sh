#!/bin/bash
#countFolder=../PaperList/CiteCnt
countFolder=$1
rm -rf $countFolder/sorted $countFolder/all.count 2>/dev/null
countFileList=$(ls $countFolder)
mkdir $countFolder/sorted
for countFile in $countFileList; do
  conference=${countFile/%.count/}
  #echo $conference
  sed -e "s:$:,\ $conference:" $countFolder/$countFile >> $countFolder/all.count
done
for countFile in $countFileList; do
  conference=${countFile/%.count/}
  echo -e "\n$conference\n" > $countFolder/sorted/$countFile.txt
  ./sortCount < $countFolder/$countFile >> $countFolder/sorted/$countFile.txt
done
./sortCount < $countFolder/all.count > $countFolder/sorted/all.txt
