#!/usr/bin/env lua

-- 测试1：斐波那契数列（递归）
function fib_recursive(n)
    if n <= 1 then return n end
    return fib_recursive(n - 1) + fib_recursive(n - 2)
end

function test1_fibonacci_recursive()
    return fib_recursive(41)
end

-- 测试2：斐波那契数列（迭代）
function test2_fibonacci_iterative()
    local n = 10000000
    if n <= 1 then return n end
    
    local a, b = 0, 1
    for i = 2, n do
        a, b = b, (a + b) % 1000000007
    end
    return b
end

-- 测试3：质数筛选
function test3_prime_sieve()
    local limit = 20000000
    local is_prime = {}
    
    for i = 0, limit do
        is_prime[i] = true
    end
    is_prime[0] = false
    is_prime[1] = false
    
    local i = 2
    while i * i <= limit do
        if is_prime[i] then
            local j = i * i
            while j <= limit do
                is_prime[j] = false
                j = j + i
            end
        end
        i = i + 1
    end
    
    local count = 0
    for i = 0, limit do
        if is_prime[i] then
            count = count + 1
        end
    end
    
    return count
end

-- 测试4：快速排序
function test4_sorting()
    math.randomseed(42)
    local arr = {}
    for i = 1, 2000000 do
        arr[i] = math.random(0, 1000000)
    end
    
    table.sort(arr)
    return arr[1]
end

-- 测试5：字符串拼接
function test5_string_concat()
    local parts = {}
    for i = 1, 20000000 do
        parts[i] = 'a'
    end
    local result = table.concat(parts)
    return #result
end

-- 测试6：哈希表操作
function test6_hash_table()
    local hash_map = {}
    
    -- 插入
    for i = 0, 999999 do
        hash_map["key_" .. i] = i
    end
    
    -- 查询
    math.randomseed(42)
    local found_count = 0
    for i = 1, 1000000 do
        local key = "key_" .. math.random(0, 1000000)
        if hash_map[key] ~= nil then
            found_count = found_count + 1
        end
    end
    
    return found_count
end

-- 测试7：文件I/O
function test7_file_io()
    local filename = "test_file_lua.txt"
    
    -- 写入
    local f = io.open(filename, "w")
    for i = 0, 1999999 do
        f:write(string.format("Line %d: This is a test line.\n", i))
    end
    f:close()
    
    -- 读取
    local count = 0
    f = io.open(filename, "r")
    for line in f:lines() do
        count = count + 1
    end
    f:close()
    
    -- 清理
    os.remove(filename)
    
    return count
end

-- 测试8：内存分配与访问
function test8_memory_allocation()
    local data = {}
    
    -- 创建对象
    for i = 0, 999999 do
        data[i + 1] = {
            id = i,
            value = i * 2,
            name = "item_" .. i
        }
    end
    
    -- 随机访问
    math.randomseed(42)
    local total = 0
    for i = 1, 1000000 do
        local idx = math.random(1, 1000000)
        total = total + data[idx].value
    end
    
    return total % 1000000
end

-- 测试9：矩阵乘法
function test9_matrix_multiplication()
    local size = 400
    
    -- 初始化矩阵
    math.randomseed(42)
    local A = {}
    local B = {}
    local C = {}
    
    for i = 1, size do
        A[i] = {}
        B[i] = {}
        C[i] = {}
        for j = 1, size do
            A[i][j] = math.random()
            B[i][j] = math.random()
            C[i][j] = 0.0
        end
    end
    
    -- 矩阵乘法
    for i = 1, size do
        for j = 1, size do
            for k = 1, size do
                C[i][j] = C[i][j] + A[i][k] * B[k][j]
            end
        end
    end
    
    return math.floor(C[1][1] * 1000)
end

-- 测试10：字符串处理
function test10_string_processing()
    -- 创建长文本
    local base = "The quick brown fox jumps over the lazy dog. "
    local text = string.rep(base, 1500000)
    
    -- 查找 "the" (不使用模式匹配)
    local count = 0
    local start = 1
    while true do
        local pos = string.find(text, "the", start, true)
        if not pos then break end
        count = count + 1
        start = pos + 3  -- 跳过已找到的 "the"
    end
    
    -- 替换 "fox" 为 "cat"
    text = string.gsub(text, "fox", "cat")
    
    -- 分割：统计单词数 (不使用模式匹配，直接计数)
    local word_count = 0
    local in_word = false
    
    for i = 1, #text do
        local char = string.sub(text, i, i)
        if char == ' ' or char == '\n' or char == '\t' then
            if in_word then
                word_count = word_count + 1
                in_word = false
            end
        else
            in_word = true
        end
    end
    
    -- 最后一个单词
    if in_word then
        word_count = word_count + 1
    end
    
    return word_count
end

function measure_time(name, fn)
    local start = os.clock()
    local result = fn()
    local elapsed = (os.clock() - start) * 1000
    return result, elapsed
end

function main()
    local lua_version = _VERSION
    print(string.rep("=", 70))
    print(lua_version .. " 性能测试")
    print(string.rep("=", 70))
    print()
    
    print(string.format("%-20s %-15s %15s", "测试项目", "结果", "耗时(ms)"))
    print(string.rep("-", 70))
    
    local total_start = os.clock()
    
    local tests = {
        {"斐波那契(递归)", test1_fibonacci_recursive},
        {"斐波那契(迭代)", test2_fibonacci_iterative},
        {"质数筛选", test3_prime_sieve},
        {"快速排序", test4_sorting},
        {"字符串拼接", test5_string_concat},
        {"哈希表操作", test6_hash_table},
        {"文件I/O", test7_file_io},
        {"内存分配", test8_memory_allocation},
        {"矩阵乘法", test9_matrix_multiplication},
        {"字符串处理", test10_string_processing}
    }
    
    for _, test in ipairs(tests) do
        local name, func = test[1], test[2]
        local result, elapsed = measure_time(name, func)
        print(string.format("%-20s %-15s %15.2f", name, tostring(result), elapsed))
    end
    
    local total_elapsed = (os.clock() - total_start) * 1000
    
    print(string.rep("-", 70))
    print(string.format("%-20s %-15s %15.2f", "总耗时", "", total_elapsed))
    print(string.rep("=", 70))
end

main()
