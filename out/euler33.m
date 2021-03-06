#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>


int max2_(int a, int b) {
    if (a > b)
        return a;
    else
        return b;
}


int min2_(int a, int b) {
    if (a < b)
        return a;
    else
        return b;
}


int pgcd(int a, int b) {
    int c = min2_(a, b);
    int d = max2_(a, b);
    int reste = d % c;
    if (reste == 0)
        return c;
    else
        return pgcd(c, reste);
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int i, j, k;
  int top = 1;
  int bottom = 1;
  for (i = 1; i < 10; i++)
      for (j = 1; j < 10; j++)
          for (k = 1; k < 10; k++)
              if (i != j && j != k)
              {
                  int a = i * 10 + j;
                  int b = j * 10 + k;
                  if (a * k == i * b)
                  {
                      printf("%d/%d\n", a, b);
                      top *= a;
                      bottom *= b;
                  }
              }
  printf("%d/%d\n", top, bottom);
  int p = pgcd(top, bottom);
  printf("pgcd=%d\n%d\n", p, bottom / p);
  [pool drain];
  return 0;
}


