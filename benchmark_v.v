import os
import time
import rand

// 测试1：斐波那契数列（递归）
fn fib_recursive(n int) i64 {
	if n <= 1 {
		return i64(n)
	}
	return fib_recursive(n - 1) + fib_recursive(n - 2)
}

fn test1_fibonacci_recursive() i64 {
	return fib_recursive(41)
}

// 测试2：斐波那契数列（迭代）
fn test2_fibonacci_iterative() i64 {
	n := 10000000
	if n <= 1 {
		return i64(n)
	}
	
	mut a := i64(0)
	mut b := i64(1)
	for i in 2 .. n + 1 {
		temp := b
		b = (a + b) % 1000000007
		a = temp
	}
	return b
}

// 测试3：质数筛选
fn test3_prime_sieve() int {
	limit := 20000000
	mut is_prime := []bool{len: limit + 1, init: true}
	is_prime[0] = false
	is_prime[1] = false
	
	mut i := 2
	for i * i <= limit {
		if is_prime[i] {
			mut j := i * i
			for j <= limit {
				is_prime[j] = false
				j += i
			}
		}
		i++
	}
	
	mut count := 0
	for prime in is_prime {
		if prime {
			count++
		}
	}
	return count
}

// 测试4：快速排序
fn test4_sorting() int {
	rand.seed([u32(42), 0])
	mut arr := []int{len: 2000000}
	for i in 0 .. 2000000 {
		arr[i] = rand.intn(1000001) or { 0 }
	}
	arr.sort()
	return arr[0]
}

// 测试5：字符串拼接
fn test5_string_concat() int {
	mut str := ''
	for _ in 0 .. 20000000 {
		str += 'a'
	}
	return str.len
}

// 测试6：哈希表操作
fn test6_hash_table() int {
	mut hash_map := map[string]int{}
	
	// 插入
	for i in 0 .. 1000000 {
		hash_map['key_${i}'] = i
	}
	
	// 查询
	rand.seed([u32(42), 0])
	mut found_count := 0
	for _ in 0 .. 1000000 {
		key := 'key_${rand.intn(1000001) or { 0 }}'
		if key in hash_map {
			found_count++
		}
	}
	
	return found_count
}

// 测试7：文件I/O
fn test7_file_io() int {
	filename := 'test_file_v.txt'
	
	// 写入
	mut lines := []string{}
	for i in 0 .. 2000000 {
		lines << 'Line ${i}: This is a test line.'
	}
	os.write_file(filename, lines.join('\n')) or { panic(err) }
	
	// 读取
	content := os.read_file(filename) or { panic(err) }
	count := content.split('\n').filter(it.len > 0).len
	
	// 清理
	os.rm(filename) or {}
	
	return count
}

// 测试8：内存分配与访问
struct DataObject {
	id     int
	value  int
	name   string
}

fn test8_memory_allocation() int {
	mut data := []DataObject{cap: 1000000}
	
	// 创建对象
	for i in 0 .. 1000000 {
		data << DataObject{
			id: i
			value: i * 2
			name: 'item_${i}'
		}
	}
	
	// 随机访问
	rand.seed([u32(42), 0])
	mut total := i64(0)
	for _ in 0 .. 1000000 {
		idx := rand.intn(1000000) or { 0 }
		total += data[idx].value
	}
	
	return int(total % 1000000)
}

// 测试9：矩阵乘法
fn test9_matrix_multiplication() int {
	size := 400
	
	// 初始化矩阵
	rand.seed([u32(42), 0])
	mut a := [][]f64{len: size, init: []f64{len: size}}
	mut b := [][]f64{len: size, init: []f64{len: size}}
	mut c := [][]f64{len: size, init: []f64{len: size}}
	
	for i in 0 .. size {
		for j in 0 .. size {
			a[i][j] = rand.f64()
			b[i][j] = rand.f64()
			c[i][j] = 0.0
		}
	}
	
	// 矩阵乘法
	for i in 0 .. size {
		for j in 0 .. size {
			for k in 0 .. size {
				c[i][j] += a[i][k] * b[k][j]
			}
		}
	}
	
	return int(c[0][0] * 1000)
}

// 测试10：字符串处理
fn test10_string_processing() int {
	// 创建长文本
	base := 'The quick brown fox jumps over the lazy dog. '
	mut text := ''
	for _ in 0 .. 1500000 {
		text += base
	}
	
	// 查找 "the"
	count := text.count('the')
	
	// 替换 "fox" 为 "cat"
	text = text.replace('fox', 'cat')
	
	// 分割：统计单词数
	words := text.split(' ')
	
	return words.len
}

fn measure_time(name string, fn_test fn () int) (int, f64) {
	start := time.now()
	result := fn_test()
	elapsed := (time.now() - start).milliseconds()
	return result, f64(elapsed)
}

fn measure_time_i64(name string, fn_test fn () i64) (i64, f64) {
	start := time.now()
	result := fn_test()
	elapsed := (time.now() - start).milliseconds()
	return result, f64(elapsed)
}

fn main() {
	println('======================================================================')
	println('V 性能测试')
	println('======================================================================')
	println('')
	
	println('${'测试项目':-20} ${'结果':-15} ${'耗时(ms)':>15}')
	println('----------------------------------------------------------------------')
	
	total_start := time.now()
	
	// 测试1
	result1, time1 := measure_time_i64('斐波那契(递归)', test1_fibonacci_recursive)
	println('${'斐波那契(递归)':-20} ${result1:-15} ${time1:>15.2}')
	
	// 测试2
	result2, time2 := measure_time_i64('斐波那契(迭代)', test2_fibonacci_iterative)
	println('${'斐波那契(迭代)':-20} ${result2:-15} ${time2:>15.2}')
	
	// 测试3
	result3, time3 := measure_time('质数筛选', test3_prime_sieve)
	println('${'质数筛选':-20} ${result3:-15} ${time3:>15.2}')
	
	// 测试4
	result4, time4 := measure_time('快速排序', test4_sorting)
	println('${'快速排序':-20} ${result4:-15} ${time4:>15.2}')
	
	// 测试5
	result5, time5 := measure_time('字符串拼接', test5_string_concat)
	println('${'字符串拼接':-20} ${result5:-15} ${time5:>15.2}')
	
	// 测试6
	result6, time6 := measure_time('哈希表操作', test6_hash_table)
	println('${'哈希表操作':-20} ${result6:-15} ${time6:>15.2}')
	
	// 测试7
	result7, time7 := measure_time('文件I/O', test7_file_io)
	println('${'文件I/O':-20} ${result7:-15} ${time7:>15.2}')
	
	// 测试8
	result8, time8 := measure_time('内存分配', test8_memory_allocation)
	println('${'内存分配':-20} ${result8:-15} ${time8:>15.2}')
	
	// 测试9
	result9, time9 := measure_time('矩阵乘法', test9_matrix_multiplication)
	println('${'矩阵乘法':-20} ${result9:-15} ${time9:>15.2}')
	
	// 测试10
	result10, time10 := measure_time('字符串处理', test10_string_processing)
	println('${'字符串处理':-20} ${result10:-15} ${time10:>15.2}')
	
	total_elapsed := (time.now() - total_start).milliseconds()
	
	println('----------------------------------------------------------------------')
	println('${'总耗时':-20} ${'':-15} ${f64(total_elapsed):>15.2}')
	println('======================================================================')
}
