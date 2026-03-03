const fs = require('fs');
const { performance } = require('perf_hooks');

// 测试1：斐波那契数列（递归）
function fibRecursive(n) {
    if (n <= 1) return n;
    return fibRecursive(n - 1) + fibRecursive(n - 2);
}

function test1FibonacciRecursive() {
    return fibRecursive(41);
}

// 测试2：斐波那契数列（迭代）
function test2FibonacciIterative() {
    const n = 10000000;
    if (n <= 1) return n;
    
    let a = 0, b = 1;
    for (let i = 2; i <= n; i++) {
        [a, b] = [b, (a + b) % 1000000007];
    }
    return b;
}

// 测试3：质数筛选
function test3PrimeSieve() {
    const limit = 20000000;
    const isPrime = new Array(limit + 1).fill(true);
    isPrime[0] = isPrime[1] = false;
    
    for (let i = 2; i * i <= limit; i++) {
        if (isPrime[i]) {
            for (let j = i * i; j <= limit; j += i) {
                isPrime[j] = false;
            }
        }
    }
    
    return isPrime.filter(x => x).length;
}

// 测试4：快速排序
function test4Sorting() {
    // 使用固定种子的随机数生成器
    class SeededRandom {
        constructor(seed) {
            this.seed = seed;
        }
        next() {
            this.seed = (this.seed * 9301 + 49297) % 233280;
            return this.seed / 233280;
        }
    }
    
    const rng = new SeededRandom(42);
    const arr = Array.from({length: 2000000}, () => Math.floor(rng.next() * 1000001));
    
    arr.sort((a, b) => a - b);
    return arr[0];
}

// 测试5：字符串拼接
function test5StringConcat() {
    const parts = [];
    for (let i = 0; i < 20000000; i++) {
        parts.push('a');
    }
    const result = parts.join('');
    return result.length;
}

// 测试6：哈希表操作
function test6HashTable() {
    const hashMap = new Map();
    
    // 插入
    for (let i = 0; i < 1000000; i++) {
        hashMap.set(`key_${i}`, i);
    }
    
    // 查询
    class SeededRandom {
        constructor(seed) {
            this.seed = seed;
        }
        next() {
            this.seed = (this.seed * 9301 + 49297) % 233280;
            return this.seed / 233280;
        }
    }
    
    const rng = new SeededRandom(42);
    let foundCount = 0;
    for (let i = 0; i < 1000000; i++) {
        const key = `key_${Math.floor(rng.next() * 1000001)}`;
        if (hashMap.has(key)) {
            foundCount++;
        }
    }
    
    return foundCount;
}

// 测试7：文件I/O
function test7FileIO() {
    const filename = 'test_file_javascript.txt';
    
    // 写入
    const lines = [];
    for (let i = 0; i < 2000000; i++) {
        lines.push(`Line ${i}: This is a test line.`);
    }
    fs.writeFileSync(filename, lines.join('\n') + '\n');
    
    // 读取
    const content = fs.readFileSync(filename, 'utf-8');
    const lineCount = content.split('\n').filter(line => line.length > 0).length;
    
    // 清理
    fs.unlinkSync(filename);
    
    return lineCount;
}

// 测试8：内存分配与访问
function test8MemoryAllocation() {
    const data = [];
    
    // 创建对象
    for (let i = 0; i < 1000000; i++) {
        data.push({
            id: i,
            value: i * 2,
            name: `item_${i}`
        });
    }
    
    // 随机访问
    class SeededRandom {
        constructor(seed) {
            this.seed = seed;
        }
        next() {
            this.seed = (this.seed * 9301 + 49297) % 233280;
            return this.seed / 233280;
        }
    }
    
    const rng = new SeededRandom(42);
    let total = 0;
    for (let i = 0; i < 1000000; i++) {
        const idx = Math.floor(rng.next() * 1000000);
        total += data[idx].value;
    }
    
    return total % 1000000;
}

// 测试9：矩阵乘法
function test9MatrixMultiplication() {
    const size = 400;
    
    // 初始化矩阵
    class SeededRandom {
        constructor(seed) {
            this.seed = seed;
        }
        next() {
            this.seed = (this.seed * 9301 + 49297) % 233280;
            return this.seed / 233280;
        }
    }
    
    const rng = new SeededRandom(42);
    const A = Array.from({length: size}, () => Array.from({length: size}, () => rng.next()));
    const B = Array.from({length: size}, () => Array.from({length: size}, () => rng.next()));
    const C = Array.from({length: size}, () => Array(size).fill(0));
    
    // 矩阵乘法
    for (let i = 0; i < size; i++) {
        for (let j = 0; j < size; j++) {
            for (let k = 0; k < size; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
    
    return Math.floor(C[0][0] * 1000);
}

// 测试10：字符串处理
function test10StringProcessing() {
    // 创建长文本
    const base = "The quick brown fox jumps over the lazy dog. ";
    let text = base.repeat(1500000);
    
    // 查找 "the" (使用字符串方法，不使用正则)
    let count = 0;
    let pos = 0;
    while ((pos = text.indexOf("the", pos)) !== -1) {
        count++;
        pos += 3;
    }
    
    // 替换 "fox" 为 "cat" (使用字符串方法)
    text = text.split("fox").join("cat");
    
    // 分割：统计单词数
    const words = text.split(" ").filter(w => w.length > 0);
    
    return words.length;
}

function measureTime(name, fn) {
    const start = performance.now();
    const result = fn();
    const elapsed = performance.now() - start;
    return [result, elapsed];
}

function main() {
    const version = process.version;
    console.log('======================================================================');
    console.log(`Node.js ${version} 性能测试`);
    console.log('======================================================================');
    console.log();
    
    console.log(`${'测试项目'.padEnd(20)} ${'结果'.padEnd(15)} ${'耗时(ms)'.padStart(15)}`);
    console.log('----------------------------------------------------------------------');
    
    const totalStart = performance.now();
    
    const tests = [
        ['斐波那契(递归)', test1FibonacciRecursive],
        ['斐波那契(迭代)', test2FibonacciIterative],
        ['质数筛选', test3PrimeSieve],
        ['快速排序', test4Sorting],
        ['字符串拼接', test5StringConcat],
        ['哈希表操作', test6HashTable],
        ['文件I/O', test7FileIO],
        ['内存分配', test8MemoryAllocation],
        ['矩阵乘法', test9MatrixMultiplication],
        ['字符串处理', test10StringProcessing]
    ];
    
    for (const [name, fn] of tests) {
        const [result, elapsed] = measureTime(name, fn);
        console.log(`${name.padEnd(20)} ${String(result).padEnd(15)} ${elapsed.toFixed(2).padStart(15)}`);
    }
    
    const totalElapsed = performance.now() - totalStart;
    
    console.log('----------------------------------------------------------------------');
    console.log(`${'总耗时'.padEnd(20)} ${''.padEnd(15)} ${totalElapsed.toFixed(2).padStart(15)}`);
    console.log('======================================================================');
}

main();
