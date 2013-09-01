#!/bin/bash
#listFolder=../PaperList/DblpList
listFolder=$1
#scholarFolder=../PaperList/ScholarPage
scholarFolder=$2
mkdir $2
#countFolder=../PaperList/CiteCnt
countFolder=$3
mkdir $3

for listFile in $(ls $listFolder); do
  countFile=${listFile/%.list/.count}
  rm -f $countFolder/$countFile
  artCnt=0
  for inputLine in $(cat $listFolder/$listFile); do
    scholarFile=${listFile/%.list/.$artCnt.scholar.html}
    if [ ! -f $scholarFolder/$scholarFile ]; then
      inputLine=${inputLine/q/hl=en&q}
      inputLine=${inputLine/%./&btnG=&as_sdt=1%2C39&as_sdtp=}
      echo $inputLine
      wget --tries=0 --wait=10 --random-wait --waitretry=30 $inputLine -O $scholarFolder/$scholarFile
      sleep 61
    fi
    ./parseScholar < $scholarFolder/$scholarFile >> $countFolder/$countFile
    artCnt=$((artCnt+1))
  done
done
