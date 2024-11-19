#!/bin/bash

# Lista de números de hilos a probar
THREAD_LIST="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32"

# Archivo para almacenar los resultados
RESULTS_FILE="resultados.txt"

# Limpiar el archivo de resultados
echo "Num_Threads Tiempo_Ejecucion" > $RESULTS_FILE

# Loop para enviar trabajos con diferentes números de hilos
for THREADS in $THREAD_LIST; do
    # Crear un script SLURM temporal
    SLURM_SCRIPT="simulacion_${THREADS}.slurm"
    cat > $SLURM_SCRIPT << EOL
#!/bin/bash
#SBATCH --job-name=simulacion_calor_${THREADS}
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=${THREADS}
#SBATCH --time=01:00:00
#SBATCH --mem=16G
#SBATCH --output=output_${THREADS}.txt

export OMP_NUM_THREADS=\$SLURM_CPUS_PER_TASK

./simulacion >> output_${THREADS}.txt
EOL

    # Enviar el trabajo a SLURM
    sbatch $SLURM_SCRIPT
done
