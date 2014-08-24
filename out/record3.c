#include<stdio.h>
#include<stdlib.h>

typedef struct toto {
  int foo;
  int bar;
  int blah;
} toto;

struct toto * mktoto(int v1){
  struct toto * t = malloc (sizeof(t) );
  t->foo=v1;
  t->bar=0;
  t->blah=0;
  return t;
}

int result(struct toto ** t, int len){
  int j;
  int out_ = 0;
  for (j = 0 ; j < len; j++)
  {
    t[j]->blah = t[j]->blah + 1;
    out_ = out_ + t[j]->foo + t[j]->blah * t[j]->bar + t[j]->bar * t[j]->foo;
  }
  return out_;
}

int main(void){
  int i;
  struct toto * *t = malloc( 4 * sizeof(struct toto *));
  for (i = 0 ; i < 4; i++)
    t[i] = mktoto(i);
  scanf("%d %d", &t[0]->bar, &t[1]->blah);
  int titi = result(t, 4);
  printf("%d%d", titi, t[2]->blah);
  return 0;
}


