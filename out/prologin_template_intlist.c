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
  int e, b;
  scanf("%d ", &b);
  int taille = b;
  int *d = malloc( taille * sizeof(int));
  for (e = 0 ; e < taille; e++)
  {
    scanf("%d ", &d[e]);
  }
  int* tableau = d;
  printf("%d\n", programme_candidat(tableau, taille));
  return 0;
}


