package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strings"
	"time"
)

// 测试1：斐波那契数列（递归）
func fibRecursive(n int) int64 {
	if n <= 1 {
		return int64(n)
	}
	return fibRecursive(n-1) + fibRecursive(n-2)
}

func test1FibonacciRecursive() int64 {
	return fibRecursive(41)
}

// 测试2：斐波那契数列（迭代）
func test2FibonacciIterative() int64 {
	n := 10000000
	if n <= 1 {
		return int64(n)
	}

	a, b := int64(0), int64(1)
	for i := 2; i <= n; i++ {
		a, b = b, (a+b)%1000000007
	}
	return b
}

// 测试3：质数筛选
func test3PrimeSieve() int {
	limit := 20000000
	isPrime := make([]bool, limit+1)
	for i := range isPrime {
		isPrime[i] = true
	}
	isPrime[0], isPrime[1] = false, false

	for i := 2; i*i <= limit; i++ {
		if isPrime[i] {
			for j := i * i; j <= limit; j += i {
				isPrime[j] = false
			}
		}
	}

	count := 0
	for _, prime := range isPrime {
		if prime {
			count++
		}
	}
	return count
}

// 测试4：快速排序
func test4Sorting() int {
	rand.Seed(42)
	size := 2000000
	arr := make([]int, size)
	for i := 0; i < size; i++ {
		arr[i] = rand.Intn(1000001)
	}

	// 使用简单的快速排序
	quickSort(arr, 0, len(arr)-1)
	return arr[0]
}

func quickSort(arr []int, low, high int) {
	if low < high {
		pi := partition(arr, low, high)
		quickSort(arr, low, pi-1)
		quickSort(arr, pi+1, high)
	}
}

func partition(arr []int, low, high int) int {
	pivot := arr[high]
	i := low - 1
	for j := low; j < high; j++ {
		if arr[j] < pivot {
			i++
			arr[i], arr[j] = arr[j], arr[i]
		}
	}
	arr[i+1], arr[high] = arr[high], arr[i+1]
	return i + 1
}

// 测试5：字符串拼接
func test5StringConcat() int {
	var builder []byte
	for i := 0; i < 20000000; i++ {
		builder = append(builder, 'a')
	}
	return len(builder)
}

// 测试6：哈希表操作
func test6HashTable() int {
	hashMap := make(map[string]int)

	// 插入
	for i := 0; i < 1000000; i++ {
		hashMap[fmt.Sprintf("key_%d", i)] = i
	}

	// 查询
	rand.Seed(42)
	foundCount := 0
	for i := 0; i < 1000000; i++ {
		key := fmt.Sprintf("key_%d", rand.Intn(1000001))
		if _, exists := hashMap[key]; exists {
			foundCount++
		}
	}

	return foundCount
}

// 测试7：文件I/O
func test7FileIO() int {
	filename := "test_file_go.txt"

	// 写入
	file, _ := os.Create(filename)
	writer := bufio.NewWriter(file)
	for i := 0; i < 2000000; i++ {
		fmt.Fprintf(writer, "Line %d: This is a test line.\n", i)
	}
	writer.Flush()
	file.Close()

	// 读取
	file, _ = os.Open(filename)
	scanner := bufio.NewScanner(file)
	count := 0
	for scanner.Scan() {
		count++
	}
	file.Close()

	// 清理
	os.Remove(filename)

	return count
}

// 测试8：内存分配与访问
type DataObject struct {
	ID    int
	Value int
	Name  string
}

func test8MemoryAllocation() int {
	data := make([]DataObject, 1000000)
	
	// 创建对象
	for i := 0; i < 1000000; i++ {
		data[i] = DataObject{
			ID:    i,
			Value: i * 2,
			Name:  fmt.Sprintf("item_%d", i),
		}
	}
	
	// 随机访问
	rand.Seed(42)
	total := int64(0)
	for i := 0; i < 1000000; i++ {
		idx := rand.Intn(1000000)
		total += int64(data[idx].Value)
	}
	
	return int(total % 1000000)
}

// 测试9：矩阵乘法
func test9MatrixMultiplication() int {
	size := 400

	// 初始化矩阵
	rand.Seed(42)
	A := make([][]float64, size)
	B := make([][]float64, size)
	C := make([][]float64, size)

	for i := 0; i < size; i++ {
		A[i] = make([]float64, size)
		B[i] = make([]float64, size)
		C[i] = make([]float64, size)
		for j := 0; j < size; j++ {
			A[i][j] = rand.Float64()
			B[i][j] = rand.Float64()
		}
	}

	// 矩阵乘法
	for i := 0; i < size; i++ {
		for j := 0; j < size; j++ {
			for k := 0; k < size; k++ {
				C[i][j] += A[i][k] * B[k][j]
			}
		}
	}

	return int(C[0][0] * 1000)
}

// 测试10：字符串处理
func test10StringProcessing() int {
	// 创建长文本
	base := "The quick brown fox jumps over the lazy dog. "
	var builder strings.Builder
	builder.Grow(len(base) * 1500000)
	
	for i := 0; i < 1500000; i++ {
		builder.WriteString(base)
	}
	text := builder.String()
	
	// 查找 "the" (不使用正则表达式)
	count := strings.Count(text, "the")
	_ = count // 避免未使用变量警告
	
	// 替换 "fox" 为 "cat"
	text = strings.ReplaceAll(text, "fox", "cat")
	
	// 分割：统计单词数 (不创建数组，直接计数)
	wordCount := 0
	inWord := false
	
	for _, char := range text {
		if char == ' ' || char == '\n' || char == '\t' {
			if inWord {
				wordCount++
				inWord = false
			}
		} else {
			inWord = true
		}
	}
	
	// 最后一个单词
	if inWord {
		wordCount++
	}
	
	return wordCount
}

func measureTime(name string, fn func() interface{}) (interface{}, float64) {
	start := time.Now()
	result := fn()
	elapsed := time.Since(start).Seconds() * 1000
	return result, elapsed
}

func main() {
	fmt.Println("======================================================================")
	fmt.Println("Go 性能测试")
	fmt.Println("======================================================================")
	fmt.Println()

	fmt.Printf("%-20s %-15s %15s\n", "测试项目", "结果", "耗时(ms)")
	fmt.Println("----------------------------------------------------------------------")

	totalStart := time.Now()

	// 测试1
	result1, time1 := measureTime("斐波那契(递归)", func() interface{} { return test1FibonacciRecursive() })
	fmt.Printf("%-20s %-15v %15.2f\n", "斐波那契(递归)", result1, time1)

	// 测试2
	result2, time2 := measureTime("斐波那契(迭代)", func() interface{} { return test2FibonacciIterative() })
	fmt.Printf("%-20s %-15v %15.2f\n", "斐波那契(迭代)", result2, time2)

	// 测试3
	result3, time3 := measureTime("质数筛选", func() interface{} { return test3PrimeSieve() })
	fmt.Printf("%-20s %-15v %15.2f\n", "质数筛选", result3, time3)

	// 测试4
	result4, time4 := measureTime("快速排序", func() interface{} { return test4Sorting() })
	fmt.Printf("%-20s %-15v %15.2f\n", "快速排序", result4, time4)

	// 测试5
	result5, time5 := measureTime("字符串拼接", func() interface{} { return test5StringConcat() })
	fmt.Printf("%-20s %-15v %15.2f\n", "字符串拼接", result5, time5)

	// 测试6
	result6, time6 := measureTime("哈希表操作", func() interface{} { return test6HashTable() })
	fmt.Printf("%-20s %-15v %15.2f\n", "哈希表操作", result6, time6)

	// 测试7
	result7, time7 := measureTime("文件I/O", func() interface{} { return test7FileIO() })
	fmt.Printf("%-20s %-15v %15.2f\n", "文件I/O", result7, time7)

	// 测试8
	result8, time8 := measureTime("内存分配", func() interface{} { return test8MemoryAllocation() })
	fmt.Printf("%-20s %-15v %15.2f\n", "内存分配", result8, time8)

	// 测试9
	result9, time9 := measureTime("矩阵乘法", func() interface{} { return test9MatrixMultiplication() })
	fmt.Printf("%-20s %-15v %15.2f\n", "矩阵乘法", result9, time9)

	// 测试10
	result10, time10 := measureTime("字符串处理", func() interface{} { return test10StringProcessing() })
	fmt.Printf("%-20s %-15v %15.2f\n", "字符串处理", result10, time10)

	totalTime := time.Since(totalStart).Seconds() * 1000

	fmt.Println("----------------------------------------------------------------------")
	fmt.Printf("%-20s %-15s %15.2f\n", "总耗时", "", totalTime)
	fmt.Println("======================================================================")
}
