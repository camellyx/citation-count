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
    startPos = strstr(inputLine, title);
    if (startPos) {
      int count = 0;
      startPos = strstr(inputLine, "Cited by");
      if (startPos) {
        startPos += 9;
        endPos = strstr(startPos, "</a>");
        *endPos = '\0';
        count = atoi(startPos);
      }
      cout << count << " " << title << endl;
    }
  }
  cout << "-1 " << title << endl;
  return 0;
}

