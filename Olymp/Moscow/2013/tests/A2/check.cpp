#define EJUDGE
#include "testlib.h"
#include <iostream>
#include <algorithm>
#include <string>
#include <fstream>
#include <set>
#include <vector>

using namespace std;

int main(int argc, char * argv[])
{
    registerTestlibCmd(argc, argv);

	//ifstream inf("inf.txt");
	//ifstream ouf("ouf.txt");
	int n;
	n = inf.readLong();
	inf.readLine();
	string s1, s2;
	vector <string> in_data, out_data, ans_data;
	char code[26] = {0};
	for (int i = 0; i < n; i++) {
		s1 = inf.readLine();
		in_data.push_back(s1);
		s2 = ouf.readLine();
		out_data.push_back(s2);
		if (s1.length() != s2.length())
				quitf(_wa, "wrong length");
		for (int j = 0; j < s1.length(); j++) {
			if (s2[j] < 'a' || s2[j] > 'z')
					quitf(_pe, "bad symbol");
				
			if (code[s2[j] - 'a'] != 0 && code[s2[j] - 'a'] != s1[j])
					quitf(_wa, "ambiguity");
			code[s2[j] - 'a'] = s1[j];
		}

	}
	for (int i = 0; i < n - 1; i++) 
		if (out_data[i] >= out_data[i + 1])
				quitf(_wa, "not sorted");
	for (int i = 0; i < 26; i++)
		for (int j = 0; j < 26; j++)
			if (code[i] != 0 && i != j && code[i] == code[j])
				quitf(_wa, "two codes - one cipher");;
	quitf(_ok, "");

	return 0;
}
