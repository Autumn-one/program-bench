function fib(n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
}

const start = performance.now();
const result = fib(41);
const elapsedMs = performance.now() - start;

console.log(`Result: ${result}`);
console.log(`JavaScript: ${elapsedMs.toFixed(2)} ms`);
