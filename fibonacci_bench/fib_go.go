package main

import (
	"fmt"
	"time"
)

func fib(n int) int64 {
	if n <= 1 {
		return int64(n)
	}
	return fib(n-1) + fib(n-2)
}

func main() {
	start := time.Now()
	result := fib(41)
	elapsed := time.Since(start).Milliseconds()
	
	fmt.Printf("Result: %d\n", result)
	fmt.Printf("Go: %d ms\n", elapsed)
}
