import time

fn fib(n int) i64 {
    if n <= 1 {
        return i64(n)
    }
    return fib(n - 1) + fib(n - 2)
}

fn main() {
    // 使用 stopwatch 获取更准确的时间
    mut sw := time.new_stopwatch()
    result := fib(41)
    elapsed_ms := sw.elapsed().milliseconds()
    
    println('Result: ${result}')
    println('V: ${elapsed_ms} ms')
}
