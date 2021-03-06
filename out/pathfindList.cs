using System;

public class pathfindList
{
static bool eof;
static String buffer;
static char readChar_(){
  if (buffer == null || buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = tmp + "\n";
  }
  char c = buffer[0];
  return c;
}
static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
static void stdin_sep(){
  do{
    if (eof) return;
    char c = readChar_();
    if (c == ' ' || c == '\n' || c == '\t' || c == '\r'){
      consommeChar();
    }else{
      return;
    }
  } while(true);
}
static int readInt(){
  int i = 0;
  char s = readChar_();
  int sign = 1;
  if (s == '-'){
    sign = -1;
    consommeChar();
  }
  do{
    char c = readChar_();
    if (c <= '9' && c >= '0'){
      i = i * 10 + c - '0';
      consommeChar();
    }else{
      return i * sign;
    }
  } while(true);
} 
  static int pathfind_aux(int[] cache, int[] tab, int len, int pos)
  {
    if (pos >= len - 1)
        return 0;
    else if (cache[pos] != -1)
        return cache[pos];
    else
    {
        cache[pos] = len * 2;
        int posval = pathfind_aux(cache, tab, len, tab[pos]);
        int oneval = pathfind_aux(cache, tab, len, pos + 1);
        int out0 = 0;
        if (posval < oneval)
            out0 = 1 + posval;
        else
            out0 = 1 + oneval;
        cache[pos] = out0;
        return out0;
    }
  }
  
  static int pathfind(int[] tab, int len)
  {
    int[] cache = new int[len];
    for (int i = 0; i < len; i++)
        cache[i] = -1;
    return pathfind_aux(cache, tab, len, 0);
  }
  
  public static void Main(String[] args)
  {
    int len = 0;
    len = readInt();
    stdin_sep();
    int[] tab = new int[len];
    for (int i = 0; i < len; i++)
    {
        int tmp = 0;
        tmp = readInt();
        stdin_sep();
        tab[i] = tmp;
    }
    int result = pathfind(tab, len);
    Console.Write(result);
  }
  
}

