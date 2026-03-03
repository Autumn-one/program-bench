import std/[times, random, strformat, strutils, os, algorithm, tables]

# 测试1：斐波那契数列（递归）
proc fibRecursive(n: int): int64 =
  if n <= 1:
    return n.int64
  return fibRecursive(n - 1) + fibRecursive(n - 2)

proc test1FibonacciRecursive(): int64 =
  return fibRecursive(41)

# 测试2：斐波那契数列（迭代）
proc test2FibonacciIterative(): int64 =
  let n = 10000000
  if n <= 1:
    return n.int64
  
  var a: int64 = 0
  var b: int64 = 1
  for i in 2..n:
    let temp = b
    b = (a + b) mod 1000000007
    a = temp
  return b

# 测试3：质数筛选
proc test3PrimeSieve(): int =
  let limit = 20000000
  var isPrime = newSeq[bool](limit + 1)
  for i in 0..limit:
    isPrime[i] = true
  isPrime[0] = false
  isPrime[1] = false
  
  var i = 2
  while i * i <= limit:
    if isPrime[i]:
      var j = i * i
      while j <= limit:
        isPrime[j] = false
        j += i
    i += 1
  
  var count = 0
  for prime in isPrime:
    if prime:
      count += 1
  return count

# 测试4：快速排序
proc test4Sorting(): int =
  randomize(42)
  var arr = newSeq[int](2000000)
  for i in 0..<2000000:
    arr[i] = rand(0..1000000)
  
  arr.sort()
  return arr[0]

# 测试5：字符串拼接
proc test5StringConcat(): int =
  var str = ""
  for i in 0..<20000000:
    str.add('a')
  return str.len

# 测试6：哈希表操作
proc test6HashTable(): int =
  var hashMap = initTable[string, int]()
  
  # 插入
  for i in 0..<1000000:
    hashMap[&"key_{i}"] = i
  
  # 查询
  randomize(42)
  var foundCount = 0
  for i in 0..<1000000:
    let key = &"key_{rand(0..1000000)}"
    if hashMap.hasKey(key):
      foundCount += 1
  
  return foundCount

# 测试7：文件I/O
proc test7FileIO(): int =
  let filename = "test_file_nim.txt"
  
  # 写入
  var f = open(filename, fmWrite)
  for i in 0..<2000000:
    f.writeLine(&"Line {i}: This is a test line.")
  f.close()
  
  # 读取
  var count = 0
  f = open(filename, fmRead)
  for line in f.lines:
    count += 1
  f.close()
  
  # 清理
  removeFile(filename)
  
  return count

# 测试8：内存分配与访问
type DataObject = object
  id: int
  value: int
  name: string

proc test8MemoryAllocation(): int =
  var data = newSeq[DataObject](1000000)
  
  # 创建对象
  for i in 0..<1000000:
    data[i] = DataObject(
      id: i,
      value: i * 2,
      name: &"item_{i}"
    )
  
  # 随机访问
  randomize(42)
  var total: int64 = 0
  for i in 0..<1000000:
    let idx = rand(0..999999)
    total += data[idx].value
  
  return int(total mod 1000000)

# 测试9：矩阵乘法
proc test9MatrixMultiplication(): int =
  let size = 400
  
  # 初始化矩阵
  randomize(42)
  var A = newSeq[seq[float]](size)
  var B = newSeq[seq[float]](size)
  var C = newSeq[seq[float]](size)
  
  for i in 0..<size:
    A[i] = newSeq[float](size)
    B[i] = newSeq[float](size)
    C[i] = newSeq[float](size)
    for j in 0..<size:
      A[i][j] = rand(1.0)
      B[i][j] = rand(1.0)
      C[i][j] = 0.0
  
  # 矩阵乘法
  for i in 0..<size:
    for j in 0..<size:
      for k in 0..<size:
        C[i][j] += A[i][k] * B[k][j]
  
  return int(C[0][0] * 1000)

# 测试10：字符串处理
proc test10StringProcessing(): int =
  # 创建长文本
  let base = "The quick brown fox jumps over the lazy dog. "
  var text = ""
  for i in 0..<1500000:
    text.add(base)
  
  # 查找 "the"
  var count = 0
  var pos = 0
  while true:
    pos = text.find("the", pos)
    if pos == -1:
      break
    count += 1
    pos += 1
  
  # 替换 "fox" 为 "cat"
  text = text.replace("fox", "cat")
  
  # 分割：统计单词数
  let words = text.splitWhitespace()
  
  return words.len

proc measureTime(name: string, fn: proc(): int): (int, float) =
  let start = cpuTime()
  let result = fn()
  let elapsed = (cpuTime() - start) * 1000
  return (result, elapsed)

proc measureTime64(name: string, fn: proc(): int64): (int64, float) =
  let start = cpuTime()
  let result = fn()
  let elapsed = (cpuTime() - start) * 1000
  return (result, elapsed)

proc main() =
  echo "======================================================================"
  echo "Nim 性能测试"
  echo "======================================================================"
  echo ""
  
  echo alignLeft("测试项目", 20), alignLeft("结果", 15), align("耗时(ms)", 15)
  echo "----------------------------------------------------------------------"
  
  let totalStart = cpuTime()
  
  # 测试1
  let (result1, time1) = measureTime64("斐波那契(递归)", test1FibonacciRecursive)
  echo alignLeft("斐波那契(递归)", 20), alignLeft($result1, 15), align(formatFloat(time1, ffDecimal, 2), 15)
  
  # 测试2
  let (result2, time2) = measureTime64("斐波那契(迭代)", test2FibonacciIterative)
  echo alignLeft("斐波那契(迭代)", 20), alignLeft($result2, 15), align(formatFloat(time2, ffDecimal, 2), 15)
  
  # 测试3
  let (result3, time3) = measureTime("质数筛选", test3PrimeSieve)
  echo alignLeft("质数筛选", 20), alignLeft($result3, 15), align(formatFloat(time3, ffDecimal, 2), 15)
  
  # 测试4
  let (result4, time4) = measureTime("快速排序", test4Sorting)
  echo alignLeft("快速排序", 20), alignLeft($result4, 15), align(formatFloat(time4, ffDecimal, 2), 15)
  
  # 测试5
  let (result5, time5) = measureTime("字符串拼接", test5StringConcat)
  echo alignLeft("字符串拼接", 20), alignLeft($result5, 15), align(formatFloat(time5, ffDecimal, 2), 15)
  
  # 测试6
  let (result6, time6) = measureTime("哈希表操作", test6HashTable)
  echo alignLeft("哈希表操作", 20), alignLeft($result6, 15), align(formatFloat(time6, ffDecimal, 2), 15)
  
  # 测试7
  let (result7, time7) = measureTime("文件I/O", test7FileIO)
  echo alignLeft("文件I/O", 20), alignLeft($result7, 15), align(formatFloat(time7, ffDecimal, 2), 15)
  
  # 测试8
  let (result8, time8) = measureTime("内存分配", test8MemoryAllocation)
  echo alignLeft("内存分配", 20), alignLeft($result8, 15), align(formatFloat(time8, ffDecimal, 2), 15)
  
  # 测试9
  let (result9, time9) = measureTime("矩阵乘法", test9MatrixMultiplication)
  echo alignLeft("矩阵乘法", 20), alignLeft($result9, 15), align(formatFloat(time9, ffDecimal, 2), 15)
  
  # 测试10
  let (result10, time10) = measureTime("字符串处理", test10StringProcessing)
  echo alignLeft("字符串处理", 20), alignLeft($result10, 15), align(formatFloat(time10, ffDecimal, 2), 15)
  
  let totalElapsed = (cpuTime() - totalStart) * 1000
  
  echo "----------------------------------------------------------------------"
  echo alignLeft("总耗时", 20), alignLeft("", 15), align(formatFloat(totalElapsed, ffDecimal, 2), 15)
  echo "======================================================================"

when isMainModule:
  main()
