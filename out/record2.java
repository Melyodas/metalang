import java.util.*;

public class record2
{
  static Scanner scanner = new Scanner(System.in);
  static class toto {public int foo;public int bar;public int blah;}
  public static toto mktoto(int v1)
  {
    toto c = new toto();
    c.foo = v1;
    c.bar = 0;
    c.blah = 0;
    toto t = c;
    return t;
  }
  
  public static int result(toto t)
  {
    t.blah ++;
    return t.foo + t.blah * t.bar + t.bar * t.foo;
  }
  
  
  public static void main(String args[])
  {
    toto t = mktoto(4);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t.bar = -scanner.nextInt();
    }else{
    t.bar = scanner.nextInt();}
    scanner.findWithinHorizon("[\n\r ]*", 1);
    if (scanner.hasNext("^-")){
    scanner.next("^-"); t.blah = -scanner.nextInt();
    }else{
    t.blah = scanner.nextInt();}
    int a = result(t);
    System.out.printf("%d", a);
    int b = t.blah;
    System.out.printf("%d", b);
  }
  
}

