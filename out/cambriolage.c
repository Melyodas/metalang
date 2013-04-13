#include<stdio.h>
#include<stdlib.h>

int count(void* a){ return ((int*)a)[-1]; }

int max2(int a, int b){
  if (a > b)
  {
    return a;
  }
  return b;
}

int nbPassePartout(int n, int** passepartout, int m, int** serrures){
  int max_ancient = 0;
  int max_recent = 0;
  {
    int i;
    for (i = 0 ; i <= m - 1; i++)
    {
      if ((serrures[i][0] == (-1)) && (serrures[i][1] > max_ancient))
      {
        max_ancient = serrures[i][1];
      }
      if ((serrures[i][0] == 1) && (serrures[i][1] > max_recent))
      {
        max_recent = serrures[i][1];
      }
    }
  }
  int max_ancient_pp = 0;
  int max_recent_pp = 0;
  {
    int i;
    for (i = 0 ; i <= n - 1; i++)
    {
      int* pp = passepartout[i];
      if ((pp[0] >= max_ancient) && (pp[1] >= max_recent))
      {
        return 1;
      }
      max_ancient_pp = max2(max_ancient_pp, pp[0]);
      max_recent_pp = max2(max_recent_pp, pp[1]);
    }
  }
  if ((max_ancient_pp >= max_ancient) && (max_recent_pp >= max_recent))
  {
    return 2;
  }
  else
  {
    return 0;
  }
}

int main(void){
  int n = 0;
  scanf("%d", &n);
  scanf("%*[ \t\r\n]c", 0);
  int* *passepartout = malloc( (n) * sizeof(int*) + sizeof(int));
  ((int*)passepartout)[0]=n;
  passepartout=(int**)( ((int*)passepartout)+1);
  {
    int i;
    for (i = 0 ; i <= n - 1; i++)
    {
      int c = 2;
      int *out0 = malloc( (c) * sizeof(int) + sizeof(int));
      ((int*)out0)[0]=c;
      out0=(int*)( ((int*)out0)+1);
      {
        int j;
        for (j = 0 ; j <= c - 1; j++)
        {
          int out_ = 0;
          scanf("%d", &out_);
          scanf("%*[ \t\r\n]c", 0);
          out0[j] = out_;
        }
      }
      passepartout[i] = out0;
    }
  }
  int m = 0;
  scanf("%d", &m);
  scanf("%*[ \t\r\n]c", 0);
  int* *serrures = malloc( (m) * sizeof(int*) + sizeof(int));
  ((int*)serrures)[0]=m;
  serrures=(int**)( ((int*)serrures)+1);
  {
    int i;
    for (i = 0 ; i <= m - 1; i++)
    {
      int d = 2;
      int *out0 = malloc( (d) * sizeof(int) + sizeof(int));
      ((int*)out0)[0]=d;
      out0=(int*)( ((int*)out0)+1);
      {
        int j;
        for (j = 0 ; j <= d - 1; j++)
        {
          int out_ = 0;
          scanf("%d", &out_);
          scanf("%*[ \t\r\n]c", 0);
          out0[j] = out_;
        }
      }
      serrures[i] = out0;
    }
  }
  int e = nbPassePartout(n, passepartout, m, serrures);
  printf("%d", e);
  return 0;
}


