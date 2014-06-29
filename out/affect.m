#import <Foundation/Foundation.h>
#include<stdio.h>
#include<stdlib.h>

/*
Ce test permet de vérifier que l'implémentation de l'affectation fonctionne correctement
*/
@interface toto : NSObject
{
  @public int foo;
  @public int bar;
  @public int blah;
}
@end
@implementation toto 
@end

toto * mktoto(int v1){
  toto * t = [toto alloc];
  t->foo=v1;
  t->bar=v1;
  t->blah=v1;
  return t;
}

toto * mktoto2(int v1){
  toto * t = [toto alloc];
  t->foo=v1 + 3;
  t->bar=v1 + 2;
  t->blah=v1 + 1;
  return t;
}

int result(toto * t_, toto * t2_){
  toto * t = t_;
  toto * t2 = t2_;
  toto * t3 = [toto alloc];
  t3->foo=0;
  t3->bar=0;
  t3->blah=0;
  t3 = t2;
  t = t2;
  t2 = t3;
  t->blah ++;
  int len = 1;
  int *cache0 = malloc( len * sizeof(int));
  {
    int i;
    for (i = 0 ; i < len; i++)
      cache0[i] = -i;
  }
  int *cache1 = malloc( len * sizeof(int));
  {
    int j;
    for (j = 0 ; j < len; j++)
      cache1[j] = j;
  }
  int* cache2 = cache0;
  cache0 = cache1;
  cache2 = cache0;
  return t->foo + t->blah * t->bar + t->bar * t->foo;
}

int main(void){
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  toto * t = mktoto(4);
  toto * t2 = mktoto(5);
  scanf("%d", &t->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t->blah);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t2->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t->blah);
  int a = result(t, t2);
  printf("%d", a);
  int b = t->blah;
  printf("%d", b);
  [pool drain];
  return 0;
}

