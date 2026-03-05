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

### Zig
```bash
zig build-exe fib_zig.zig -O ReleaseFast
./fib_zig
```

### V
```bash
v -prod fib_v.v
./fib_v
```

### D
```bash
dmd -O -release -of=fib_d fib_d.d
./fib_d
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

### Cangjie (仓颉)
```bash
cjc fib_cangjie.cj
./fib_cangjie
```

### AutoHotkey v2
```bash
AutoHotkey64.exe fib_ahk2.ahk
```
注意：AutoHotkey会弹出消息框显示结果

### Racket
```bash
racket fib_racket.rkt
```
或编译后运行：
```bash
raco exe fib_racket.rkt
./fib_racket
```

### SBCL (Common Lisp)
快速测试（脚本模式）：
```bash
sbcl --script fib_sbcl.lisp
```

最佳性能（编译成可执行文件）：
```bash
sbcl --load fib_sbcl.lisp --eval "(sb-ext:save-lisp-and-die \"fib_sbcl\" :toplevel #'main :executable t)"
./fib_sbcl
```
注意：编译后的可执行文件约 30-40MB（包含完整的 SBCL 运行时）

## 输出格式

每个程序输出：
```
Result: 165580141
语言名称: XXX.XX ms
```

例如：
```
Result: 165580141
C: 245.32 ms
```
