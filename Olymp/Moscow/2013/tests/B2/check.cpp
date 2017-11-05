#define EJUDGE
#include "testlib.h"

int main(int argc, char * argv[])
{
//	setName("Moscow 2011. Parallel checker");
    registerTestlibCmd(argc, argv);
	long long a, b, c, d, k, n, ax, ay, ansK, ansN, ansT, ox, oy, outK, outN, outT;
	a = inf.readLong();
	b = inf.readLong();
	c = inf.readLong();
	d = inf.readLong();
	k = inf.readLong();
	n = inf.readLong();
	ax = ans.readLong();
	ay = ans.readLong();
	ansK = k - (a * ax + c * ay);
	ansN = n - (b * ax + d * ay);
	ansT = ansK + ansN;
	ox = ouf.readLong();
	oy = ouf.readLong();
	if (ox < 0 || oy < 0)
		quitf(_wa, "X or Y is negative");

	outK = k - (a * ox + c * oy);
	outN = n - (b * ox + d * oy);
	if (outK < 0 || outN < 0)
		quitf(_wa, "Weight is negative");
	outT = outK + outN;
	if (outT < ansT)
		quitf(_fail, "OOPS");
	if (outT > ansT)
		quitf(_wa, "Not optimal");
	
	
    quitf(_ok, "OK!");
}
