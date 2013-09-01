#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <iostream>
using namespace std;

int main(int argc, char **argv)
{
  char * inputLine = new char [1048576];
  char * scholarAddr = new char [1048576];
  while (!cin.eof()) {
    cin.getline(inputLine, 1000000);
    char * startPos = strstr(inputLine, "Google</a></li><li><a href=\"");
    if (startPos) {
      startPos += 28;
      char * endPos = strstr(startPos, "\"");
      *endPos = '\0';
      cout << startPos << endl;
    }
    //if (sscanf(inputLine, "%*sGoogle%s", scholarAddr) >= 1)
      //printf("<<<%s\n>>>%s\n", inputLine, scholarAddr);
  }
  return 0;
}

