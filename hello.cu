#include <stdio.h>

const int ARRAY_SIZE = 1000000;
__managed__ int vector_a[ARRAY_SIZE], vector_b[ARRAY_SIZE], vector_c[ARRAY_SIZE];

__global__ void add_threaded(int* a, int* b, int* c) {
    int i = threadIdx.x + blockDim.x * blockIdx.x;
    c[i] = a[i] + b[i];
}

void add_unthreaded(int* a, int* b, int* c) {
    for (int i = 0; i < ARRAY_SIZE; i++) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    for (int i = 0; i < ARRAY_SIZE; i++) {
        vector_a[i] = i;
        vector_b[i] = ARRAY_SIZE - i;
    }

    cudaEvent_t start, stop;

    float milliseconds = 0;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    add_threaded<<<1, ARRAY_SIZE>>>(vector_a, vector_b, vector_c);
    cudaDeviceSynchronize();
    cudaEventRecord(stop);

    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&milliseconds, start, stop);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    printf("Time to generate threaded:    %3.6f ms \n", milliseconds);

    milliseconds = 0;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    add_unthreaded(vector_a, vector_b, vector_c);
    cudaDeviceSynchronize();
    cudaEventRecord(stop);

    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&milliseconds, start, stop);

    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    printf("Time to generate unthreaded:  %3.6f ms \n", milliseconds);
}