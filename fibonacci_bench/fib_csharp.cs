using System;
using System.Diagnostics;

class FibCSharp
{
    static long Fib(int n)
    {
        if (n <= 1) return n;
        return Fib(n - 1) + Fib(n - 2);
    }
    
    static void Main()
    {
        var sw = Stopwatch.StartNew();
        long result = Fib(41);
        sw.Stop();
        double elapsedMs = sw.Elapsed.TotalMilliseconds;
        
        Console.WriteLine($"Result: {result}");
        Console.WriteLine($"C#: {elapsedMs:F2} ms");
    }
}
