
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "laplace2d_func.h"

#define TOL 1e-5
#define ABS(x) (((x)>0)?(x):-(x))

int main(void) {
  double **field[2] = {NULL, NULL};
  double delta = 1e10;
  int t, tk0, tk1, x, y, counter = 0;
  int Nx = 60;
  int Ny = 60;
  FILE *foutput;


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
  while(delta > TOL) {
    delta = 0.0;
    tk0=(counter % 2);    // iteration 1: counter=0, tk0=0, tk1=1, use field[0]->field[1]
    tk1=!(counter % 2);   // iteration 2: counter=1, tk0=1, tk1=0, use field[1]->field[0]
                          // iteration 3: counter=2, tk0=0, tk1=1, ...
    for(x = 1; x< Nx - 1; x++) {
      for(y = 1; y< Ny - 1; y++) {
        field[tk1][x][y] = (field[tk0][x - 1][y] + field[tk0][x + 1][y] + field[tk0][x][y - 1] + field[tk0][x][y + 1])*0.25;
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

