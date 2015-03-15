bash scripts and c++ programs to extract information from dblp pages and scholar pages to form sorted list of citation numbers

### Usage ###
  1. svn checkout http://citation-count.googlecode.com/svn/trunk/ citation-count-read-only
  1. cd citation-count-read-only/Scripts && make
  1. Download dblp pages containing the paper list for the conference and place them in ./PaperList/DblpPages/[[Conference\_Name](Conference_Name.md)]/ `eg. wget http://www.informatik.uni-trier.de/~ley/db/conf/isca/isca2013.html ./PaperList/DblpPages/ISCA/`
> > (Skip this step if MICRO, ISCA, ASPLOS, and HPCA is enough for you)
  1. ./runAll.sh
> > (This will process the existing 4 conferences: MICRO, ISCA, ASPLOS, and HPCA)
> > or
  1. ./runConf.sh ISCA
> > (This will only process the specified conference)

### Included conference dblp pages (in ./PaperList/DblpPages/): ###
  * MICRO, ISCA, ASPLOS, HPCA

### Note ###
  * Paper list are downloaded from [dblp](http://www.informatik.uni-trier.de/~ley/db/)
  * Citation numbers are extracted from [google scholar](http://scholar.google.com)