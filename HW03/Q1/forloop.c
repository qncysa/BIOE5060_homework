
#include <stdio.h>   // you need to include stdio.h to use printf()
int main(int argc, char **argv) {
   int a, b;
   for(a=-20, b=-30; a >= b; a++, b+=2) {
      printf("a=%d\tb=%d\n", a, b);
   }
   return 0;
}

