#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int a, b;
    /*
	a + b + c = 1000 && a * a + b * b = c * c
	*/
    for (a = 1; a < 1001; a++)
        for (b = a + 1; b < 1001; b++)
        {
            int c = 1000 - a - b;
            int a2b2 = a * a + b * b;
            int cc = c * c;
            if (cc == a2b2 && c > a)
                printf("%d\n%d\n%d\n%d\n", a, b, c, a * b * c);
        }
    return 0;
}


