#include <stdio.h>

int cpu(const int* buf, int len) {
	printf("[CPU Implement]\n");

	int sm = 0;
	for(int i = 0;i < len;i++) {
		sm += buf[i];
	}

	return sm;
}
