#include <iostream>
#include <vector>

bool is_number(char c) {
    return (int)(c) <= (int)('9') && (int)(c) >= (int)('0');
}

/*
Notation polonaise inversée, ce test permet d'évaluer une expression écrite en NPI
*/

int npi0(std::vector<char>& str, int len) {
    std::vector<int> stack( len, 0 );
    int ptrStack = 0;
    int ptrStr = 0;
    while (ptrStr < len)
        if (str[ptrStr] == ' ')
            ptrStr += 1;
        else if (is_number(str[ptrStr]))
        {
            int num = 0;
            while (str[ptrStr] != ' ')
            {
                num = num * 10 + (int)(str[ptrStr]) - (int)('0');
                ptrStr += 1;
            }
            stack[ptrStack] = num;
            ptrStack += 1;
        }
        else if (str[ptrStr] == '+')
        {
            stack[ptrStack - 2] += stack[ptrStack - 1];
            ptrStack -= 1;
            ptrStr += 1;
        }
    return stack[0];
}


int main() {
    int len = 0;
    std::cin >> len;
    std::vector<char> tab( len );
    for (int i = 0; i < len; i += 1)
    {
        char tmp = '\u0000';
        std::cin >> tmp >> std::noskipws;
        tab[i] = tmp;
    }
    int result = npi0(tab, len);
    std::cout << result;
}
