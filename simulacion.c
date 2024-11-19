#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#define SIZE 3000
#define STEPS 10000

int main() {
    double *grid1 = malloc(SIZE * SIZE * sizeof(double));
    double *grid2 = malloc(SIZE * SIZE * sizeof(double));
    if (grid1 == NULL || grid2 == NULL) {
        fprintf(stderr, "Error: No se pudo asignar memoria para las mallas.\n");
        return EXIT_FAILURE;
    }

    int i, j, step;
    int num_threads;

    // Obtener el número de hilos
    #pragma omp parallel
    {
        #pragma omp master
        num_threads = omp_get_num_threads();
    }

    // Medir el tiempo de inicio
    double start_time = omp_get_wtime();

    // Inicializar grid1 a cero
    #pragma omp parallel for
    for (i = 0; i < SIZE * SIZE; i++) {
        grid1[i] = 0.0;
    }

    // Establecer la fuente de calor en el centro
    grid1[(SIZE / 2) * SIZE + (SIZE / 2)] = 10000.0;

    for (step = 0; step < STEPS; step++) {
        #pragma omp parallel for collapse(2)
        for (i = 1; i < SIZE - 1; i++) {
            for (j = 1; j < SIZE - 1; j++) {
                grid2[i * SIZE + j] = 0.25 * (
                    grid1[(i - 1) * SIZE + j] +
                    grid1[(i + 1) * SIZE + j] +
                    grid1[i * SIZE + (j - 1)] +
                    grid1[i * SIZE + (j + 1)]
                );
            }
        }

        // Intercambiar las mallas
        double *temp = grid1;
        grid1 = grid2;
        grid2 = temp;
    }

    // Medir el tiempo de finalización
    double end_time = omp_get_wtime();
    double execution_time = end_time - start_time;

    // Imprimir el tiempo de ejecución y el número de hilos
    printf("Número de hilos: %d\n", num_threads);
    printf("Tiempo de ejecución: %f segundos\n", execution_time);
    printf("Valor final en el centro de la malla: %f\n", grid1[(SIZE / 2) * SIZE + (SIZE / 2)]);

    free(grid1);
    free(grid2);

    return 0;
}
