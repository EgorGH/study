#include "testlib.h"
#include <cctype>
#include <set>
#include <string> 
#include <vector> 
#include <sstream> 
#include <iostream> 

using namespace std; 

int main(int argc, char* argv[])
{
    registerTestlibCmd(argc, argv);
	int cnt = 0;
    while (!ouf.eof()) {
		char c = ouf.readChar();
		if (c == '\n')
			cnt++;
	}
	if (cnt == 10 || cnt == 11 || cnt == 12)
		quitf(_ok, "OK");
	else
		quitf(_pe, "11 lines expected");
    return 0;
}
