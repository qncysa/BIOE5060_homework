
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "laplace2d_func.h"

#define ABS(x) (((x)>0)?(x):-(x))

int main(int argc, char *argv[]) {
  double **field[2] = {NULL, NULL};
  double delta = 1e10, tol=1e-4;
  int t, tk0, tk1, x, y, Nx =0 , Ny=0, omega=0, counter = 0;
  FILE *foutput;

  //# v----------- please write the below code to read command parameters in the order of: Nx Ny tol omega

if(argc < 5) {
  printf("format: cmd Nx Ny tol omega\n");
  return 0;
}

sscanf(argv[1], "%d", &Nx);
sscanf(argv[2], "%d", &Ny);
sscanf(argv[3], "%lf", &tol);
sscanf(argv[4], "%d", &omega);


  //# ^----------- at this point, your Nx, Ny and tol variables must be read from input

  // allocate 3D array - first dimension first, then 2nd, ...
  for(t = 0; t < 2; t++) {
    field[t] = (double **)malloc(Nx*sizeof(double *));

    for(x = 0; x< Nx; x++) {
      field[t][x] = (double *)calloc(Ny, sizeof(double)); // use calloc to initialize to 0
    }
    for(y = 0; y< Ny; y++) {
      field[t][0][y]=1.0;
    }
  }

  // iterate the solution until changes (delta) falls under a preset tolerance TOL

  counter = 0;
  while(delta > tol) {
    delta = 0.0;
    tk0=(counter % 2);    // iteration 1: counter=0, tk0=0, tk1=1, use field[0]->field[1]
    tk1=!(counter % 2);   // iteration 2: counter=1, tk0=1, tk1=0, use field[1]->field[0]
                          // iteration 3: counter=2, tk0=0, tk1=1, ...
    for(x = 1; x< Nx - 1; x++) {
      for(y = 1; y< Ny - 1; y++) {
        field[tk1][x][y] = (1-omega)*field[tk1][x][y] + omega*(field[tk0][x - 1][y] + field[tk0][x + 1][y] + field[tk0][x][y - 1] + field[tk0][x][y + 1])*0.25;
        delta += ABS(field[tk1][x][y] - field[tk0][x][y]);
      }
    }
    if(!((counter++) % 1000)){
      printf("iter=%d delta=%f\n", counter, delta);
    }
  }

  foutput = fopen("laplaceoutput.txt", "wt");
  for(x = 0; x< Nx; x++) {
    for(y = 0; y< Ny; y++) {
      fprintf(foutput, "%e\t", field[tk1][x][y]);
    }
    fprintf(foutput, "\n");
  }
  fclose(foutput);

  // free the dynamic 2D array
  for(t = 0; t < 2; t++) {
    for(x = 0; x< Nx; x++) {
      free(field[t][x]);
    }
    free(field[t]);
  }
}
