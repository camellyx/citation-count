all: wgetConfig getList

wgetConfig:
	cp wgetrc ~/.wgetrc

getList:
	wget http://dblp.uni-trier.de/db/conf/micro/micro1999.html
	python extract-papers.py micro1999.html

clean:
	rm ~/.wgetrc

clear:
	rm -rf 
