# Fibonacci Benchmark (n=41)

专门测试各编程语言计算斐波那契数列(递归)的性能。

## 测试说明

- 测试函数：递归计算 fib(41)
- 结果输出：直接打印到控制台

## 编译和运行

### C
```bash
gcc -O3 fib_c.c -o fib_c
./fib_c
```

### C++
```bash
g++ -O3 fib_cpp.cpp -o fib_cpp
./fib_cpp
```

### Rust
```bash
rustc -O fib_rust.rs
./fib_rust
```

### Go
```bash
go run fib_go.go
```

### Java
```bash
javac fib_java.java
java fib_java
```

### C#
```bash
csc fib_csharp.cs
./fib_csharp.exe
```

### Python
```bash
python fib_python.py
```

### JavaScript (Node.js)
```bash
node fib_javascript.js
```

### Ruby
```bash
ruby fib_ruby.rb
```

### PHP
```bash
php fib_php.php
```

### Lua
```bash
lua fib_lua.lua
```

### Julia
```bash
julia fib_julia.jl
```

### Nim
```bash
nim c -d:release fib_nim.nim
./fib_nim
```

## 输出格式

每个程序输出：
```
Result: 165580141
Time: XXX.XX ms
```
