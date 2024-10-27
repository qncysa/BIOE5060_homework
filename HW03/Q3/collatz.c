
#include <stdio.h>   // you need to include stdio.h to use printf()
int main(int argc, char **argv) {
   int num;

if(argc < 2) {
  printf("format: cmd integer\n");
  return 0;
}

sscanf(argv[1], "%d", &num);

printf("%d", num);

  while(num != 1) {
    if(num % 2 == 0) {
      num = num / 2;
    }
    else {
      num = 3 * num + 1;
    }
    printf("\t%d", num);
  }
   return 0;
}

