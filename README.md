## Pasos a Seguir:

# Desde tu pc

1. edita la cantidad de threads en run_simulacion.sh y colect_results.sh
2. Lleva todos los archivos run_simulacion.sh, colect_results.sh y simulacion.c al cluster utilizando scp

# Desde el cluster

3. compila simulacion.c

```
gcc -fopenmp -o simulacion simulacion.c
```

4. Ejecuta run_simulacion.sh

```
chmod +x run_simulacion.sh
./run_simulacion.sh
```
5. Espera. puedes ver con "ls" si se están creando los archivos. Para ver el contenido de un .txt puedes usar el comando 
```
cat archivo.txt
```
6. Unifica los outputs utilizando:
```
chmod +x collect_results.sh
./collect_results.sh
```

# Desde tu pc

7. Utilizando scp importa resultados.txt
8. utilizando analisis.py puedes crear los graficos.