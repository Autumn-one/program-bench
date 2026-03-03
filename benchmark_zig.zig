const std = @import("std");
const time = std.time;
const fs = std.fs;
const mem = std.mem;

// 测试1：斐波那契数列（递归）
fn fibRecursive(n: i32) i64 {
    if (n <= 1) return @intCast(n);
    return fibRecursive(n - 1) + fibRecursive(n - 2);
}

fn test1FibonacciRecursive() i64 {
    return fibRecursive(41);
}

// 测试2：斐波那契数列（迭代）
fn test2FibonacciIterative() i64 {
    const n: i32 = 10000000;
    if (n <= 1) return @intCast(n);
    
    var a: i64 = 0;
    var b: i64 = 1;
    var i: i32 = 2;
    while (i <= n) : (i += 1) {
        const temp = b;
        b = @mod((a + b), 1000000007);
        a = temp;
    }
    return b;
}

// 测试3：质数筛选
fn test3PrimeSieve(allocator: mem.Allocator) !usize {
    const limit: usize = 20000000;
    var is_prime = try allocator.alloc(bool, limit + 1);
    defer allocator.free(is_prime);
    
    @memset(is_prime, true);
    is_prime[0] = false;
    is_prime[1] = false;
    
    var i: usize = 2;
    while (i * i <= limit) : (i += 1) {
        if (is_prime[i]) {
            var j: usize = i * i;
            while (j <= limit) : (j += i) {
                is_prime[j] = false;
            }
        }
    }
    
    var count: usize = 0;
    for (is_prime) |prime| {
        if (prime) count += 1;
    }
    
    return count;
}

// 测试4：快速排序
fn test4Sorting(allocator: mem.Allocator) !i32 {
    var prng = std.rand.DefaultPrng.init(42);
    const random = prng.random();
    
    var arr = try allocator.alloc(i32, 2000000);
    defer allocator.free(arr);
    
    for (arr) |*item| {
        item.* = @intCast(random.intRangeAtMost(i32, 0, 1000000));
    }
    
    std.mem.sort(i32, arr, {}, comptime std.sort.asc(i32));
    return arr[0];
}

// 测试5：字符串拼接
fn test5StringConcat(allocator: mem.Allocator) !usize {
    var str = try allocator.alloc(u8, 20000000);
    defer allocator.free(str);
    
    for (str) |*c| {
        c.* = 'a';
    }
    
    return str.len;
}

// 测试6：哈希表操作
fn test6HashTable(allocator: mem.Allocator) !usize {
    var hash_map = std.StringHashMap(i32).init(allocator);
    defer hash_map.deinit();
    
    // 插入
    var i: i32 = 0;
    while (i < 1000000) : (i += 1) {
        const key = try std.fmt.allocPrint(allocator, "key_{d}", .{i});
        defer allocator.free(key);
        try hash_map.put(key, i);
    }
    
    // 查询
    var prng = std.rand.DefaultPrng.init(42);
    const random = prng.random();
    var found_count: usize = 0;
    
    i = 0;
    while (i < 1000000) : (i += 1) {
        const rand_num = random.intRangeAtMost(i32, 0, 1000000);
        const key = try std.fmt.allocPrint(allocator, "key_{d}", .{rand_num});
        defer allocator.free(key);
        
        if (hash_map.contains(key)) {
            found_count += 1;
        }
    }
    
    return found_count;
}

// 测试7：文件I/O
fn test7FileIO(allocator: mem.Allocator) !usize {
    const filename = "test_file_zig.txt";
    
    // 写入
    {
        const file = try fs.cwd().createFile(filename, .{});
        defer file.close();
        
        var i: i32 = 0;
        while (i < 2000000) : (i += 1) {
            const line = try std.fmt.allocPrint(allocator, "Line {d}: This is a test line.\n", .{i});
            defer allocator.free(line);
            _ = try file.write(line);
        }
    }
    
    // 读取
    var count: usize = 0;
    {
        const file = try fs.cwd().openFile(filename, .{});
        defer file.close();
        
        var buf_reader = std.io.bufferedReader(file.reader());
        var in_stream = buf_reader.reader();
        
        var buf: [1024]u8 = undefined;
        while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |_| {
            count += 1;
        }
    }
    
    // 清理
    try fs.cwd().deleteFile(filename);
    
    return count;
}

// 测试8：内存分配与访问（简化版）
fn test8MemoryAllocation(allocator: mem.Allocator) !usize {
    const DataObject = struct {
        id: i32,
        value: i32,
        name: []const u8,
    };
    
    var data = try allocator.alloc(DataObject, 1000000);
    defer allocator.free(data);
    
    // 创建对象（简化：不分配name字符串）
    for (data, 0..) |*item, i| {
        item.id = @intCast(i);
        item.value = @intCast(i * 2);
        item.name = "item";
    }
    
    // 随机访问
    var prng = std.rand.DefaultPrng.init(42);
    const random = prng.random();
    var total: i64 = 0;
    
    var i: usize = 0;
    while (i < 1000000) : (i += 1) {
        const idx = random.intRangeAtMost(usize, 0, 999999);
        total += data[idx].value;
    }
    
    return @intCast(@mod(total, 1000000));
}

// 测试9：矩阵乘法
fn test9MatrixMultiplication(allocator: mem.Allocator) !i32 {
    const size: usize = 400;
    
    var prng = std.rand.DefaultPrng.init(42);
    const random = prng.random();
    
    // 分配矩阵
    var a = try allocator.alloc([]f64, size);
    var b = try allocator.alloc([]f64, size);
    var c = try allocator.alloc([]f64, size);
    defer {
        for (a) |row| allocator.free(row);
        for (b) |row| allocator.free(row);
        for (c) |row| allocator.free(row);
        allocator.free(a);
        allocator.free(b);
        allocator.free(c);
    }
    
    for (a, 0..) |*row, i| {
        row.* = try allocator.alloc(f64, size);
        b[i] = try allocator.alloc(f64, size);
        c[i] = try allocator.alloc(f64, size);
        
        for (row.*, 0..) |*val, j| {
            val.* = random.float(f64);
            b[i][j] = random.float(f64);
            c[i][j] = 0.0;
        }
    }
    
    // 矩阵乘法
    for (0..size) |i| {
        for (0..size) |j| {
            for (0..size) |k| {
                c[i][j] += a[i][k] * b[k][j];
            }
        }
    }
    
    return @intFromFloat(c[0][0] * 1000.0);
}

// 测试10：字符串处理
fn test10StringProcessing(allocator: mem.Allocator) !usize {
    const base = "The quick brown fox jumps over the lazy dog. ";
    
    // 创建长文本
    var text = try allocator.alloc(u8, base.len * 1500000);
    defer allocator.free(text);
    
    for (0..1500000) |i| {
        const start = i * base.len;
        @memcpy(text[start..start + base.len], base);
    }
    
    // 查找 "the"
    var count: usize = 0;
    var pos: usize = 0;
    while (pos < text.len - 2) {
        if (mem.eql(u8, text[pos..pos+3], "the")) {
            count += 1;
        }
        pos += 1;
    }
    
    // 分割：统计单词数（简化：统计空格数+1）
    var word_count: usize = 1;
    for (text) |c| {
        if (c == ' ') word_count += 1;
    }
    
    return word_count;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    
    const stdout = std.io.getStdOut().writer();
    
    try stdout.print("======================================================================\n", .{});
    try stdout.print("Zig 性能测试\n", .{});
    try stdout.print("======================================================================\n\n", .{});
    
    try stdout.print("{s:<20} {s:<15} {s:>15}\n", .{"测试项目", "结果", "耗时(ms)"});
    try stdout.print("----------------------------------------------------------------------\n", .{});
    
    const total_start = time.nanoTimestamp();
    
    // 测试1
    var start = time.nanoTimestamp();
    const result1 = test1FibonacciRecursive();
    var elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"斐波那契(递归)", result1, elapsed});
    
    // 测试2
    start = time.nanoTimestamp();
    const result2 = test2FibonacciIterative();
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"斐波那契(迭代)", result2, elapsed});
    
    // 测试3
    start = time.nanoTimestamp();
    const result3 = try test3PrimeSieve(allocator);
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"质数筛选", result3, elapsed});
    
    // 测试4
    start = time.nanoTimestamp();
    const result4 = try test4Sorting(allocator);
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"快速排序", result4, elapsed});
    
    // 测试5
    start = time.nanoTimestamp();
    const result5 = try test5StringConcat(allocator);
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"字符串拼接", result5, elapsed});
    
    // 测试6
    start = time.nanoTimestamp();
    const result6 = try test6HashTable(allocator);
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"哈希表操作", result6, elapsed});
    
    // 测试7
    start = time.nanoTimestamp();
    const result7 = try test7FileIO(allocator);
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"文件I/O", result7, elapsed});
    
    // 测试8
    start = time.nanoTimestamp();
    const result8 = try test8MemoryAllocation(allocator);
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"内存分配", result8, elapsed});
    
    // 测试9
    start = time.nanoTimestamp();
    const result9 = try test9MatrixMultiplication(allocator);
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"矩阵乘法", result9, elapsed});
    
    // 测试10
    start = time.nanoTimestamp();
    const result10 = try test10StringProcessing(allocator);
    elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - start)) / 1_000_000.0;
    try stdout.print("{s:<20} {d:<15} {d:>15.2}\n", .{"字符串处理", result10, elapsed});
    
    const total_elapsed = @as(f64, @floatFromInt(time.nanoTimestamp() - total_start)) / 1_000_000.0;
    
    try stdout.print("----------------------------------------------------------------------\n", .{});
    try stdout.print("{s:<20} {s:<15} {d:>15.2}\n", .{"总耗时", "", total_elapsed});
    try stdout.print("======================================================================\n", .{});
}
