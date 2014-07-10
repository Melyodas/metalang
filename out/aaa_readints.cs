using System;
using System.Collections.Generic;

public class aaa_readints
{
  public static int read_int()
  {
    return int.Parse(Console.ReadLine());
  }
  
  public static int[] read_int_line(int n)
  {
    return new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
  }
  
  public static int[][] read_int_matrix(int x, int y)
  {
    int[][] tab = new int[y][];
    for (int z = 0 ; z < y; z++)
    {
      int b = x;
      int[] a = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
      tab[z] = a;
    }
    return tab;
  }
  
  
  public static void Main(String[] args)
  {
    int c = int.Parse(Console.ReadLine());
    int len = c;
    Console.Write("" + len + "=len\n");
    int e = len;
    int[] d = new List<string>(Console.ReadLine().Split(" ".ToCharArray())).ConvertAll<int>(int.Parse).ToArray();
    int[] tab1 = d;
    for (int i = 0 ; i < len; i++)
    {
      Console.Write("" + i + "=>" + tab1[i] + "\n");
    }
    int f = int.Parse(Console.ReadLine());
    len = f;
    int[][] tab2 = read_int_matrix(len, len - 1);
    for (int i = 0 ; i <= len - 2; i ++)
    {
      for (int j = 0 ; j < len; j++)
      {
        Console.Write("" + tab2[i][j] + " ");
      }
      Console.Write("\n");
    }
  }
  
}

