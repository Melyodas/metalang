
import sys

"""
La suite de fibonaci
"""
def fibo( a, b, i ):
    out_ = 0;
    a2 = a;
    b2 = b;
    for j in range(0, 1 + i + 1):
      print("%d" % j, end='');
      out_ += a2;
      tmp = b2;
      b2 += a2;
      a2 = tmp;
    return out_;

c = fibo(1, 2, 4);
print("%d" % c, end='');

