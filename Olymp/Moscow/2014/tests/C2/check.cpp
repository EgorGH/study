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

    string s = ouf.readLine();
    ouf.skipBlanks();
    ouf.readEof();
    for (int i = 0; i < s.size(); ++i) {
        if (s[i] < 'A' || s[i] > 'Z') {
            quitf(_pe, "wrong symbol");
        }
    }
    quitf(_ok, "OK");
    return 0;
}
