import java.util.*;

public class aaa_10stringsarray
{
  
  /*
TODO ajouter un record qui contient des chaines.
*/
  static String idstring(String s)
  {
    return s;
  }
  
  static void printstring(String s)
  {
    System.out.printf("%s\n", idstring(s));
  }
  
  
  public static void main(String args[])
  {
    String[] tab = new String[2];
    for (int i = 0 ; i < 2; i++)
      tab[i] = idstring("chaine de test");
    for (int j = 0 ; j <= 1; j ++)
      printstring(idstring(tab[j]));
  }
  
}

