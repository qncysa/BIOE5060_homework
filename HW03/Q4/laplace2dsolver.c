#include "laplace2d_func.h"

void main(int argc, char **argv){
    grid domain;

    get_input(&domain, argc, argv);

    init_domain(&domain);

    update_domain(&domain);

    free_domain(&domain);
}

