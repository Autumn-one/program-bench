function fib(n)
    if n <= 1 then
        return n
    end
    return fib(n - 1) + fib(n - 2)
end

local start = os.clock()
local result = fib(41)
local elapsed_ms = (os.clock() - start) * 1000

print(string.format("Result: %d", result))
print(string.format("Time: %.2f ms", elapsed_ms))
