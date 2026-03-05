function fib(n::Int)
    if n <= 1
        return n
    end
    return fib(n - 1) + fib(n - 2)
end

start = time()
result = fib(41)
elapsed_ms = (time() - start) * 1000

println("Result: $result")
println("Time: $(round(elapsed_ms, digits=2)) ms")
