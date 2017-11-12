#include "testlib.h"
#include <cctype>
#include <set>
#include <string> 
#include <vector> 
#include <sstream> 
#include <iostream> 

using namespace std; 

#define MAX_SCORE 70
#define PENALTY 15

#define ALPA_SIZE 26

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

int get_n_alpha(string s)
{
    int amount = 0;
    int cnt[ALPA_SIZE];
    for (int i = 0; i < ALPA_SIZE; ++i) {
        cnt[i] = 0;
    }

    for (int i = 0; i < s.size(); ++i)
    {
        if ('a' <= s[i] && s[i] <= 'z') {
            ++amount;
            ++cnt[s[i] - 'a'];
            if (cnt[s[i] - 'a'] > 1) {
                cerr << "double used letter\n";
                amount = -1;
                break;
            }
        } else if (s[i] != ' '){
            cerr << "undefined symbol\n";
            amount = -1;
            break;
        }
    }
    return amount;
}

bool check_words(vector<string> words, set<string> vocab)
{
    for (int i = 0; i < words.size(); ++i) {
        if (vocab.find(words[i]) == vocab.end()) {
            return false;
        }
    }
    return true;
}

int main(int argc, char* argv[])
{
    registerTestlibCmd(argc, argv);
    
    int n_ans = ans.readInt(0, ALPA_SIZE),
        n_ouf = ouf.readInt();
	if (n_ouf < 0 || n_ouf > 26) {
        cout << 0;
        quitf(_wa, "Wrong number");
	}

    ans.skipBlanks();
    string s_ans = ans.readLine();
    ouf.skipBlanks();
    string s_ouf = ouf.readLine();


    int n_words = inf.readInt();
    set <string> words;
    for (int i = 0; i < n_words; ++i) {
        string tmp = inf.readToken();
        words.insert(tmp);
    }

    if (get_n_alpha(s_ans) != n_ans) {
        cout << 0;
		quitf(_fail, "Incorrect string");
    }
    if (get_n_alpha(s_ouf) != n_ouf) {
        cout << 0;
        quitf(_wa, "Incorrect string");
    }

    if (check_words(split_string(s_ans), words) == false) {
        cout << 0;
        quitf(_fail, "Wrong word is used");
    }
    if (check_words(split_string(s_ouf), words) == false) {
        cout << 0;
        quitf(_wa, "Wrong word is used");
    }

    ans.skipBlanks();
    ouf.skipBlanks();
    ans.readEof();
    ouf.readEof();

    if (n_ouf > n_ans) {
        quitf(_fail, "Competitors answer is better");
    } else if (n_ouf == n_ans) {
        quitf(_ok, "OK");
    } else {
        cout << max(0, MAX_SCORE - (n_ans - n_ouf) * PENALTY);
        quitf(_wa, "Comp: not optimal");
    }
    return 0;
}