# CUDA
Trabalho desenvolvido como TDE da matéria de Programação e Paralela Distribuída.

# Requisitos
1. Ter uma placa de vídeo NVIDIA.
2. Ter o Visual Studio instalado.
3. Configurar o caminho "C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.29.30133\bin\Hostx64\x64" no PATH.
4. Ter o CUDA Toolkit instalado.

# Compilando e Executando
```bat
  nvcc hello.cu -o hello
  ./hello.exe
```

# Resultados
| Execução | Com Threads (ms) | Sem Threads (ms) |
|----------|------------------|------------------|
| 1        | 0.057344         | 0.080864         |
| 2        | 0.066560         | 0.080896         |
| 3        | 0.060416         | 0.091136         |
