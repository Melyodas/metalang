import java.util.*;

public class fibo
{
  static Scanner scanner = new Scanner(System.in);
  /*
La suite de fibonaci
*/
  public static int fibo_(int a, int b, int i)
  {
    int out_ = 0;
    int a2 = a;
    int b2 = b;
    for (int j = 0 ; j <= i + 1; j ++)
    {
      out_ += a2;
      int tmp = b2;
      b2 += a2;
      a2 = tmp;
    }
    return out_;
  }
  
  
  public static void main(String args[])
  {
    int a = 0;
    int b = 0;
    int i = 0;
    if (scanner.hasNext("^-")){
    scanner.next("^-"); a = -scanner.nextInt();
    }else{
    a = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); b = -scanner.nextInt();
    }else{
    b = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); i = -scanner.nextInt();
    }else{
    i = scanner.nextInt();}
    int g = fibo_(a, b, i);
    System.out.printf("%d", g);
  }
  
}

