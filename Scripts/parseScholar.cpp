#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <iostream>
using namespace std;

int main(int argc, char **argv)
{
  char * inputLine = new char [1048576];
  char * scholarAddr = new char [1048576];
  char title [512];
  
  // Find paper title
  cin.getline(inputLine, 1000000);
  char * startPos = strstr(inputLine, "<title>");
  if (!startPos) {
    cout << "Error: Title not found!" << endl;
    return -1;
  }
  startPos += 7;
  char * endPos = strstr(startPos, " - Google Scholar");
  *endPos = '\0';
  strcpy(title, startPos);
  
  while (!cin.eof()) {
    cin.getline(inputLine, 1000000);
    char * citePos = strstr(inputLine, "Cite</a>");
    char * citedByPos = strstr(inputLine, "Cited by ");
    char * relArtPos = strstr(inputLine, "Related articles</a>");
    startPos = citedByPos ? citedByPos :
                  citePos ? citePos :
                relArtPos ? relArtPos : NULL;
    if (startPos) {
      if (citePos && citePos < startPos) startPos = citePos;
      if (relArtPos && relArtPos < startPos) startPos = relArtPos;
      endPos = strstr(startPos, "</a>");
      *endPos = '\0';
      int count = 0;
      if (startPos == citedByPos) {
        count = atoi(citedByPos+9);
      }
      //printf("%x %x %x %x %x\n", inputLine, citedByPos, citePos, relArtPos, startPos);
      cout << count << ", " << title << endl;
      return 0;
    }
  }
  cout << "-1 " << title << endl;
  return 0;
}

