#include <iostream>
#include <stdio.h>
#include <string.h>
#include "testlib.h"

using namespace std;

#define sz(v) ((int)v.size())
#define pb push_back

const int MAX_N = 101;
const int DEFAULT = -7;

int know_secret[MAX_N];
int finds_false[MAX_N][MAX_N];
int finds_true[MAX_N][MAX_N];
int n;


int check_type(const string str, int line, char mode)
{
    //printf("debug: mode = %c line = %d\n", mode, line);
    //cout << str << "\n";
    if (str == string("The end. No secret now!")) {
        return 0;
    }

    int a,b;
    char *tmp_buf = new char[sz(str)];
    int good_arg = 0;
    int scene_type = -1;
    //---------------1------------------
    good_arg = sscanf(str.c_str(), "Character %d finds out the secret%s", &a, tmp_buf);
    if (good_arg == 2 && strcmp(tmp_buf, ".") == 0) {
        scene_type == 1;
        if (a < 1 || a > n) {
            if (mode == 'o') {
                quitf(_wa, "line %d: unexpected Character", line);
            } else {
                quitf(_fail, "line %d: unexpected Character", line);
            }
        }
        if (know_secret[a]) {
            if (mode == 'o') {
                quitf(_wa, "line %d: duplicate of scene", line);
            } else {
                quitf(_fail, "line %d: duplicate of scene", line);
            }
        }
        know_secret[a] = 1;
        delete [] tmp_buf;
        return 1;

    }
    //printf("debug: good_arg = %d scene_type = %d\n", good_arg, scene_type);
    //---------------2---------------------
    good_arg = sscanf(str.c_str(),
        "Character %d finds out that character %d does not know the secret%s", &a, &b, tmp_buf);
    if (good_arg == 3 && strcmp(tmp_buf, ".") == 0) {
        scene_type == 2;
        if (a < 1 || a > n || b < 1 || b > n) {
            if (mode == 'o') {
                quitf(_wa, "line %d: unexpected Character", line);
            } else {
                quitf(_fail, "line %d: unexpected Character", line);
            }
        }
        if (finds_false[a][b]) {
            if (mode == 'o') {
                quitf(_wa, "line %d: duplicate of scene", line);
            } else {
                quitf(_fail, "line %d: duplicate of scene", line);
            }
        }
        if (know_secret[b] == 1 || a == b) {
            if (mode == 'o') {
                quitf(_wa, "line %d: incorrect event with type 2", line);
            } else {
                quitf(_fail, "line %d: incorrect event with type 2", line);
            }   
        }
        finds_false[a][b] = 1;

        delete [] tmp_buf;
        return 2;
    }


    //---------------3---------------------
    good_arg = sscanf(str.c_str(), 
        "Character %d finds out that character %d knows the secret%s", &a, &b, tmp_buf);
    if (good_arg == 3 && strcmp(tmp_buf, ".") == 0) {
        scene_type == 3;
        if (a < 1 || a > n || b < 1 || b > n) {
            if (mode == 'o') {
                quitf(_wa, "line %d: unexpected Character", line);
            } else {
                quitf(_fail, "line %d: unexpected Character", line);
            }
        }
        if (finds_true[a][b]) {
            if (mode == 'o') {
                quitf(_wa, "line %d: duplicate of scene", line);
            } else {
                quitf(_fail, "line %d: duplicate of scene", line);
            }
        }
        if (know_secret[b] == 0 || a == b) {
            if (mode == 'o') {
                quitf(_wa, "line %d: incorrect event with type 3", line);
            } else {
                quitf(_fail, "line %d: incorrect event with type 3", line);
            }   
        }
        finds_true[a][b] = 1;

        delete [] tmp_buf;
        return 3;
    }
    if (scene_type == -1) {
        if (mode == 'o') {
            quitf(_wa, "line %d: incorrect line", line);
        } else {
            quitf(_fail, "line %d: incorrect line", line);
        }
    }
    return scene_type;
}

int main(int argc, char **argv)
{
    registerTestlibCmd(argc, argv);

    n = inf.readInt();
    int jury_ans = 1,
        part_ans = 1;
    int cur_type = DEFAULT,
        prev_type = 0;
//-----------------------
    do {
        prev_type = cur_type;
        cur_type = check_type(ans.readString(), jury_ans, 'a');
        if (prev_type == DEFAULT && cur_type != 1) {
            quitf(_fail, "no secret in the first scene");
        }
        if (cur_type == prev_type) {
            quitf(_fail, "line %d: same scene type",jury_ans);
        }
        ++jury_ans;
    } while (cur_type != 0);
    --jury_ans;
    ans.readEof();
    for (int i = 0; i <= n + 1; ++i) {
        know_secret[i] = 0;
        for (int j = 0; j <= n + 1; ++j) {
            finds_false[i][j] = finds_true[i][j] = 0;
        }
    }
//------------------------
    cur_type = DEFAULT;
    do {
        prev_type = cur_type;
        cur_type = check_type(ouf.readString(), part_ans, 'o');
        if (prev_type == DEFAULT && cur_type != 1) {
            quitf(_wa, "no secret in the first scene");
        }
        if (cur_type == prev_type) {
            quitf(_wa, "line %d: same scene type",part_ans);
        }
        ++part_ans;
    } while (cur_type != 0);
    --part_ans;
    ouf.readEof();
//------------------------
    
    if (jury_ans == part_ans) {
        quitf(_ok, "answer is %d", jury_ans); 
    } else if (jury_ans > part_ans) {
        quitf(_wa, "answer is %d, but participant wrote only %d", jury_ans, part_ans);
    } else {
        quitf(_fail, "jury answer is %d, but participant built %d", jury_ans, part_ans);
    }

    return 0;
}
