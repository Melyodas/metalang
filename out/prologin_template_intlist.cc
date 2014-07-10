#include <iostream>
#include <vector>
int read_int(){
  int out_ = 0;
  std::cin >> out_ >> std::skipws;
  return out_;
}

std::vector<int > read_int_line(int n){
  std::vector<int > tab( n );
  for (int i = 0 ; i < n; i++)
  {
    int t = 0;
    std::cin >> t >> std::skipws;
    tab.at(i) = t;
  }
  return tab;
}

int programme_candidat(std::vector<int >& tableau, int taille){
  int out_ = 0;
  for (int i = 0 ; i < taille; i++)
    out_ += tableau.at(i);
  return out_;
}


int main(){
  int b = 0;
  std::cin >> b >> std::skipws;
  int a = b;
  int taille = a;
  int d = taille;
  std::vector<int > e( d );
  for (int f = 0 ; f < d; f++)
  {
    int g = 0;
    std::cin >> g >> std::skipws;
    e.at(f) = g;
  }
  std::vector<int > c = e;
  std::vector<int > tableau = c;
  std::cout << programme_candidat(tableau, taille) << "\n";
  return 0;
}

