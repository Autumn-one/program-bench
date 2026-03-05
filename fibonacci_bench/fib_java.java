public class fib_java {
    static long fib(int n) {
        if (n <= 1) return n;
        return fib(n - 1) + fib(n - 2);
    }
    
    public static void main(String[] args) {
        long start = System.nanoTime();
        long result = fib(41);
        long end = System.nanoTime();
        double elapsedMs = (end - start) / 1_000_000.0;
        
        System.out.println("Result: " + result);
        System.out.printf("Time: %.2f ms\n", elapsedMs);
    }
}
