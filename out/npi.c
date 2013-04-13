#include<stdio.h>
#include<stdlib.h>


int is_number(char c){
  return (c <= '9') && (c >= '0');
}

/*
Notation polonaise inversée
*/
int npi_(char* str, int len){
  int *stack = malloc( len * sizeof(int));
  
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      stack[i] = 0;
    }
  }
  int ptrStack = 0;
  int ptrStr = 0;
  while (ptrStr < len)
  {
    if (str[ptrStr] == ' ')
    {
      ptrStr = ptrStr + 1;
    }
    else if (is_number(str[ptrStr]))
    {
      int num = 0;
      while (str[ptrStr] != ' ')
      {
        num = num * 10 + str[ptrStr] - '0';
        ptrStr = ptrStr + 1;
      }
      stack[ptrStack] = num;
      ptrStack = ptrStack + 1;
    }
    else if (str[ptrStr] == '+')
    {
      stack[ptrStack - 2] = stack[ptrStack - 2] + stack[ptrStack - 1];
      ptrStack = ptrStack - 1;
      ptrStr = ptrStr + 1;
    }
  }
  return stack[0];
}

int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  char *tab = malloc( len * sizeof(char));
  
  {
    int i;
    for (i = 0 ; i < len; i++)
    {
      char tmp = '\000';
      scanf("%c", &tmp);
      tab[i] = tmp;
    }
  }
  int result = npi_(tab, len);
  printf("%d", result);
  return 0;
}

