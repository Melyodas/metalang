#include<stdio.h>
#include<stdlib.h>

int nth(char* tab, char tofind, int len){
  int i;
  int out_ = 0;
  for (i = 0 ; i < len; i++)
    if (tab[i] == tofind)
    out_ ++;
  return out_;
}

int main(void){
  int i;
  int len = 0;
  scanf("%d ", &len);
  char tofind = '\000';
  scanf("%c ", &tofind);
  char *tab = malloc( len * sizeof(char));
  for (i = 0 ; i < len; i++)
  {
    char tmp = '\000';
    scanf("%c", &tmp);
    tab[i] = tmp;
  }
  int result = nth(tab, tofind, len);
  printf("%d", result);
  return 0;
}


