import java.util.*;

public class tuple
{
  static Scanner scanner = new Scanner(System.in);
  static class tuple_int_int {public int tuple_int_int_field_0;public int tuple_int_int_field_1;}
  public static tuple_int_int f(tuple_int_int tuple_)
  {
    tuple_int_int c = tuple_;
    int a = c.tuple_int_int_field_0;
    int b = c.tuple_int_int_field_1;
    tuple_int_int d = new tuple_int_int();
    d.tuple_int_int_field_0 = a + 1;
    d.tuple_int_int_field_1 = b + 1;
    return d;
  }
  
  
  public static void main(String args[])
  {
    tuple_int_int e = new tuple_int_int();
    e.tuple_int_int_field_0 = 0;
    e.tuple_int_int_field_1 = 1;
    tuple_int_int t = f(e);
  }
  
}

