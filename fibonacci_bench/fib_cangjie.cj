import std.time.*

func fib(n: Int64): Int64 {
    if (n <= 1) {
        return n
    }
    return fib(n - 1) + fib(n - 2)
}

main() {
    let start = DateTime.now()
    let result = fib(41)
    let end = DateTime.now()
    let elapsed_ms = (end - start).toMilliseconds()
    
    println("Result: ${result}")
    println("Cangjie: ${elapsed_ms} ms")
}
