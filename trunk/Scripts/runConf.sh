#!/bin/bash
./dblpGetList.sh ../PaperList/DblpPage/$1 ../PaperList/DblpList/$1
./dblpGetCount.sh ../PaperList/DblpList/$1 ../PaperList/ScholarPage/$1 ../PaperList/CiteCnt/$1
./sortCiteCnt.sh ../PaperList/CiteCnt/$1
