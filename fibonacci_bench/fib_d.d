import std.stdio;
import std.datetime.stopwatch;

long fib(int n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
}

void main() {
    auto sw = StopWatch(AutoStart.yes);
    long result = fib(41);
    sw.stop();
    double elapsed_ms = sw.peek().total!"usecs" / 1000.0;
    
    writeln("Result: ", result);
    writefln("D: %.2f ms", elapsed_ms);
}
