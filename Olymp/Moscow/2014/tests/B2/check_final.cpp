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
                is_correct &= (c_ans == c_ouf);
        }
        if (!is_correct) {
            comp_score -= PENALTY;
            cerr << "test " << t + 1 << ": Wrong answer\n";
        }
    }

    ans.skipBlanks();
    ouf.skipBlanks();
    ans.readEof();
    ouf.readEof();

    if (comp_score == MAX_SCORE) {
        quitf(_ok, "OK");
    } else {
        cout << max(0, comp_score);
        quitf(_wa, "Comp: wrong answer");
    }

    return 0;
}