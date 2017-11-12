#include "testlib.h"
#include <cctype>
#include <set>
#include <string> 
#include <vector> 
#include <sstream> 
#include <iostream> 

using namespace std; 

#define MAX_SCORE 70
#define PENALTY 10

vector <string> split_string(string s)
{
    vector <string> words;
    istringstream iss(s);

    string tmp;
    while (iss >> tmp) {
        words.push_back(tmp);
    }
    sort(words.begin(), words.end());
    return words;
}

int calc_mistakes(vector <string> w1, vector<string> w2)
{
    int penalty = 0;
    set <string> s1, s2;

    for (int i = 0; i < w1.size(); ++i) {
        s1.insert(w1[i]);
    }
    for (int i = 0; i < w2.size(); ++i) {
        s2.insert(w2[i]);
    }
    penalty += w2.size() - s2.size();
    for (int i = 0; i < w1.size(); ++i) {
        if (s2.find(w1[i]) == s2.end()) {
            ++penalty;
        }
    }
    for (int i = 0; i < w2.size(); ++i) {
        if (i > 0 && w2[i] == w2[i - 1]) {
            continue;
        }
        if (s1.find(w2[i]) == s1.end()) {
            ++penalty;
        }
    }
    return penalty;
}


int main(int argc, char* argv[])
{
    registerTestlibCmd(argc, argv);
    
    int comp_score = MAX_SCORE;
    
    string s_ans, s_ouf;

    for (int i = 0; i < 2; ++i) {
        s_ans = ans.readLine();
        s_ouf = ouf.readLine();
        comp_score -= PENALTY * calc_mistakes(
            split_string(s_ans),
            split_string(s_ouf));
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