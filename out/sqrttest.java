import java.util.*;

public class sqrttest
{
  static Scanner scanner = new Scanner(System.in);
  public static int isqrt(int c)
  {
    return (int)Math.sqrt(c);
  }
  
  
  public static void main(String args[])
  {
    int a = isqrt(4);
    System.out.printf("%d ", a);
    int b = isqrt(16);
    System.out.printf("%d ", b);
    int d = isqrt(20);
    System.out.printf("%d ", d);
    int e = isqrt(1000);
    System.out.printf("%d ", e);
    int f = isqrt(500);
    System.out.printf("%d ", f);
    int g = isqrt(10);
    System.out.printf("%d ", g);
  }
  
}

