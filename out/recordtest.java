import java.util.*;

public class recordtest
{
  static Scanner scanner = new Scanner(System.in);
  static class toto {
    public int foo;
    public int bar;
  }
  public static void main(String args[])
  {
    toto param = new toto();
    param.foo = 0;
    param.bar = 0;
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      param.bar = -scanner.nextInt();
    }else{
      param.bar = scanner.nextInt();
    }
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")) {
      scanner.next("^-");
      param.foo = -scanner.nextInt();
    }else{
      param.foo = scanner.nextInt();
    }
    System.out.print(param.bar + param.foo * param.bar);
  }
  
}

