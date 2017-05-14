#include <stdio.h>
#include <string.h>
#include <cuda_runtime.h>

#define SHARED_MEMORY_MAX 10000
__global__ void kernel(int *buf, int len) {
    __shared__ int sm;
    int tid = blockIdx.x * blockDim.x + threadIdx.x;
    if(len <= tid) return;

    if(tid == 0) sm = 0;

    __syncthreads();

    sm += buf[tid];

    __syncthreads();

    if(tid == 0) buf[0] = sm;
}

#define NUM_BLOCKS 1024
#define NUM_THREADS 512

int gpu(const int* buf, int len) {
	printf("[GPU Implement]\n");
	
	int* gbuf = NULL;
	cudaMalloc((void**)&gbuf, sizeof(int) * len);
	cudaMemcpy(gbuf, buf, sizeof(int) * len, cudaMemcpyHostToDevice);
	
	kernel<<<NUM_BLOCKS, NUM_THREADS>>>(gbuf, len);

	int* nbuf = (int*)malloc(sizeof(int) * len);
	
	cudaMemcpy(nbuf, gbuf, sizeof(int) * len, cudaMemcpyDeviceToHost);
	int result = nbuf[0];

	cudaFree(gbuf);
	free(nbuf);
	
	cudaDeviceReset();

	return result;
}
