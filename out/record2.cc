#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
class toto {
public:
  int foo;
  int bar;
  int blah;
};

toto * mktoto(int v1){
  toto * t = new toto();
  t->foo=v1;
  t->bar=0;
  t->blah=0;
  return t;
}

int result(toto * t){
  t->blah ++;
  return t->foo + t->blah * t->bar + t->bar * t->foo;
}


int main(void){
  toto * t = mktoto(4);
  scanf("%d", &t->bar);
  scanf("%*[ \t\r\n]c");
  scanf("%d", &t->blah);
  int a = result(t);
  std::cout << a;
  int b = t->blah;
  std::cout << b;
  return 0;
}

