#include <iostream>
#include <vector>
class tuple_int_int {
public:
  int tuple_int_int_field_0;
  int tuple_int_int_field_1;
};

class toto {
public:
  tuple_int_int * foo;
  int bar;
};


int main(){
  int d, c, bar_;
  std::cin >> bar_ >> std::skipws >> c >> d;
  tuple_int_int * e = new tuple_int_int();
  e->tuple_int_int_field_0=c;
  e->tuple_int_int_field_1=d;
  toto * t = new toto();
  t->foo=e;
  t->bar=bar_;
  tuple_int_int * f = t->foo;
  int a = f->tuple_int_int_field_0;
  int b = f->tuple_int_int_field_1;
  std::cout << a << " " << b << " " << t->bar << "\n";
  return 0;
}
