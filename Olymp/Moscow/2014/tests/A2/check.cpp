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
        
    string s_ans, s_ouf;

    for (int i = 0; i < 2; ++i) {
        s_ans = ans.readLine();
        s_ouf = ouf.readLine();
    }

    ans.skipBlanks();
    ouf.skipBlanks();
    ans.readEof();
    ouf.readEof();

    
    quitf(_ok, "OK");
    return 0;
}