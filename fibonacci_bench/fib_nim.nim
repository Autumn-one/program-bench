import times, strformat

proc fib(n: int): int64 =
  if n <= 1:
    return n.int64
  return fib(n - 1) + fib(n - 2)

let start = cpuTime()
let result = fib(41)
let elapsedMs = (cpuTime() - start) * 1000

echo &"Result: {result}"
echo &"Nim: {elapsedMs:.2f} ms"
