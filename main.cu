#include <stdio.h>
#include <time.h>

int cpu(const int* buf, int len);
int gpu(const int* buf, int len);

#define BUF_SIZE 100

int main(int argc, char **argv) {
	clock_t start, end;

	int* buf = (int*)malloc(sizeof(int) * BUF_SIZE);
	for(int i = 0;i < BUF_SIZE;i++) buf[i] = i;

	int result;

	start = clock();
	result = cpu(buf, BUF_SIZE);
	end = clock();
	printf("%d ms (res : %d)\n", (end - start), result);

	start = clock();
	result = gpu(buf, BUF_SIZE);
	end = clock();
	printf("%d ms (res : %d)\n", (end - start), result);
}
