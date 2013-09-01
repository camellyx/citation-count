#!/bin/bash
#webpageFolder=../PaperList/DblpPage
webpageSubFolder=$1
#listFolder=../PaperList/DblpList
listFolder=$2
mkdir $2
artCnt=0
#for conference in $(ls $webpageFolder); do
#  webpageSubFolder=$webpageFolder/$conference
  for dblpPage in $(ls $webpageSubFolder); do
    listFile=${dblpPage/%.html/.list}
    if [ ! -f $listFolder/$listFile ]; then
      echo "----------------$dblpPage-------------------"
      ./parseDblp < $webpageSubFolder/$dblpPage > $listFolder/$listFile
    fi
  done
#done
