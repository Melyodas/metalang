#include<stdio.h>
#include<stdlib.h>

void foo(int a){
  a = 4;
}

int main(void){
  int a = 0;
  foo(a);
  printf("%d", a);
  printf("%s", "\n");
  return 0;
}

