#include <iostream>
#include <vector>
#include <algorithm>

std::vector<int> * primesfactors(int n) {
    std::vector<int> *tab = new std::vector<int>( n + 1 );
    std::fill(tab->begin(), tab->end(), 0);
    int d = 2;
    while (n != 1 && d * d <= n)
        if (n % d == 0)
        {
            tab->at(d) += 1;
            n /= d;
        }
        else
            d += 1;
    tab->at(n) += 1;
    return tab;
}


int main() {
    int lim = 20;
    std::vector<int> *o = new std::vector<int>( lim + 1 );
    std::fill(o->begin(), o->end(), 0);
    for (int i = 1; i <= lim; i += 1)
    {
        std::vector<int> * t = primesfactors(i);
        for (int j = 1; j <= i; j += 1)
            o->at(j) = std::max(o->at(j), t->at(j));
    }
    int product = 1;
    for (int k = 1; k <= lim; k += 1)
        for (int l = 1; l <= o->at(k); l += 1)
            product *= k;
    std::cout << product << "\n";
}

