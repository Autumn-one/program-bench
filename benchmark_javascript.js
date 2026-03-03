// 运行时检测和兼容性处理
const isNode = typeof process !== 'undefined' && process.versions && process.versions.node;
const isDeno = typeof Deno !== 'undefined';
const isBun = typeof Bun !== 'undefined';

// 文件系统API适配
let fs, performance;
if (isDeno) {
    // Deno使用原生API
    fs = {
        writeFileSync: (path, data) => Deno.writeTextFileSync(path, data),
        readFileSync: (path) => Deno.readTextFileSync(path),
        unlinkSync: (path) => Deno.removeSync(path)
    };
    performance = globalThis.performance;
} else {
    // Node.js和Bun使用CommonJS
    fs = require('fs');
    performance = require('perf_hooks').performance;
}

// 获取运行时版本信息
function getRuntimeInfo() {
    if (isDeno) {
        return `Deno ${Deno.version.deno}`;
    } else if (isBun) {
        return `Bun ${Bun.version}`;
    } else if (isNode) {
        return `Node.js ${process.version}`;
    }
    return 'Unknown Runtime';
}

// 简单的随机数生成器（LCG）- 全局定义，避免重复
class SeededRandom {
    constructor(seed) {
        this.seed = seed;
    }
    next() {
        this.seed = (this.seed * 9301 + 49297) % 233280;
        return this.seed / 233280;
    }
}

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
    
    // 手动计数，避免filter创建新数组
    let count = 0;
    for (let i = 0; i <= limit; i++) {
        if (isPrime[i]) count++;
    }
    return count;
}

// 测试4：快速排序
function test4Sorting() {
    const rng = new SeededRandom(42);
    const arr = Array.from({length: 2000000}, () => Math.floor(rng.next() * 1000001));
    
    arr.sort((a, b) => a - b);
    return arr[0];
}

// 测试5：字符串拼接
function test5StringConcat() {
    // 使用repeat更高效
    const result = 'a'.repeat(20000000);
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
    const rng = new SeededRandom(42);
    let foundCount = 0;
    for (let i = 0; i < 1000000; i++) {
        const keyNum = Math.floor(rng.next() * 1000001);
        const key = `key_${keyNum}`;
        if (hashMap.has(key)) {
            foundCount++;
        }
    }
    
    return foundCount;
}

// 测试7：文件I/O
function test7FileIO() {
    const filename = 'test_file_javascript.txt';
    
    // 写入 - 批量构建字符串
    const chunks = [];
    const chunkSize = 10000;
    for (let i = 0; i < 2000000; i += chunkSize) {
        const lines = [];
        const end = Math.min(i + chunkSize, 2000000);
        for (let j = i; j < end; j++) {
            lines.push(`Line ${j}: This is a test line.`);
        }
        chunks.push(lines.join('\n'));
    }
    fs.writeFileSync(filename, chunks.join('\n') + '\n');
    
    // 读取
    const fileContent = fs.readFileSync(filename, 'utf-8');
    const lineCount = fileContent.split('\n').filter(line => line.length > 0).length;
    
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
    
    // 使用一维数组模拟二维矩阵，提高缓存命中率
    const rng = new SeededRandom(42);
    const A = new Array(size * size);
    const B = new Array(size * size);
    const C = new Array(size * size).fill(0);
    
    // 初始化矩阵
    for (let i = 0; i < size * size; i++) {
        A[i] = rng.next();
        B[i] = rng.next();
    }
    
    // 矩阵乘法 - 使用一维数组索引
    for (let i = 0; i < size; i++) {
        for (let j = 0; j < size; j++) {
            let sum = 0;
            for (let k = 0; k < size; k++) {
                sum += A[i * size + k] * B[k * size + j];
            }
            C[i * size + j] = sum;
        }
    }
    
    return Math.floor(C[0] * 1000);
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
    
    // 分割：统计单词数 - 手动计数，避免创建巨大数组
    let wordCount = 0;
    let inWord = false;
    
    for (let i = 0; i < text.length; i++) {
        const c = text[i];
        if (c === ' ' || c === '\n' || c === '\t') {
            if (inWord) {
                wordCount++;
                inWord = false;
            }
        } else {
            inWord = true;
        }
    }
    
    // 最后一个单词
    if (inWord) {
        wordCount++;
    }
    
    return wordCount;
}

function measureTime(name, fn) {
    const start = performance.now();
    const result = fn();
    const elapsed = performance.now() - start;
    return [result, elapsed];
}

function main() {
    const version = getRuntimeInfo();
    console.log('======================================================================');
    console.log(`${version} 性能测试`);
    console.log('======================================================================');
    console.log();
    
    // JIT预热：让引擎优化关键代码路径
    if (isNode || isBun) {
        process.stdout.write('JIT预热中...');
    } else {
        Deno.stdout.writeSync(new TextEncoder().encode('JIT预热中...'));
    }
    for (let i = 0; i < 5; i++) {
        fibRecursive(20);
        test2FibonacciIterative();
        test3PrimeSieve();
    }
    console.log(' 完成');
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
