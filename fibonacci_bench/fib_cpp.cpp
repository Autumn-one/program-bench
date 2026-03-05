#include <iostream>
#include <chrono>

using namespace std;
using namespace std::chrono;

long long fib(int n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
}

int main() {
    auto start = high_resolution_clock::now();
    long long result = fib(41);
    auto end = high_resolution_clock::now();
    double elapsed_ms = duration<double, milli>(end - start).count();
    
    cout << "Result: " << result << endl;
    cout << "C++: " << elapsed_ms << " ms" << endl;
    
    return 0;
}
