<?php

// 设置内存限制为1GB（字符串拼接和质数筛选需要较大内存）
ini_set('memory_limit', '1G');

// 测试1：斐波那契数列（递归）
function fib_recursive($n) {
    if ($n <= 1) return $n;
    return fib_recursive($n - 1) + fib_recursive($n - 2);
}

function test1_fibonacci_recursive() {
    return fib_recursive(41);
}

// 测试2：斐波那契数列（迭代）
function test2_fibonacci_iterative() {
    $n = 10000000;
    if ($n <= 1) return $n;
    
    $a = 0;
    $b = 1;
    for ($i = 2; $i <= $n; $i++) {
        $temp = $b;
        $b = ($a + $b) % 1000000007;
        $a = $temp;
    }
    return $b;
}

// 测试3：质数筛选
function test3_prime_sieve() {
    $limit = 20000000;
    
    // 使用SplFixedArray来减少内存占用
    $is_prime = new SplFixedArray($limit + 1);
    for ($i = 0; $i <= $limit; $i++) {
        $is_prime[$i] = true;
    }
    $is_prime[0] = $is_prime[1] = false;
    
    for ($i = 2; $i * $i <= $limit; $i++) {
        if ($is_prime[$i]) {
            for ($j = $i * $i; $j <= $limit; $j += $i) {
                $is_prime[$j] = false;
            }
        }
    }
    
    // 计数
    $count = 0;
    for ($i = 0; $i <= $limit; $i++) {
        if ($is_prime[$i]) {
            $count++;
        }
    }
    
    return $count;
}

// 测试4：快速排序
function test4_sorting() {
    mt_srand(42);
    $arr = array();
    for ($i = 0; $i < 2000000; $i++) {
        $arr[] = mt_rand(0, 1000000);
    }
    sort($arr);
    return $arr[0];
}

// 测试5：字符串拼接
function test5_string_concat() {
    // PHP的数组内存占用太大，改用分块拼接策略
    // 每次拼接1000个字符，共拼接20000次
    $parts = array();
    $chunk = str_repeat('a', 1000);
    
    for ($i = 0; $i < 20000; $i++) {
        $parts[] = $chunk;
    }
    
    $str = implode('', $parts);
    return strlen($str);
}

// 测试6：哈希表操作
function test6_hash_table() {
    $hash_map = array();
    
    // 插入
    for ($i = 0; $i < 1000000; $i++) {
        $hash_map["key_$i"] = $i;
    }
    
    // 查询
    mt_srand(42);
    $found_count = 0;
    for ($i = 0; $i < 1000000; $i++) {
        $key = "key_" . mt_rand(0, 1000000);
        if (isset($hash_map[$key])) {
            $found_count++;
        }
    }
    
    return $found_count;
}

// 测试7：文件I/O
function test7_file_io() {
    $filename = 'test_file_php.txt';
    
    // 写入
    $f = fopen($filename, 'w');
    for ($i = 0; $i < 2000000; $i++) {
        fwrite($f, "Line $i: This is a test line.\n");
    }
    fclose($f);
    
    // 读取
    $count = 0;
    $f = fopen($filename, 'r');
    while (fgets($f) !== false) {
        $count++;
    }
    fclose($f);
    
    // 清理
    unlink($filename);
    
    return $count;
}

// 测试8：内存分配与访问
function test8_memory_allocation() {
    $data = array();
    
    // 创建对象
    for ($i = 0; $i < 1000000; $i++) {
        $data[] = array(
            'id' => $i,
            'value' => $i * 2,
            'name' => "item_$i"
        );
    }
    
    // 随机访问
    mt_srand(42);
    $total = 0;
    for ($i = 0; $i < 1000000; $i++) {
        $idx = mt_rand(0, 999999);
        $total += $data[$idx]['value'];
    }
    
    return $total % 1000000;
}

// 测试9：矩阵乘法
function test9_matrix_multiplication() {
    $size = 400;
    
    // 初始化矩阵
    mt_srand(42);
    $A = array();
    $B = array();
    $C = array();
    
    for ($i = 0; $i < $size; $i++) {
        $A[$i] = array();
        $B[$i] = array();
        $C[$i] = array();
        for ($j = 0; $j < $size; $j++) {
            $A[$i][$j] = mt_rand() / mt_getrandmax();
            $B[$i][$j] = mt_rand() / mt_getrandmax();
            $C[$i][$j] = 0.0;
        }
    }
    
    // 矩阵乘法
    for ($i = 0; $i < $size; $i++) {
        for ($j = 0; $j < $size; $j++) {
            for ($k = 0; $k < $size; $k++) {
                $C[$i][$j] += $A[$i][$k] * $B[$k][$j];
            }
        }
    }
    
    return intval($C[0][0] * 1000);
}

// 测试10：字符串处理
function test10_string_processing() {
    // 创建长文本
    $base = "The quick brown fox jumps over the lazy dog. ";
    $text = str_repeat($base, 1500000);
    
    // 查找 "the" (不使用正则表达式)
    $count = substr_count($text, "the");
    
    // 替换 "fox" 为 "cat"
    $text = str_replace("fox", "cat", $text);
    
    // 分割：统计单词数 (不创建数组，直接计数以节省内存)
    $word_count = 0;
    $in_word = false;
    $len = strlen($text);
    
    for ($i = 0; $i < $len; $i++) {
        $char = $text[$i];
        if ($char === ' ' || $char === "\n" || $char === "\t") {
            if ($in_word) {
                $word_count++;
                $in_word = false;
            }
        } else {
            $in_word = true;
        }
    }
    
    // 最后一个单词
    if ($in_word) {
        $word_count++;
    }
    
    return $word_count;
}

function measure_time($name, $fn) {
    $start = microtime(true);
    $result = $fn();
    $elapsed = (microtime(true) - $start) * 1000;
    return array($result, $elapsed);
}

function main() {
    $php_version = phpversion();
    echo str_repeat('=', 70) . "\n";
    echo "PHP $php_version 性能测试\n";
    echo str_repeat('=', 70) . "\n\n";
    
    printf("%-20s %-15s %15s\n", '测试项目', '结果', '耗时(ms)');
    echo str_repeat('-', 70) . "\n";
    
    $total_start = microtime(true);
    
    $tests = array(
        array('斐波那契(递归)', 'test1_fibonacci_recursive'),
        array('斐波那契(迭代)', 'test2_fibonacci_iterative'),
        array('质数筛选', 'test3_prime_sieve'),
        array('快速排序', 'test4_sorting'),
        array('字符串拼接', 'test5_string_concat'),
        array('哈希表操作', 'test6_hash_table'),
        array('文件I/O', 'test7_file_io'),
        array('内存分配', 'test8_memory_allocation'),
        array('矩阵乘法', 'test9_matrix_multiplication'),
        array('字符串处理', 'test10_string_processing')
    );
    
    foreach ($tests as $test) {
        list($name, $func) = $test;
        list($result, $elapsed) = measure_time($name, $func);
        printf("%-20s %-15s %15.2f\n", $name, $result, $elapsed);
    }
    
    $total_elapsed = (microtime(true) - $total_start) * 1000;
    
    echo str_repeat('-', 70) . "\n";
    printf("%-20s %-15s %15.2f\n", '总耗时', '', $total_elapsed);
    echo str_repeat('=', 70) . "\n";
}

main();
?>
