package main
import "fmt"
import "os"
import "bufio"
var reader *bufio.Reader

func skip() {
  var c byte
  fmt.Fscanf(reader, "%c", &c);
  if c == '\n' || c == ' ' {
    skip()
  } else {
    reader.UnreadByte()
  }
}


func max2(a int, b int) int{
  if a > b {
    return a
  } else {
    return b
  }
}

func eratostene(t []int, max_ int) int{
  var n int = 0
  for i := 2 ; i <= max_ - 1; i++ {
    if t[i] == i {
        var j int = i * i
          n ++;
          for j < max_ && j > 0{
                                 t[j] = 0;
                                 j += i;
          }
      }
  }
  return n
}

func fillPrimesFactors(t []int, n int, primes []int, nprimes int) int{
  for i := 0 ; i <= nprimes - 1; i++ {
    var d int = primes[i]
      for (n % d) == 0{
                        t[d] = t[d] + 1;
                        n /= d;
      }
      if n == 1 {
        return primes[i]
      }
  }
  return n
}

func find(ndiv2 int) int{
  var maximumprimes int = 110
  var era []int = make([]int, maximumprimes)
  for j := 0 ; j <= maximumprimes - 1; j++ {
    era[j] = j;
  }
  var nprimes int = eratostene(era, maximumprimes)
  var primes []int = make([]int, nprimes)
  for o := 0 ; o <= nprimes - 1; o++ {
    primes[o] = 0;
  }
  var l int = 0
  for k := 2 ; k <= maximumprimes - 1; k++ {
    if era[k] == k {
        primes[l] = k;
          l ++;
      }
  }
  for n := 1 ; n <= 10000; n++ {
    var c int = n + 2
      var primesFactors []int = make([]int, c)
      for m := 0 ; m <= c - 1; m++ {
        primesFactors[m] = 0;
      }
      var max_ int = max2(fillPrimesFactors(primesFactors, n, primes, nprimes), fillPrimesFactors(primesFactors, n + 1, primes, nprimes))
      primesFactors[2] --;
      var ndivs int = 1
      for i := 0 ; i <= max_; i++ {
        if primesFactors[i] != 0 {
            ndivs *= 1 + primesFactors[i];
          }
      }
      if ndivs > ndiv2 {
        return (n * (n + 1)) / 2
      }
      /* print "n=" print n print "\t" print (n * (n + 1) / 2 ) print " " print ndivs print "\n" */
  }
  return 0
}

func main() {
  reader = bufio.NewReader(os.Stdin)
  fmt.Printf("%d\n", find(500));
}

