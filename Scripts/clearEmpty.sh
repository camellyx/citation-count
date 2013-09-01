#!/bin/bash
find ../PaperList/ScholarPage/$1/* -size -10k | {
while read file 
  do
  echo $file
  rm $file
  done;
}
