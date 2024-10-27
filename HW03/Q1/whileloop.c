
#include <stdio.h>   // you need to include stdio.h to use printf()
int main(int argc, char **argv) {
   int a = -20, b = -30;
   while(a >= b) {
      printf("a=%d\tb=%d\n", a, b);
      a++, b+=2;
   }
   return 0;
}

