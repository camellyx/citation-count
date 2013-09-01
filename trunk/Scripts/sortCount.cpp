#include <cstring>
#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <map>
#include <string>
#include <cassert>
using namespace std;

int main(int argc, char **argv)
{
  char * inputLine = new char [1048576];
  multimap<int, string> results;
  while (!cin.eof()) {
    cin.getline(inputLine, 1000000);
    int count;
    sscanf(inputLine, "%d %*s", &count);
    string strLine (inputLine);
    results.insert(pair<int, string>(count, strLine));
  }
  for ( multimap<int, string>::iterator i = results.begin();
       i != results.end(); i++ ) {
    cout << i->second << endl;
  }
  return 0;
}

