#!/usr/bin/env ruby

def fib(n)
  return n if n <= 1
  fib(n - 1) + fib(n - 2)
end

start = Time.now
result = fib(41)
elapsed_ms = (Time.now - start) * 1000

puts "Result: #{result}"
puts "Ruby: #{elapsed_ms.round(2)} ms"
