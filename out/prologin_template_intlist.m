#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

int programme_candidat(int* tableau, int taille){
  int i;
  int out_ = 0;
  for (i = 0 ; i < taille; i++)
    out_ += tableau[i];
  return out_;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int e;
  int b = 0;
  scanf("%d ", &b);
  int taille = b;
  int *d = malloc( taille * sizeof(int));
  for (e = 0 ; e < taille; e++)
  {
    int f = 0;
    scanf("%d ", &f);
    d[e] = f;
  }
  int* tableau = d;
  printf("%d\n", programme_candidat(tableau, taille));
  [pool drain];
  return 0;
}


