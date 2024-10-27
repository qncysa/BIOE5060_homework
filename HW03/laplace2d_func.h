
#ifndef MY_2D_LAPLACE_SOLVER_H_
#define MY_2D_LAPLACE_SOLVER_H_
struct Grid2D {
  int Nx;
  int Ny;
  double tol; // convergence tolerance
  double omega; // successive over-relaxation parameter, 1.5
  double **field[2]; // 3D array field[time][x][y]
};

typedef struct Grid2D grid; // grid is a shortcut to struct Grid2D

// get_input uses command params to set
// grid2d->Nx, grid2d->Ny, grid2d->tol and grid2d->omega
void get_input(grid *grid2d, int argc, char **argv);

// dynamically allocate the 3D buffer, grid2d->field
// see how this is done in Unit 2-3’s notebook
void init_domain(grid *grid2d);

// perform the time stepping, i.e. the while-loop in the notebook
void update_domain(grid *grid2d);

// deallocate the buffer at the end
void free_domain(grid *grid2d);

#endif

