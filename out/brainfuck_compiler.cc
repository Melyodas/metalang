#include <iostream>
#include <vector>
/*
Ce test permet de tester les macros
C'est un compilateur brainfuck qui lit sur l'entrée standard pendant la compilation
et qui produit les macros metalang correspondante
*/

int main(){
  char input = ' ';
  int current_pos = 500;
  int a = 1000;
  std::vector<int > *mem = new std::vector<int>( a );
  for (int i = 0 ; i < a; i++)
    mem->at(i) = 0;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  current_pos ++;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  mem->at(current_pos) = mem->at(current_pos) + 1;
  while (mem->at(current_pos) != 0)
  {
    mem->at(current_pos) = mem->at(current_pos) - 1;
    current_pos --;
    mem->at(current_pos) = mem->at(current_pos) + 1;
    std::cout << (char)(mem->at(current_pos));
    current_pos ++;
  }
  return 0;
}

