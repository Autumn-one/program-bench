use std::time::Instant;

fn fib(n: i32) -> i64 {
    if n <= 1 {
        return n as i64;
    }
    fib(n - 1) + fib(n - 2)
}

fn main() {
    let start = Instant::now();
    let result = fib(41);
    let elapsed_ms = start.elapsed().as_secs_f64() * 1000.0;
    
    println!("Result: {}", result);
    println!("Rust: {:.2} ms", elapsed_ms);
}
