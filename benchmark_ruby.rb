#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'time'

# 测试1：斐波那契数列（递归）
def fib_recursive(n)
  return n if n <= 1
  fib_recursive(n - 1) + fib_recursive(n - 2)
end

def test1_fibonacci_recursive
  fib_recursive(41)
end

# 测试2：斐波那契数列（迭代）
def test2_fibonacci_iterative
  n = 10000000
  return n if n <= 1
  
  a, b = 0, 1
  (2..n).each do
    a, b = b, (a + b) % 1000000007
  end
  b
end

# 测试3：质数筛选
def test3_prime_sieve
  limit = 20000000
  is_prime = Array.new(limit + 1, true)
  is_prime[0] = is_prime[1] = false
  
  i = 2
  while i * i <= limit
    if is_prime[i]
      (i * i..limit).step(i) do |j|
        is_prime[j] = false
      end
    end
    i += 1
  end
  
  is_prime.count(true)
end

# 测试4：快速排序
def test4_sorting
  srand(42)
  arr = Array.new(2000000) { rand(0..1000000) }
  arr.sort!
  arr[0]
end

# 测试5：字符串拼接
def test5_string_concat
  # 使用字符串乘法更高效
  str = 'a' * 20000000
  str.length
end

# 测试6：哈希表操作
def test6_hash_table
  hash_map = {}
  
  # 插入
  (0...1000000).each do |i|
    hash_map["key_#{i}"] = i
  end
  
  # 查询
  srand(42)
  found_count = 0
  (0...1000000).each do
    key = "key_#{rand(0..1000000)}"
    found_count += 1 if hash_map.key?(key)
  end
  
  found_count
end

# 测试7：文件I/O
def test7_file_io
  filename = 'test_file_ruby.txt'
  
  # 写入
  File.open(filename, 'w') do |f|
    (0...2000000).each do |i|
      f.puts "Line #{i}: This is a test line."
    end
  end
  
  # 读取
  count = 0
  File.open(filename, 'r') do |f|
    f.each_line { count += 1 }
  end
  
  # 清理
  File.delete(filename)
  
  count
end

# 测试8：内存分配与访问
def test8_memory_allocation
  data = []
  
  # 创建对象
  (0...1000000).each do |i|
    data << {
      id: i,
      value: i * 2,
      name: "item_#{i}"
    }
  end
  
  # 随机访问
  srand(42)
  total = 0
  (0...1000000).each do
    idx = rand(0...1000000)
    total += data[idx][:value]
  end
  
  total % 1000000
end

# 测试9：矩阵乘法
def test9_matrix_multiplication
  size = 400
  
  # 使用一维数组模拟二维矩阵，提高缓存命中率
  srand(42)
  a = Array.new(size * size) { rand }
  b = Array.new(size * size) { rand }
  c = Array.new(size * size, 0.0)
  
  # 矩阵乘法
  (0...size).each do |i|
    (0...size).each do |j|
      sum = 0.0
      (0...size).each do |k|
        sum += a[i * size + k] * b[k * size + j]
      end
      c[i * size + j] = sum
    end
  end
  
  (c[0] * 1000).to_i
end

# 测试10：字符串处理
def test10_string_processing
  # 创建长文本
  base = "The quick brown fox jumps over the lazy dog. "
  text = base * 1500000
  
  # 查找 "the" (不使用正则表达式)
  count = text.scan("the").length
  
  # 替换 "fox" 为 "cat"
  text = text.gsub("fox", "cat")
  
  # 分割：统计单词数 - 手动计数，避免创建巨大数组
  word_count = 0
  in_word = false
  
  text.each_char do |c|
    if c == ' ' || c == "\n" || c == "\t"
      if in_word
        word_count += 1
        in_word = false
      end
    else
      in_word = true
    end
  end
  
  # 最后一个单词
  word_count += 1 if in_word
  
  word_count
end

def measure_time
  start = Time.now
  result = yield
  elapsed = (Time.now - start) * 1000
  [result, elapsed]
end

def main
  ruby_version = RUBY_VERSION
  puts '=' * 70
  puts "Ruby #{ruby_version} 性能测试"
  puts '=' * 70
  puts
  
  puts format('%-20s %-15s %15s', '测试项目', '结果', '耗时(ms)')
  puts '-' * 70
  
  total_start = Time.now
  
  tests = [
    ['斐波那契(递归)', method(:test1_fibonacci_recursive)],
    ['斐波那契(迭代)', method(:test2_fibonacci_iterative)],
    ['质数筛选', method(:test3_prime_sieve)],
    ['快速排序', method(:test4_sorting)],
    ['字符串拼接', method(:test5_string_concat)],
    ['哈希表操作', method(:test6_hash_table)],
    ['文件I/O', method(:test7_file_io)],
    ['内存分配', method(:test8_memory_allocation)],
    ['矩阵乘法', method(:test9_matrix_multiplication)],
    ['字符串处理', method(:test10_string_processing)]
  ]
  
  tests.each do |name, func|
    result, elapsed = measure_time { func.call }
    puts format('%-20s %-15s %15.2f', name, result.to_s, elapsed)
  end
  
  total_elapsed = (Time.now - total_start) * 1000
  
  puts '-' * 70
  puts format('%-20s %-15s %15.2f', '总耗时', '', total_elapsed)
  puts '=' * 70
end

main if __FILE__ == $PROGRAM_NAME
