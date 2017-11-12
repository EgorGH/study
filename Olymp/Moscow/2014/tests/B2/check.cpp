#include "testlib.h"
#include <cctype>
#include <vector>
#include <set>
#include <iostream>
#include <string>
using namespace std;


#define TEST_N 7
#define TEST_SIZE 32
#define MAX_SCORE 70
#define PENALTY 10


int main(int argc, char* argv[])
{
    registerTestlibCmd(argc, argv);
    
    int comp_score = MAX_SCORE;
    
    for (int t = 0; t < TEST_N; ++t) {
        bool is_correct = true;
        for (int i = 0; i < TEST_SIZE; ++i) {
            int c_ans = ans.readInt(0,1),
                c_ouf = ouf.readInt(0,1);
        }
    }

    ans.skipBlanks();
    ouf.skipBlanks();
    ans.readEof();
    ouf.readEof();

    quitf(_ok, "OK");
    return 0;
}