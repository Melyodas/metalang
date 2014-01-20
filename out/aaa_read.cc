#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>


/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/

int main(void){
  int len = 0;
  scanf("%d", &len);
  scanf("%*[ \t\r\n]c", 0);
  printf("%d", len);
  std::cout << "=len\n";
  std::vector<int > tab( len );
  for (int i = 0 ; i < len; i++)
  {
    int tmpi1 = 0;
    scanf("%d", &tmpi1);
    scanf("%*[ \t\r\n]c", 0);
    printf("%d", i);
    std::cout << "=>";
    printf("%d", tmpi1);
    std::cout << " ";
    tab.at(i) = tmpi1;
  }
  std::cout << "\n";
  std::vector<int > tab2( len );
  for (int i_ = 0 ; i_ < len; i_++)
  {
    int tmpi2 = 0;
    scanf("%d", &tmpi2);
    scanf("%*[ \t\r\n]c", 0);
    printf("%d", i_);
    std::cout << "==>";
    printf("%d", tmpi2);
    std::cout << " ";
    tab2.at(i_) = tmpi2;
  }
  int strlen = 0;
  scanf("%d", &strlen);
  scanf("%*[ \t\r\n]c", 0);
  printf("%d", strlen);
  std::cout << "=strlen\n";
  std::vector<char > tab4( strlen );
  for (int toto = 0 ; toto < strlen; toto++)
  {
    char tmpc = '_';
    scanf("%c", &tmpc);
    int c = tmpc;
    printf("%c", tmpc);
    std::cout << ":";
    printf("%d", c);
    std::cout << " ";
    if (tmpc != ' ')
      c = ((c - 'a') + 13) % 26 + 'a';
    tab4.at(toto) = c;
  }
  for (int j = 0 ; j < strlen; j++)
  {
    char a = tab4.at(j);
    printf("%c", a);
  }
  return 0;
}

