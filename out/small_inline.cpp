#include <iostream>
#include <vector>

int main() {
    std::vector<int> t( 2 );
    for (int d = 0; d <= 1; d += 1)
    {
        std::cin >> t[d];
    }
    std::cout << t[0] << " - " << t[1] << "\n";
}
