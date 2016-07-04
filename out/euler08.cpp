#include <iostream>
#include <vector>
#include <algorithm>

int main() {
    char e, c;
    int i = 1;
    std::vector<int> last( 5 );
    for (int j = 0; j <= 4; j += 1)
    {
        std::cin >> c >> std::noskipws;
        int d = (int)(c) - (int)('0');
        i *= d;
        last[j] = d;
    }
    int max0 = i;
    int index = 0;
    int nskipdiv = 0;
    for (int k = 1; k <= 995; k += 1)
    {
        std::cin >> e >> std::noskipws;
        int f = (int)(e) - (int)('0');
        if (f == 0)
        {
            i = 1;
            nskipdiv = 4;
        }
        else
        {
            i *= f;
            if (nskipdiv < 0)
                i /= last[index];
            nskipdiv -= 1;
        }
        last[index] = f;
        index = (index + 1) % 5;
        max0 = std::max(max0, i);
    }
    std::cout << max0 << "\n";
}
