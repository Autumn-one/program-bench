#include <stdio.h>
#include <time.h>

long long fib(int n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
}

int main() {
    clock_t start = clock();
    long long result = fib(41);
    clock_t end = clock();
    double elapsed_ms = ((double)(end - start)) / CLOCKS_PER_SEC * 1000.0;
    
    printf("Result: %lld\n", result);
    printf("C: %.2f ms\n", elapsed_ms);
    
    return 0;
}
