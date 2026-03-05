const std = @import("std");
const time = std.time;

fn fib(n: i32) i64 {
    if (n <= 1) return @intCast(n);
    return fib(n - 1) + fib(n - 2);
}

pub fn main() !void {
    const stdout_file = std.io.getStdOut();
    const stdout = stdout_file.writer();
    
    const start = time.nanoTimestamp();
    const result = fib(41);
    const end = time.nanoTimestamp();
    const elapsed_ms = @as(f64, @floatFromInt(end - start)) / 1_000_000.0;
    
    try stdout.print("Result: {d}\n", .{result});
    try stdout.print("Zig: {d:.2} ms\n", .{elapsed_ms});
}
