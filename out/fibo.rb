
require "scanf.rb"

def fibo_( a, b, i )
    out_ = 0
    a2 = a
    b2 = b
    for j in (0 ..  i + 1) do
      out_ = out_ + a2;
      tmp = b2
      b2 = b2 + a2;
      a2 = tmp;
    end
    return (out_);
end

a = 0
b = 0
i = 0
a=scanf("%d")[0];
scanf("%*\n");
b=scanf("%d")[0];
scanf("%*\n");
i=scanf("%d")[0];
m = fibo_(a, b, i)
printf "%d", m
