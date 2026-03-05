#!/usr/bin/env python3
import time

def fib(n):
    if n <= 1:
        return n
    return fib(n - 1) + fib(n - 2)

if __name__ == "__main__":
    start = time.perf_counter()
    result = fib(41)
    elapsed_ms = (time.perf_counter() - start) * 1000
    
    print(f"Result: {result}")
    print(f"Python: {elapsed_ms:.2f} ms")
