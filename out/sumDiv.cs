using System;

public class sumDiv
{


static bool eof;
static String buffer;
public static char readChar_(){
  if (buffer == null){
    buffer = Console.ReadLine();
  }
  if (buffer.Length == 0){
    String tmp = Console.ReadLine();
    eof = tmp == null;
    buffer = "\n"+tmp;
  }
  char c = buffer[0];
  return c;
}
public static void consommeChar(){
       readChar_();
  buffer = buffer.Substring(1);
}
public static char readChar(){
  char out_ = readChar_();
  consommeChar();
  return out_;
}

public static void stdin_sep(){
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

public static int readInt(){
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



  public static int sumdiv(int n)
  {
    /* On désire renvoyer la somme des diviseurs */
    int out_ = 0;
    /* On déclare un entier qui contiendra la somme */
    for (int i = 1 ; i <= n; i ++)
    {
      /* La boucle : i est le diviseur potentiel*/
      if ((n % i) == 0)
      {
        /* Si i divise */
        out_ = out_ + i;
        /* On incrémente */
      }
      else
      {
        /* nop */
      }
    }
    return out_;
    /*On renvoie out*/
  }
  
  
  public static void Main(String[] args)
  {
    /* Programme principal */
    int n = 0;
    n = readInt();
    /* Lecture de l'entier */
    int d = sumdiv(n);
    Console.Write(d);
  }
  
}
