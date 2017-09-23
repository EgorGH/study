#include "testlib.h"
#include <iostream>

using namespace std;

long long get_sum(long long p, long long x) {
    long long ans = 0;
    while (x > 0) {
        ans += x % p;
        x /= p;
    }
    return ans;
}

int main(int argc, char * argv[]) {
    registerTestlibCmd(argc, argv);

    int test = 1;
    
    while (!ouf.seekEof() && !ouf.seekEof()) {
        long long pa = ouf.readLong();
        if (pa < 10)
            quitf(_wa, "N < 10");
        long long p1 = inf.readLong();
        long long p2 = inf.readLong();

        if (get_sum(p1, pa) != get_sum(p2, pa))
            quitf(_wa, "Sum of digits is not equal in test #%d", test);

        long long ja = ans.readLong();

        if (pa > ja)
            quitf(_wa, "Participant answer is larger than jury in test #%d", test);
        if (pa < ja)
            quitf(_fail, "Participant answer is less than jury in test #%d. o_O", test);
        ++test;
    }

    int extraAns = 0;

    while (!ans.seekEof()) {
        ans.readLong();
        ++extraAns;
    }

    int extraAnsP = 0;
    while (!ouf.seekEof()) {
        ans.readLong();
        ++extraAnsP;
    }
    
    if (extraAns > 0)
        quitf(_wa, "Jury answer has contain more numbers than participant answer. Jury = %d ; Participant = %d", test + extraAns, test);
    if (extraAnsP > 0)
        quitf(_wa, "Participant answer contain more numbers than jury answer. Jury = %d ; Participant = %d", test, test + extraAns);

    quitf(_ok, "Ok");
}

