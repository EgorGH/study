import math

a = int(input())

x = 1 << (a.bit_length() // 2)

for i in range(17):
  x = (x + a // x) // 2

y = x * x

if y == a:
    print(1)
elif y < a:
    k = a - y
    if k <= x + 1:
        print(k)
    else:
        print((x + 1) * 2 - k)
else:
    z = y - 2 * x + 1
    k = a - z
    if k <= x:
        print(k)
    else:
        print(x * 2 - k)