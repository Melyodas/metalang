object euler40
{
  
var buffer = "";
def read_int() : Int = {
  if (buffer != null && buffer == "") buffer = readLine();
  var sign = 1;
  if (buffer != null && buffer.charAt(0) == '-'){
    sign = -1;
    buffer = buffer.substring(1);
  }
  var c = 0;
  while (buffer != null && buffer != "" && buffer.charAt(0).isDigit){
    c = c * 10 + buffer.charAt(0).asDigit;
    buffer = buffer.substring(1);
  }
  return c * sign;
}
def read_char() : Char = {
  if (buffer != null && buffer == "") buffer = readLine();
  var c = buffer.charAt(0);
  buffer = buffer.substring(1);
  return c;
}
def skip() {
  if (buffer != null && buffer == "") buffer = readLine();
  while (buffer != null && buffer != "" && (buffer.charAt(0) == ' ' || buffer.charAt(0) == '\t' || buffer.charAt(0) == '\n' || buffer.charAt(0) == '\r'))
    buffer = buffer.substring(1);
}

  def exp0(a : Int, e : Int): Int = {
    var i: Int=0;
    var o: Int = 1;
    for (i <- 1 to e)
      o = o * a;
    return o;
  }
  
  def e(t : Array[Int], _n : Int): Int = {
    var n = _n;
    var i: Int=0;
    for (i <- 1 to 8)
      if (n >= t(i) * i)
      n = n - t(i) * i;
    else
    {
      var nombre: Int = exp0(10, i - 1) + n / i;
      var chiffre: Int = i - 1 - n % i;
      return (nombre / exp0(10, chiffre)) % 10;
    }
    return -1;
  }
  
  
  def main(args : Array[String])
  {
    var t :Array[Int] = new Array[Int](9);
    for (i <- 0 to 9 - 1)
      t(i) = exp0(10, i) - exp0(10, i - 1);
    for (i2 <- 1 to 8)
    {
      printf("%d => %d\n", i2, t(i2));
    }
    for (j <- 0 to 80)
      printf("%d", e(t, j));
    printf("\n");
    for (k <- 1 to 50)
      printf("%d", k);
    printf("\n");
    for (j2 <- 169 to 220)
      printf("%d", e(t, j2));
    printf("\n");
    for (k2 <- 90 to 110)
      printf("%d", k2);
    printf("\n");
    var out0: Int = 1;
    for (l <- 0 to 6)
    {
      var puiss: Int = exp0(10, l);
      var v: Int = e(t, puiss - 1);
      out0 = out0 * v;
      printf("10^%d=%d v=%d\n", l, puiss, v);
    }
    printf("%d\n", out0);
  }
  
}
