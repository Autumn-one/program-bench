#!/usr/bin/env julia

using Random

# 测试1：斐波那契数列（递归）
function fib_recursive(n::Int)::Int64
    if n <= 1
        return n
    end
    return fib_recursive(n - 1) + fib_recursive(n - 2)
end

function test1_fibonacci_recursive()::Int64
    return fib_recursive(41)
end

# 测试2：斐波那契数列（迭代）
function test2_fibonacci_iterative()::Int64
    n = 10000000
    if n <= 1
        return n
    end
    
    a, b = 0, 1
    for i in 2:n
        a, b = b, (a + b) % 1000000007
    end
    return b
end

# 测试3：质数筛选
function test3_prime_sieve()::Int
    limit = 20000000
    is_prime = trues(limit + 1)
    is_prime[1] = is_prime[2] = false
    
    i = 2
    while i * i <= limit
        if is_prime[i]
            for j in (i*i):i:limit
                is_prime[j] = false
            end
        end
        i += 1
    end
    
    return count(is_prime)
end

# 测试4：快速排序
function test4_sorting()::Int
    Random.seed!(42)
    arr = rand(0:1000000, 2000000)
    sort!(arr)
    return arr[1]
end

# 测试5：字符串拼接
function test5_string_concat()::Int
    str = "a" ^ 20000000
    return length(str)
end

# 测试6：哈希表操作
function test6_hash_table()::Int
    hash_map = Dict{String, Int}()
    
    # 插入
    for i in 0:999999
        hash_map["key_$i"] = i
    end
    
    # 查询
    Random.seed!(42)
    found_count = 0
    for i in 1:1000000
        key = "key_$(rand(0:1000000))"
        if haskey(hash_map, key)
            found_count += 1
        end
    end
    
    return found_count
end

# 测试7：文件I/O
function test7_file_io()::Int
    filename = "test_file_julia.txt"
    
    # 写入
    open(filename, "w") do f
        for i in 0:1999999
            println(f, "Line $i: This is a test line.")
        end
    end
    
    # 读取
    count = 0
    open(filename, "r") do f
        for line in eachline(f)
            count += 1
        end
    end
    
    # 清理
    rm(filename)
    
    return count
end

# 测试8：内存分配与访问
mutable struct DataObject
    id::Int
    value::Int
    name::String
end

function test8_memory_allocation()::Int
    data = []
    
    # 创建对象
    for i in 0:999999
        push!(data, DataObject(i, i * 2, "item_$i"))
    end
    
    # 随机访问
    Random.seed!(42)
    total = 0
    for i in 1:1000000
        idx = rand(1:1000000)
        total += data[idx].value
    end
    
    return total % 1000000
end

# 测试9：矩阵乘法
function test9_matrix_multiplication()::Int
    size = 400
    
    # 初始化矩阵
    Random.seed!(42)
    A = rand(Float64, size, size)
    B = rand(Float64, size, size)
    
    # 矩阵乘法
    C = A * B
    
    return Int(floor(C[1, 1] * 1000))
end

# 测试10：字符串处理
function test10_string_processing()::Int
    # 创建长文本
    base = "The quick brown fox jumps over the lazy dog. "
    text = base ^ 1500000
    
    # 查找 "the"
    count = length(collect(eachmatch(r"the", text)))
    
    # 替换 "fox" 为 "cat"
    text = replace(text, "fox" => "cat")
    
    # 分割：统计单词数
    words = split(text)
    
    return length(words)
end

function measure_time(name::String, fn::Function)
    start = time()
    result = fn()
    elapsed = (time() - start) * 1000
    return result, elapsed
end

function main()
    julia_version = string(VERSION)
    println("=" ^ 70)
    println("Julia $julia_version 性能测试")
    println("=" ^ 70)
    println()
    
    @printf("%-20s %-15s %15s\n", "测试项目", "结果", "耗时(ms)")
    println("-" ^ 70)
    
    total_start = time()
    
    tests = [
        ("斐波那契(递归)", test1_fibonacci_recursive),
        ("斐波那契(迭代)", test2_fibonacci_iterative),
        ("质数筛选", test3_prime_sieve),
        ("快速排序", test4_sorting),
        ("字符串拼接", test5_string_concat),
        ("哈希表操作", test6_hash_table),
        ("文件I/O", test7_file_io),
        ("内存分配", test8_memory_allocation),
        ("矩阵乘法", test9_matrix_multiplication),
        ("字符串处理", test10_string_processing)
    ]
    
    for (name, func) in tests
        result, elapsed = measure_time(name, func)
        @printf("%-20s %-15s %15.2f\n", name, string(result), elapsed)
    end
    
    total_elapsed = (time() - total_start) * 1000
    
    println("-" ^ 70)
    @printf("%-20s %-15s %15.2f\n", "总耗时", "", total_elapsed)
    println("=" ^ 70)
end

main()
