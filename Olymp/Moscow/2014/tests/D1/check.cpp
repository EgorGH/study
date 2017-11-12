#include "testlib.h"
#include <cctype>
#include <vector>
#include <set>
#include <iostream>
#include <string>
using namespace std;

#define MAX_SCORE 70
#define PENALTY 10

string get_sum(string a, string b)
{
    char k = 0;
    if (a.size() < b.size()) {
        swap(a, b);
    }
    for (int i = 0; i < b.size(); ++i) {
        a[i] = (a[i] - '0') + (b[i] - '0');
    }
    for (int i = b.size() - 1; i >= 0; --i) {
        a[i] += k;
        k = a[i] / 10;
        a[i] = a[i] % 10 + '0';
    }
    if (k > 0) {
        a = "1" + a;
    }
    return a;
}

bool is_correct_filling(string mask, string full)
{
    bool ans = (mask.size() == full.size());
    for (int i = 0; ans && (i < mask.size()); ++i)
    {
        if (mask[i] == '?') {
            ans &= ('0' <= full[i] && full[i] <= '9');
        } else {
            ans &= (mask[i] == full[i]);
        }
    }
    return ans;
}

int main(int argc, char* argv[])
{
    registerTestlibCmd(argc, argv);
    
    int test_n = inf.readInt();

    int comp_score = MAX_SCORE;
    
    for (int t = 0; t < test_n; ++t) {
        string a_inf = inf.readToken(),
                b_inf = inf.readToken(),
                c_inf = inf.readToken();

        string a_ans = ans.readToken(),
                b_ans = ans.readToken();
        string a_ouf = ouf.readToken(),
                b_ouf = ouf.readToken();

        //cerr << a_inf << ":" << a_ans << endl;
        //cerr << b_inf << ":" << b_ans << endl;

        if (!is_correct_filling(a_inf, a_ans)
        || !is_correct_filling(b_inf, b_ans)) {
            quitf(_fail, "Jury: answer does not match the mask");
        }
        if (get_sum(a_ans, b_ans) != c_inf) {
            quitf(_fail, "Jury: wrong sum");
        }

        if (!is_correct_filling(a_inf, a_ouf)
        || !is_correct_filling(b_inf, b_ouf)) {
            comp_score -= PENALTY;
            cerr << "BAD FILLING\n";
        } else if (get_sum(a_ouf, b_ouf) != c_inf) {
            comp_score -= PENALTY;
            cerr << "WRONG SUM\n";
        } else {
            cerr << "OK\n";
        }
    }

    ans.skipBlanks();
    ouf.skipBlanks();
    ans.readEof();
    ouf.readEof();

    if (comp_score == MAX_SCORE) {
        quitf(_ok, "OK");
    } else {
        quitf(_wa, "Comp: wrong answer");
    }

    return 0;
}
