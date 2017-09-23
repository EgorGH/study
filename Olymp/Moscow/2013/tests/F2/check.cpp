#include <cstdio>
#include <vector>
#include "testlib.h"
using namespace std;

typedef long long llong;

const int B = 10000;
struct vlong
{
    vector<int> V;
    void trim()
    {
        while(!V.empty() && !V.back())
            V.pop_back();
    }
    void norm()
    {
        for (int i = 0; i < V.size(); i++)
        {
            if (V[i] >= B && i + 1 == V.size())
                V.resize(V.size() + 1);
            if (V[i] >= B)
                V[i + 1] += V[i] / B, V[i] %= B;
        }
        trim();
    }

    vlong()
    {
        V = vector<int>();
    }
    vlong(llong x)
    {
        V = vector<int>();
        while (x)
            V.push_back(x % B), x /= B;
    }
    friend vlong operator +(const vlong& A, const vlong& B)
    {
        vlong C;
        C.V.resize(max(A.V.size(), B.V.size()));
        for (int i = 0; i < C.V.size(); i++)
            C.V[i] = ((i < A.V.size()) ? A.V[i] : 0) + ((i < B.V.size()) ? B.V[i] : 0);
        C.norm();;
        return C;
    }
    friend bool operator ==(const vlong& A, const vlong& B)
    {
        if (A.V.size() != B.V.size())
            return false;
        for (int i = 0; i < A.V.size(); i++)
            if (A.V[i] != B.V[i])
                return false;
        return true;
    }
    friend bool operator <(const vlong& A, const vlong& B)
    {
        if (A.V.size() != B.V.size())
            return A.V.size() < B.V.size();
        for (int i = (int)A.V.size() - 1; i >= 0; i--)
            if (A.V[i] != B.V[i])
                return A.V[i] < B.V[i];
        return false;
    }
    friend bool operator >(const vlong& A, const vlong& B)
    {
        if (A.V.size() != B.V.size())
            return A.V.size() > B.V.size();
        for (int i = (int)A.V.size() - 1; i >= 0; i--)
            if (A.V[i] != B.V[i])
                return A.V[i] > B.V[i];
        return false;
    }
    void div2()
    {
        for (int i = (int)V.size() - 1; i >= 0; i--)
        {
            if ((V[i] & 1) && i)
                V[i - 1] += B;
            V[i] /= 2;
        }
        trim();
    }
    friend vlong operator *(const vlong& a, const vlong& b)
    {
        vlong C;
        C.V.resize(a.V.size() + b.V.size());
        for (int i = 0; i < a.V.size(); i++)
            for (int j = 0; j < b.V.size(); j++)
            {
                C.V[i + j] += a.V[i] * b.V[j];
                C.V[i + j + 1] += C.V[i + j] / B, C.V[i + j] %= B;
            }
        C.trim();
        return C;
    }

    /*friend vlong operator /(vlong A, vlong B)
    {
        vlong L(0);
        vlong R = A + vlong(1);
        while (!(L + vlong(1) == R))
            // OPTIMIZE
        {
            vlong M = (L + R);
            M.div2();
            if (M * B > A)
                R = M;
            else
                L = M;
        }
        return L;
    }*/

    friend vlong operator /(vlong a, vlong b)
    {
        if (a.V.size() < b.V.size())
            return vlong();
        int n = a.V.size();
        int m = b.V.size();
        for (int i = 0; i < n - m; i++)
            b.V.push_back(0);
        rotate(b.V.begin(), b.V.begin() + m, b.V.end());
        vlong C;
        C.V.resize(n - m + 1);
        for (int i = 0; i <= n - m; i++)
        {
            int l = 0, r = B;
            while (r - l > 1)
            {
                int q = (l + r) / 2;
                if (vlong(q) * b > a)
                    r = q;
                else
                    l = q;
            }
            a -= l * b;
            C.V[n - m - i] = l;
            rotate(b.V.begin(), b.V.begin() + 1, b.V.end());
            b.V.pop_back();
        }
        C.trim();
        return C;
    }

    friend vlong operator %(const vlong& A, const vlong& B)
    {
        vlong ret = A;
        ret -= (A / B) * B;
        return ret;
    }

    friend int operator %(const vlong& A, int b)
    {
        int ans = 0;
        for (int i = (int)A.V.size() - 1; i >= 0; i--)
            ans = (ans * B + A.V[i]) % b;
        return ans;
    }
    void operator /=(int b)
    {
        for (int i = (int)V.size() - 1; i >= 0; i--)
        {
            if (i)
                V[i - 1] += B * (V[i] % b);
            V[i] /= b;
        }
        norm();
    }
    void operator -=(const vlong& A)
    {
        for (int i = 0; i < V.size(); i++)
        {
            V[i] -= (i < A.V.size()) ? A.V[i] : 0;
            if (V[i] < 0)
                V[i] += B, V[i + 1]--;
        }
        trim();
    }
    char* tostr()
    {
        char *buf = new char[(1 + V.size()) * 4];
        int q = 0;
        int r = 0;
        if (V.empty())
            sprintf(buf, "0"), q++;
        //sprintf(buf + q, "(%d)%n", V.size(), &r); q += r;
        for (int i = (int)V.size() - 1; i >= 0; i--)
            if (i + 1 == V.size())
                sprintf(buf + q, "%d%n", V.back(), &r), q += r;
            else
                sprintf(buf + q, "%04d%n", V[i], &r), q += r;
        buf[q] = 0;
        return buf;
    }
    vlong(string s)
    {
        if (s == "0")
            V = vector<int>();
        else
        {
            while (s.size() % 4)
                s.insert(s.begin(), '0');
            for (int i = (int)s.size() - 4; i >= 0; i -= 4)
                V.push_back(atoi(s.substr(i, 4).c_str()));
        }
    }
};

const int MAXL = 100;

int main(int argc, char* argv[])
{
    registerTestlibCmd(argc, argv);
    int n = inf.readInt();
    string a = ouf.readWord(format("(0|[1-9][0-9]{0,%d})", MAXL - 1), "a");
    string b = ouf.readWord(format("(0|[1-9][0-9]{0,%d})", MAXL - 1), "b");
    vlong x(a);
    vlong y(b);
    if (x < y)
        swap(x, y);
    int cnt = 0;
    while (!(y == vlong(0)))
    {
        x = x % y;
        swap(x, y);
        cnt++;
    }
    quitif(cnt != n, _wa, "Euclid algorithm made %d steps instead of %d expected", cnt, n);
    quitf(_ok, "The force is strong in this one...");
    return 0;
}

