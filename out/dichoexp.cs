using System;

public class dichoexp
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
  static int exp0(int a, int b)
  {
    if (b == 0)
        return 1;
    if (b % 2 == 0)
    {
        int o = exp0(a, b / 2);
        return o * o;
    }
    else
        return a * exp0(a, b - 1);
  }
  
  
  public static void Main(String[] args)
  {
    int a = 0;
    int b = 0;
    a = readInt();
    stdin_sep();
    b = readInt();
    Console.Write(exp0(a, b));
  }
  
}

