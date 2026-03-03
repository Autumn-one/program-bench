use std::collections::HashMap;
use std::fs::{File, remove_file};
use std::io::{BufRead, BufReader, BufWriter, Write};
use std::time::Instant;

// 简单的随机数生成器（LCG）
struct SimpleRng {
    state: u64,
}

impl SimpleRng {
    fn new(seed: u64) -> Self {
        SimpleRng { state: seed }
    }
    
    fn next(&mut self) -> u32 {
        self.state = self.state.wrapping_mul(1103515245).wrapping_add(12345);
        (self.state / 65536) as u32
    }
    
    fn gen_range(&mut self, min: i32, max: i32) -> i32 {
        let range = (max - min + 1) as u32;
        min + ((self.next() % range) as i32)
    }
    
    fn gen_f64(&mut self) -> f64 {
        (self.next() as f64) / (u32::MAX as f64)
    }
}

// 测试1：斐波那契数列（递归）
fn fib_recursive(n: i32) -> i64 {
    if n <= 1 {
        return n as i64;
    }
    fib_recursive(n - 1) + fib_recursive(n - 2)
}

fn test1_fibonacci_recursive() -> i64 {
    fib_recursive(41)
}

// 测试2：斐波那契数列（迭代）
fn test2_fibonacci_iterative() -> i64 {
    let n = 10000000;
    if n <= 1 {
        return n as i64;
    }

    let mut a: i64 = 0;
    let mut b: i64 = 1;
    for _ in 2..=n {
        let temp = b;
        b = (a + b) % 1000000007;
        a = temp;
    }
    b
}

// 测试3：质数筛选
fn test3_prime_sieve() -> usize {
    let limit = 20000000;
    let mut is_prime = vec![true; limit + 1];
    is_prime[0] = false;
    is_prime[1] = false;

    let mut i = 2;
    while i * i <= limit {
        if is_prime[i] {
            let mut j = i * i;
            while j <= limit {
                is_prime[j] = false;
                j += i;
            }
        }
        i += 1;
    }

    is_prime.iter().filter(|&&x| x).count()
}

// 测试4：快速排序
fn test4_sorting() -> i32 {
    let mut rng = SimpleRng::new(42);
    let mut arr: Vec<i32> = (0..2000000)
        .map(|_| rng.gen_range(0, 1000000))
        .collect();

    arr.sort();
    arr[0]
}

// 测试5：字符串拼接
fn test5_string_concat() -> usize {
    let mut s = String::with_capacity(20000000);
    for _ in 0..20000000 {
        s.push('a');
    }
    s.len()
}

// 测试6：哈希表操作
fn test6_hash_table() -> usize {
    let mut hash_map = HashMap::new();

    // 插入
    for i in 0..1000000 {
        hash_map.insert(format!("key_{}", i), i);
    }

    // 查询
    let mut rng = SimpleRng::new(42);
    let mut found_count = 0;
    for _ in 0..1000000 {
        let key = format!("key_{}", rng.gen_range(0, 1000000));
        if hash_map.contains_key(&key) {
            found_count += 1;
        }
    }

    found_count
}

// 测试7：文件I/O
fn test7_file_io() -> usize {
    let filename = "test_file_rust.txt";

    // 写入（使用BufWriter提高性能）
    {
        let file = File::create(filename).unwrap();
        let mut writer = BufWriter::new(file);
        for i in 0..2000000 {
            writeln!(writer, "Line {}: This is a test line.", i).unwrap();
        }
        // BufWriter会在drop时自动flush
    }

    // 读取
    let file = File::open(filename).unwrap();
    let reader = BufReader::new(file);
    let count = reader.lines().count();

    // 清理
    remove_file(filename).unwrap();

    count
}

// 测试8：内存分配与访问
#[allow(dead_code)]
struct DataObject {
    id: i32,
    value: i32,
    name: String,
}

fn test8_memory_allocation() -> i32 {
    let mut data = Vec::with_capacity(1000000);
    
    // 创建对象
    for i in 0..1000000 {
        data.push(DataObject {
            id: i,
            value: i * 2,
            name: format!("item_{}", i),
        });
    }
    
    // 随机访问
    let mut rng = SimpleRng::new(42);
    let mut total: i64 = 0;
    for _ in 0..1000000 {
        let idx = (rng.gen_range(0, 999999) as usize).min(999999);
        total += data[idx].value as i64;
    }
    
    (total % 1000000) as i32
}

// 测试9：矩阵乘法
fn test9_matrix_multiplication() -> i32 {
    let size = 400;
    let mut rng = SimpleRng::new(42);

    // 使用一维Vec模拟二维矩阵，提高缓存命中率
    let mut a = vec![0.0; size * size];
    let mut b = vec![0.0; size * size];
    let mut c = vec![0.0; size * size];

    for i in 0..(size * size) {
        a[i] = rng.gen_f64();
        b[i] = rng.gen_f64();
    }

    // 矩阵乘法
    for i in 0..size {
        for j in 0..size {
            let mut sum = 0.0;
            for k in 0..size {
                sum += a[i * size + k] * b[k * size + j];
            }
            c[i * size + j] = sum;
        }
    }

    (c[0] * 1000.0) as i32
}

// 测试10：字符串处理
fn test10_string_processing() -> usize {
    // 创建长文本
    let base = "The quick brown fox jumps over the lazy dog. ";
    let mut text = String::with_capacity(base.len() * 1500000);
    
    for _ in 0..1500000 {
        text.push_str(base);
    }
    
    // 查找 "the" (虽然不返回，但为了与其他语言保持一致的操作)
    let _count = text.matches("the").count();
    
    // 替换 "fox" 为 "cat"
    let text = text.replace("fox", "cat");
    
    // 分割：统计单词数 - 手动计数，避免创建Vec
    let mut word_count = 0;
    let mut in_word = false;
    
    for c in text.chars() {
        if c == ' ' || c == '\n' || c == '\t' {
            if in_word {
                word_count += 1;
                in_word = false;
            }
        } else {
            in_word = true;
        }
    }
    
    // 最后一个单词
    if in_word {
        word_count += 1;
    }
    
    word_count
}

fn main() {
    println!("======================================================================");
    println!("Rust 性能测试");
    println!("======================================================================");
    println!();

    println!("{:<20} {:<15} {:>15}", "测试项目", "结果", "耗时(ms)");
    println!("----------------------------------------------------------------------");

    let total_start = Instant::now();

    // 测试1
    let start = Instant::now();
    let result1 = test1_fibonacci_recursive();
    let elapsed1 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "斐波那契(递归)", result1, elapsed1);

    // 测试2
    let start = Instant::now();
    let result2 = test2_fibonacci_iterative();
    let elapsed2 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "斐波那契(迭代)", result2, elapsed2);

    // 测试3
    let start = Instant::now();
    let result3 = test3_prime_sieve();
    let elapsed3 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "质数筛选", result3, elapsed3);

    // 测试4
    let start = Instant::now();
    let result4 = test4_sorting();
    let elapsed4 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "快速排序", result4, elapsed4);

    // 测试5
    let start = Instant::now();
    let result5 = test5_string_concat();
    let elapsed5 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "字符串拼接", result5, elapsed5);

    // 测试6
    let start = Instant::now();
    let result6 = test6_hash_table();
    let elapsed6 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "哈希表操作", result6, elapsed6);

    // 测试7
    let start = Instant::now();
    let result7 = test7_file_io();
    let elapsed7 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "文件I/O", result7, elapsed7);

    // 测试8
    let start = Instant::now();
    let result8 = test8_memory_allocation();
    let elapsed8 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "内存分配", result8, elapsed8);

    // 测试9
    let start = Instant::now();
    let result9 = test9_matrix_multiplication();
    let elapsed9 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "矩阵乘法", result9, elapsed9);

    // 测试10
    let start = Instant::now();
    let result10 = test10_string_processing();
    let elapsed10 = start.elapsed().as_secs_f64() * 1000.0;
    println!("{:<20} {:<15} {:>15.2}", "字符串处理", result10, elapsed10);

    let total_elapsed = total_start.elapsed().as_secs_f64() * 1000.0;

    println!("----------------------------------------------------------------------");
    println!("{:<20} {:<15} {:>15.2}", "总耗时", "", total_elapsed);
    println!("======================================================================");
}
