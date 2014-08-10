#include <iostream>
#include <vector>
std::vector<char> *getline(){
  if (std::cin.flags() & std::ios_base::skipws){
    std::cin.ignore();
    std::cin.unsetf(std::ios::skipws);
  }
  std::string line;
  std::getline(std::cin, line);
  std::vector<char> *c = new std::vector<char>(line.begin(), line.end());
  return c;
}
int min2(int a, int b){
  if (a < b)
    return a;
  else
    return b;
}

int min3(int a, int b, int c){
  return min2(min2(a, b), c);
}

int min4(int a, int b, int c, int d){
  return min3(min2(a, b), c, d);
}

int read_int(){
  int out_ = 0;
  std::cin >> out_ >> std::skipws;
  return out_;
}

std::vector<char> * read_char_line(int n){
  return getline();
}

std::vector<std::vector<char> *> * read_char_matrix(int x, int y){
  std::vector<std::vector<char> * > *tab = new std::vector<std::vector<char> *>( y );
  for (int z = 0 ; z < y; z++)
    tab->at(z) = read_char_line(x);
  return tab;
}

int pathfind_aux(std::vector<std::vector<int> *> * cache, std::vector<std::vector<char> *> * tab, int x, int y, int posX, int posY){
  if (posX == x - 1 && posY == y - 1)
    return 0;
  else if (posX < 0 || posY < 0 || posX >= x || posY >= y)
    return x * y * 10;
  else if (tab->at(posY)->at(posX) == '#')
    return x * y * 10;
  else if (cache->at(posY)->at(posX) != -1)
    return cache->at(posY)->at(posX);
  else
  {
    cache->at(posY)->at(posX) = x * y * 10;
    int val1 = pathfind_aux(cache, tab, x, y, posX + 1, posY);
    int val2 = pathfind_aux(cache, tab, x, y, posX - 1, posY);
    int val3 = pathfind_aux(cache, tab, x, y, posX, posY - 1);
    int val4 = pathfind_aux(cache, tab, x, y, posX, posY + 1);
    int out_ = 1 + min4(val1, val2, val3, val4);
    cache->at(posY)->at(posX) = out_;
    return out_;
  }
}

int pathfind(std::vector<std::vector<char> *> * tab, int x, int y){
  std::vector<std::vector<int> * > *cache = new std::vector<std::vector<int> *>( y );
  for (int i = 0 ; i < y; i++)
  {
    std::vector<int > *tmp = new std::vector<int>( x );
    for (int j = 0 ; j < x; j++)
    {
      std::cout << tab->at(i)->at(j);
      tmp->at(j) = -1;
    }
    std::cout << "\n";
    cache->at(i) = tmp;
  }
  return pathfind_aux(cache, tab, x, y, 0, 0);
}


int main(){
  int x = read_int();
  int y = read_int();
  std::cout << x << " " << y << "\n";
  std::vector<std::vector<char> *> * tab = read_char_matrix(x, y);
  int result = pathfind(tab, x, y);
  std::cout << result;
  return 0;
}

