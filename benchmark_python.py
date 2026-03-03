#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
性能测试 - Python版本
包含10个测试项目，测试不同方面的性能
"""

import time
import random
import os
import sys
from typing import List, Dict, Any


def measure_time(func):
    """装饰器：测量函数执行时间（毫秒）"""
    def wrapper(*args, **kwargs):
        start = time.perf_counter()
        result = func(*args, **kwargs)
        end = time.perf_counter()
        elapsed_ms = (end - start) * 1000
        return result, elapsed_ms
    return wrapper


# 测试1：斐波那契数列（递归）
@measure_time
def test1_fibonacci_recursive():
    def fib(n):
        if n <= 1:
            return n
        return fib(n - 1) + fib(n - 2)
    
    result = fib(41)
    return result


# 测试2：斐波那契数列（迭代）
@measure_time
def test2_fibonacci_iterative():
    def fib(n):
        if n <= 1:
            return n
        a, b = 0, 1
        for _ in range(2, n + 1):
            a, b = b, (a + b) % 1000000007  # 取模避免大数
        return b
    
    result = fib(10000000)
    return result


# 测试3：质数筛选（埃拉托斯特尼筛法）
@measure_time
def test3_prime_sieve():
    def sieve_of_eratosthenes(limit):
        if limit < 2:
            return 0
        
        is_prime = [True] * (limit + 1)
        is_prime[0] = is_prime[1] = False
        
        i = 2
        while i * i <= limit:
            if is_prime[i]:
                for j in range(i * i, limit + 1, i):
                    is_prime[j] = False
            i += 1
        
        return sum(is_prime)
    
    result = sieve_of_eratosthenes(20000000)
    return result


# 测试4：快速排序
@measure_time
def test4_sorting():
    random.seed(42)
    arr = [random.randint(0, 1000000) for _ in range(2000000)]
    arr.sort()
    return arr[0]  # 返回第一个元素作为验证


# 测试5：字符串拼接
@measure_time
def test5_string_concat():
    parts = []
    for i in range(20000000):
        parts.append('a')
    result = ''.join(parts)
    return len(result)


# 测试6：哈希表操作
@measure_time
def test6_hash_table():
    hash_map = {}
    
    # 插入
    for i in range(1000000):
        hash_map[f"key_{i}"] = i
    
    # 查询
    random.seed(42)
    found_count = 0
    for _ in range(1000000):
        key = f"key_{random.randint(0, 1000000)}"
        if key in hash_map:
            found_count += 1
    
    return found_count


# 测试7：文件I/O
@measure_time
def test7_file_io():
    filename = "test_file_python.txt"
    
    # 写入
    with open(filename, 'w', encoding='utf-8') as f:
        for i in range(2000000):
            f.write(f"Line {i}: This is a test line.\n")
    
    # 读取
    line_count = 0
    with open(filename, 'r', encoding='utf-8') as f:
        for line in f:
            line_count += 1
    
    # 清理
    os.remove(filename)
    
    return line_count


# 测试8：内存分配与访问
@measure_time
def test8_memory_allocation():
    # 创建大量对象并访问
    data = []
    for i in range(1000000):
        data.append({
            "id": i,
            "value": i * 2,
            "name": f"item_{i}"
        })
    
    # 随机访问
    random.seed(42)
    total = 0
    for _ in range(1000000):
        idx = random.randint(0, 999999)
        total += data[idx]["value"]
    
    return total % 1000000


# 测试9：矩阵乘法
@measure_time
def test9_matrix_multiplication():
    size = 400
    
    # 创建两个矩阵
    random.seed(42)
    A = [[random.random() for _ in range(size)] for _ in range(size)]
    B = [[random.random() for _ in range(size)] for _ in range(size)]
    
    # 矩阵乘法
    C = [[0.0 for _ in range(size)] for _ in range(size)]
    for i in range(size):
        for j in range(size):
            for k in range(size):
                C[i][j] += A[i][k] * B[k][j]
    
    return int(C[0][0] * 1000)  # 返回一个验证值


# 测试10：字符串处理
@measure_time
def test10_string_processing():
    # 创建长文本
    text = "The quick brown fox jumps over the lazy dog. " * 1500000
    
    # 查找
    count = text.count("the")
    
    # 替换
    new_text = text.replace("fox", "cat")
    
    # 分割
    words = new_text.split()
    
    return len(words)


def main():
    python_version = f"{sys.version_info.major}.{sys.version_info.minor}.{sys.version_info.micro}"
    print("=" * 70)
    print(f"Python {python_version} 性能测试")
    print("=" * 70)
    
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
        ("字符串处理", test10_string_processing),
    ]
    
    results = []
    total_start = time.perf_counter()
    
    # 表头
    print(f"\n{'测试项目':<20} {'结果':<15} {'耗时(ms)':<15}")
    print("-" * 70)
    
    for test_name, test_func in tests:
        try:
            result, elapsed_ms = test_func()
            print(f"{test_name:<20} {str(result):<15} {elapsed_ms:>12.2f}")
            
            results.append({
                "test": test_name,
                "result": result,
                "time_ms": round(elapsed_ms, 2)
            })
        except Exception as e:
            print(f"{test_name:<20} {'ERROR':<15} {0:>12.2f}")
            results.append({
                "test": test_name,
                "result": "ERROR",
                "time_ms": 0,
                "error": str(e)
            })
    
    total_end = time.perf_counter()
    total_time = (total_end - total_start) * 1000
    
    print("-" * 70)
    print(f"{'总耗时':<20} {'':<15} {total_time:>12.2f}")
    print("=" * 70)
    
    print("\n测试完成")


if __name__ == "__main__":
    main()
