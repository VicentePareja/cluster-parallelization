#!/bin/bash

# Archivo para almacenar los resultados
RESULTS_FILE="resultados.txt"

# Escribir el encabezado
echo "Num_Threads Tiempo_Ejecucion" > $RESULTS_FILE

# Lista de números de hilos a probar (debe coincidir con el anterior)
THREAD_LIST="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32"

for THREADS in $THREAD_LIST; do
    OUTPUT_FILE="output_${THREADS}.txt"
    if [ -f $OUTPUT_FILE ]; then
        # Extraer el tiempo de ejecución del archivo de salida
        TIME=$(grep "Tiempo de ejecución" $OUTPUT_FILE | awk '{print $4}')
        echo "${THREADS} ${TIME}" >> $RESULTS_FILE
    else
        echo "Archivo ${OUTPUT_FILE} no encontrado."
    fi
done
