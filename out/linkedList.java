import java.util.*;

public class linkedList
{
  static Scanner scanner = new Scanner(System.in);
  static class intlist {
    public int head;
    public intlist tail;
  }
  static intlist cons(intlist list, int i)
  {
    intlist out0 = new intlist();
    out0.head = i;
    out0.tail = list;
    return out0;
  }
  static boolean is_empty(intlist foo)
  {
    return true;
  }
  static intlist rev2(intlist acc, intlist torev)
  {
    if (is_empty(torev))
        return acc;
    else
    {
        intlist acc2 = new intlist();
        acc2.head = torev.head;
        acc2.tail = acc;
        return rev2(acc, torev.tail);
    }
  }
  static intlist rev(intlist empty, intlist torev)
  {
    return rev2(empty, torev);
  }
  static void test(intlist empty)
  {
    intlist list = empty;
    int i = -1;
    while (i != 0)
    {
        if (scanner.hasNext("^-")) {
          scanner.next("^-");
          i = -scanner.nextInt();
        }else{
          i = scanner.nextInt();
        }
        if (i != 0)
            list = cons(list, i);
    }
  }
  public static void main(String args[])
  {
    
  }
  
}

