
#include <stdio.h>   // you need to include stdio.h to use printf()
int main(int argc, char **argv) {
   int count;
   int fizz = 3, buzz = 5, fizzbuzz = 15;
   for(count=1; count <= 100; count++) {
      if(count % fizzbuzz == 0) {
        printf("FizzBuzz");
      }
      else if(count % fizz == 0) {
        printf("Fizz");
      }
      else if(count % buzz == 0) {
        printf("Buzz");
      }
      else {
        printf("%d", count);
   }
   if(count <100) {
      printf(", ");
   }
   }
   return 0;
}

