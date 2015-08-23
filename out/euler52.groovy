import java.util.*

int chiffre_sort(int a)
{
  if (a < 10)
    return a
  else
  {
    int b = chiffre_sort(a.intdiv(10))
    int c = a % 10
    int d = b % 10
    int e = b.intdiv(10)
    if (c < d)
      return c + b * 10
    else
      return d + chiffre_sort(c + e * 10) * 10
  }
}

boolean same_numbers(int a, int b, int c, int d, int e, int f)
{
  int ca = chiffre_sort(a)
  return ca == chiffre_sort(b) && ca == chiffre_sort(c) && ca == chiffre_sort(d) && ca == chiffre_sort(e) && ca == chiffre_sort(f)
}



int num = 142857
if (same_numbers(num, num * 2, num * 3, num * 4, num * 6, num * 5))
  System.out.printf("%s %s %s %s %s %s\n", num, num * 2, num * 3, num * 4, num * 5, num * 6);

