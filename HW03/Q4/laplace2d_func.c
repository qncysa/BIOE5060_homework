#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "laplace2d_func.h"

#define ABS(x) (((x)>0)?(x):-(x))



void get_input(grid *grid2d, int argc, char **argv) {
    if (argc < 5) {
        printf("format: cmd Nx Ny tol omega\n");
        exit(0);
    }
    
    sscanf(argv[1], "%d", &grid2d->Nx);
    sscanf(argv[2], "%d", &grid2d->Ny);
    sscanf(argv[3], "%lf", &grid2d->tol);
    sscanf(argv[4], "%e", &grid2d->omega);
    
    // Basic input validation
    if (grid2d->Nx <= 0 || grid2d->Ny <= 0) {
        printf("error: Nx and Ny must be positive integers.\n");
        exit(1);
    }
    if (grid2d->tol <= 0) {
        printf("error: tolerance (tol) must be a positive value.\n");
        exit(1);
    }
    if (grid2d->omega <= 0) {
        printf("error: omega must be a positive value.\n");
        exit(1);
    }
}

void init_domain(grid *grid2d) {
    int t, x;
    
    // Dynamically allocate the 3D buffer
    for (t = 0; t < 2; t++) {
        grid2d->field[t] = (double **)malloc(grid2d->Nx * sizeof(double *));
        
        if (grid2d->field[t] == NULL) {
            printf("error: memory allocation failed for field[%d].\n", t);
            exit(1);
        }
        
        for (x = 0; x < grid2d->Nx; x++) {
            grid2d->field[t][x] = (double *)calloc(grid2d->Ny, sizeof(double));
            
            if (grid2d->field[t][x] == NULL) {
                printf("error: memory allocation failed for field[%d][%d].\n", t, x);
                exit(1);
            }
        }
    }
    
    // initialize boundary condition (assuming top boundary is set to 1.0)
    for (int y = 0; y < grid2d->Ny; y++) {
        grid2d->field[0][0][y] = 1.0;
        grid2d->field[1][0][y] = 1.0; // initialize both fields for consistency
    }
}

void update_domain(grid *grid2d) {
    int x, y, tk0, tk1, counter = 0;
    double delta = 1e10;
    
    while (delta > grid2d->tol) {
        delta = 0.0;
        tk0 = (counter % 2);
        tk1 =!(counter % 2);
        
        for (x = 1; x < grid2d->Nx - 1; x++) {
            for (y = 1; y < grid2d->Ny - 1; y++) {
                grid2d->field[tk1][x][y] = (1 - grid2d->omega) * grid2d->field[tk1][x][y] +
                                            grid2d->omega * (grid2d->field[tk0][x - 1][y] +
                                                             grid2d->field[tk0][x + 1][y] +
                                                             grid2d->field[tk0][x][y - 1] +
                                                             grid2d->field[tk0][x][y + 1]) * 0.25;
                delta += ABS(grid2d->field[tk1][x][y] - grid2d->field[tk0][x][y]);
            }
        }
        
        if (!((counter++) % 1000)) {
            printf("iter=%d delta=%f\n", counter, delta);
        }
    }
    
    printf("convergence after %d iterations.\n", counter);
}

void free_domain(grid *grid2d) {
    int t, x;
    
    for (t = 0; t < 2; t++) {
        for (x = 0; x < grid2d->Nx; x++) {
            free(grid2d->field[t][x]);
        }
        free(grid2d->field[t]);
    }
}