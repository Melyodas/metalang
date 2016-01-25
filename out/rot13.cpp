#include <iostream>
#include <vector>
/*
Ce test effectue un rot13 sur une chaine lue en entrée
*/

int main(){
  int strlen;
  char tmpc;
  std::cin >> strlen >> std::skipws;
  std::vector<char> tab4(strlen);
  for (int toto = 0 ; toto < strlen; toto++)
  {
    std::cin >> tmpc >> std::noskipws;
    int c = (int)(tmpc);
    if (tmpc != ' ')
      c = (c - (int)('a') + 13) % 26 + (int)('a');
    tab4[toto] = (char)(c);
  }
  for (int j = 0 ; j < strlen; j++)
    std::cout << tab4[j];
}

