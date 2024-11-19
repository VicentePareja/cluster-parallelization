import pandas as pd
import matplotlib.pyplot as plt

# Leer los resultados
data = pd.read_csv('resultados.txt', sep=' ', header=0)

# Tiempo secuencial (con 1 hilo)
t1 = data[data['Num_Threads'] == 1]['Tiempo_Ejecucion'].values[0]

# Calcular speedup y eficiencia
data['Speedup'] = t1 / data['Tiempo_Ejecucion']
data['Eficiencia'] = data['Speedup'] / data['Num_Threads']

# Guardar los resultados en un nuevo archivo
data.to_csv('resultados_completos.txt', index=False)

# Graficar Speedup
plt.figure()
plt.plot(data['Num_Threads'], data['Speedup'], marker='o')
plt.title('Speedup vs Número de Hilos')
plt.xlabel('Número de Hilos')
plt.ylabel('Speedup')
plt.grid(True)
plt.savefig('speedup.png')

# Graficar Eficiencia
plt.figure()
plt.plot(data['Num_Threads'], data['Eficiencia'], marker='o')
plt.title('Eficiencia vs Número de Hilos')
plt.xlabel('Número de Hilos')
plt.ylabel('Eficiencia')
plt.grid(True)
plt.savefig('eficiencia.png')

# Mostrar los gráficos (opcional)
# plt.show()
