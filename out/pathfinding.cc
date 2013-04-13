#include <cstdlib>
#include <cstdio>
#include <iostream>
#include <vector>
int min2(int a, int b){
  if (a < b)
  {
    return a;
  }
  return b;
}

int min3(int a, int b, int c){
  return min2(min2(a, b), c);
}

int min4(int a, int b, int c, int d){
  return min3(min2(a, b), c, d);
}

int pathfind_aux(std::vector<std::vector<int > >& cache, std::vector<std::vector<char > >& tab, int x, int y, int posX, int posY){
  if ((posX == (x - 1)) && (posY == (y - 1)))
  {
    return 0;
  }
  else if ((((posX < 0) || (posY < 0)) || (posX >= x)) || (posY >= y))
  {
    return (x * y) * 10;
  }
  else if (tab.at(posY).at(posX) == '#')
  {
    return (x * y) * 10;
  }
  else if (cache.at(posY).at(posX) != (-1))
  {
    return cache.at(posY).at(posX);
  }
  else
  {
    cache.at(posY).at(posX) = (x * y) * 10;
    int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
    int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
    int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
    int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
    int out_ = 1 + min4(val1, val2, val3, val4);
    cache.at(posY).at(posX) = out_;
    return out_;
  }
}

int pathfind(std::vector<std::vector<char > >& tab, int x, int y){
  std::vector<std::vector<int > > cache( y );
  for (int i = 0 ; i <= y - 1; i ++)
  {
    std::vector<int > tmp( x );
    for (int j = 0 ; j <= x - 1; j ++)
    {
      tmp.at(j) = -1;
    }
    cache.at(i) = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}


int main(void){
  int x = 0;
  int y = 0;
  scanf("%d", &x);
  scanf("%*[ \t\r\n]c", 0);
  scanf("%d", &y);
  scanf("%*[ \t\r\n]c", 0);
  std::vector<std::vector<char > > tab( y );
  for (int i = 0 ; i <= y - 1; i ++)
  {
    std::vector<char > tab2( x );
    for (int j = 0 ; j <= x - 1; j ++)
    {
      char tmp = '\000';
      scanf("%c", &tmp);
      tab2.at(j) = tmp;
    }
    scanf("%*[ \t\r\n]c", 0);
    tab.at(i) = tab2;
  }
  int result = pathfind(tab, x, y);
  printf("%d", result);
  return 0;
}

