#include <iostream>
#include <stdio.h>
#include <string.h>
#include "testlib.h"
#include <cmath>

using namespace std;

long double round(long double value)
{
  return floor(value + 0.5);
}

struct comm {
	string type;
	int time, depno, period;
	long double sum;
};

struct dep {
	int end;
	long double perc;
	long double sum;
};

enum {totalperiods = 48};

comm comms[1000];
#define eps 0.01


int main(int argc, char **argv)
{
	registerTestlibCmd(argc, argv);
	long double cash = 1000000;
	int wtest = -1;
	int tcomms = 0;
	while (!ouf.seekEof()) {

		string command = ouf.readWord();
		comms[tcomms].type = command;
		if (command == "OPEN") {
			comms[tcomms].time = ouf.readInt();
			comms[tcomms].depno = ouf.readInt(); 
			comms[tcomms].period = ouf.readInt();
			comms[tcomms].sum = ouf.readDouble();
		} else if (command == "ADD") {
			comms[tcomms].time = ouf.readInt();
			comms[tcomms].depno = ouf.readInt(); 
			comms[tcomms].sum = ouf.readDouble();
		} else {
		    quitf(_pe, "Error in line %d. Command must be OPEN or ADD", tcomms + 1);
		}
		if (comms[tcomms].time > totalperiods)
		    quitf(_wa, "Error in line %d. Too late (time must be less or equival than %d)", tcomms + 1, totalperiods);


		tcomms++;
	}
	dep deps[7];
	bool useddeps[7];
	int ncomms = 0;
	for (int i = 1; i < 7; i++)
		useddeps[i] = false;
	for (int time = 0; time <= totalperiods; time++) {
		for (int i = 1; i < 7; i++) {
			if (useddeps[i]) {
				deps[i].sum *= (1 + (deps[i].perc / 100.0 / 12));
				if (deps[i].end == time) {
					cash += round(deps[i].sum * 100) / 100;
					useddeps[i] = false;
				}
			}
		}
		while (ncomms < tcomms && comms[ncomms].time == time) {
			if (comms[ncomms].type == "OPEN") {
				if (useddeps[comms[ncomms].depno])
					quitf(_wa, "Error in line %d. Trying to open existing deposit.", ncomms + 1);
				if (comms[ncomms].sum + eps < 30000)
					quitf(_wa, "Error in line %d. Sum to small.", ncomms + 1);
				if (comms[ncomms].period + time > totalperiods)
					quitf(_wa, "Error in line %d. Deposit is too long.", ncomms + 1);
				if (comms[ncomms].period > 12 || comms[ncomms].period < 3)
					quitf(_wa, "Error in line %d. Bad time (should be from 3 to 12).", ncomms + 1);
				if (comms[ncomms].sum > cash + eps)
					quitf(_wa, "Error in line %d. Not enough money.", ncomms + 1);
				long double perc, nsum;
				if (comms[ncomms].period >= 3 && comms[ncomms].period < 6)
					perc = 4;
				if (comms[ncomms].period >= 6 && comms[ncomms].period < 12)
					perc = 6.5;
				if (comms[ncomms].period == 12)
					perc = 9.5;
				cash -= comms[ncomms].sum;
				nsum = comms[ncomms].sum * 1.015;
				deps[comms[ncomms].depno].sum = nsum;
				deps[comms[ncomms].depno].perc = perc;
				deps[comms[ncomms].depno].end = time + comms[ncomms].period;
				useddeps[comms[ncomms].depno] = true;
			} else if (comms[ncomms].type == "ADD") {
				if (!useddeps[comms[ncomms].depno])
					quitf(_wa, "Error in line %d. Trying to add money to not existing deposit.", ncomms + 1);
				if (comms[ncomms].sum > cash)
					quitf(_wa, "Error in line %d. Not enough money.", ncomms + 1);
				long double nsum = comms[ncomms].sum;
				cash -= nsum;
				if (deps[comms[ncomms].depno].end - time >= 3)
					nsum = nsum * 1.015;	
				deps[comms[ncomms].depno].sum += nsum;
			}
			ncomms++;
		}

	}
	long double min_sum = 1549694;
	long double max_sum = 1776834.55;
	if (cash > max_sum)
	    quitf(_fail, "Contestant solution is better");

	quitf(_ok, "");
	
	
    return 0;
}
