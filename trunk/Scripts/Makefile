all: parseDblp parseScholar sortCount wgetConfig

wgetConfig:
	cp wgetrc ~/.wgetrc

parseDblp: parseDblp.cpp
	g++ parseDblp.cpp -o parseDblp

parseScholar: parseScholar.cpp
	g++ parseScholar.cpp -o parseScholar

sortCount: sortCount.cpp
	g++ sortCount.cpp -o sortCount

clean:
	rm parseDblp parseScholar sortCount ~/.wgetrc

clear:
	rm -rf ../PaperList/CiteCnt/*
