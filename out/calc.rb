require "scanf.rb"
##La suite de fibonaci#
def fibo( a, b, i )
  out_ = 0
  a2 = a
  b2 = b
  for j in (0 ..  i + 1) do
      printf "%d", j
      out_ += a2
      tmp = b2
      b2 += a2
      a2 = tmp
      end
      return out_
  end
  printf "%d", fibo(1, 2, 4)
  