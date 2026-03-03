; AutoHotkey v2 性能测试
; 注意：AHK2主要用于Windows自动化，不适合计算密集型任务

; 测试1：斐波那契数列（递归）
FibRecursive(n) {
    if (n <= 1)
        return n
    return FibRecursive(n - 1) + FibRecursive(n - 2)
}

Test1FibonacciRecursive() {
    return FibRecursive(41)
}

; 测试2：斐波那契数列（迭代）
Test2FibonacciIterative() {
    n := 10000000
    if (n <= 1)
        return n
    
    a := 0
    b := 1
    Loop n - 1 {
        temp := b
        b := Mod(a + b, 1000000007)
        a := temp
    }
    return b
}

; 测试3：质数筛选
Test3PrimeSieve() {
    limit := 20000000
    isPrime := Map()
    
    Loop limit + 1 {
        isPrime[A_Index - 1] := true
    }
    isPrime[0] := false
    isPrime[1] := false
    
    i := 2
    while (i * i <= limit) {
        if (isPrime[i]) {
            j := i * i
            while (j <= limit) {
                isPrime[j] := false
                j += i
            }
        }
        i++
    }
    
    count := 0
    Loop limit + 1 {
        if (isPrime[A_Index - 1])
            count++
    }
    return count
}

; 测试4：快速排序
Test4Sorting() {
    Random , 42
    arr := []
    Loop 2000000 {
        arr.Push(Random(0, 1000000))
    }
    
    ; 简单排序（AHK2没有内置快速排序）
    arr := BubbleSort(arr)
    return arr[1]
}

BubbleSort(arr) {
    n := arr.Length
    Loop n {
        i := A_Index
        Loop n - i {
            j := A_Index
            if (arr[j] > arr[j + 1]) {
                temp := arr[j]
                arr[j] := arr[j + 1]
                arr[j + 1] := temp
            }
        }
    }
    return arr
}

; 测试5：字符串拼接
Test5StringConcat() {
    str := ""
    Loop 20000000 {
        str .= "a"
    }
    return StrLen(str)
}

; 测试6：哈希表操作
Test6HashTable() {
    hashMap := Map()
    
    ; 插入
    Loop 1000000 {
        hashMap["key_" . (A_Index - 1)] := A_Index - 1
    }
    
    ; 查询
    Random , 42
    foundCount := 0
    Loop 1000000 {
        key := "key_" . Random(0, 1000000)
        if (hashMap.Has(key))
            foundCount++
    }
    
    return foundCount
}

; 测试7：文件I/O
Test7FileIO() {
    filename := "test_file_ahk2.txt"
    
    ; 写入
    FileDelete filename
    Loop 2000000 {
        FileAppend "Line " . (A_Index - 1) . ": This is a test line.`n", filename
    }
    
    ; 读取
    count := 0
    Loop Read, filename {
        count++
    }
    
    ; 清理
    FileDelete filename
    
    return count
}

; 测试8：内存分配与访问
Test8MemoryAllocation() {
    data := []
    
    ; 创建对象
    Loop 1000000 {
        data.Push(Map("id", A_Index - 1, "value", (A_Index - 1) * 2, "name", "item_" . (A_Index - 1)))
    }
    
    ; 随机访问
    Random , 42
    total := 0
    Loop 1000000 {
        idx := Random(1, 1000000)
        total += data[idx]["value"]
    }
    
    return Mod(total, 1000000)
}

; 测试9：矩阵乘法
Test9MatrixMultiplication() {
    size := 400
    
    ; 初始化矩阵
    Random , 42
    A := []
    B := []
    C := []
    
    Loop size {
        i := A_Index
        A.Push([])
        B.Push([])
        C.Push([])
        Loop size {
            A[i].Push(Random(0.0, 1.0))
            B[i].Push(Random(0.0, 1.0))
            C[i].Push(0.0)
        }
    }
    
    ; 矩阵乘法
    Loop size {
        i := A_Index
        Loop size {
            j := A_Index
            Loop size {
                k := A_Index
                C[i][j] += A[i][k] * B[k][j]
            }
        }
    }
    
    return Integer(C[1][1] * 1000)
}

; 测试10：字符串处理
Test10StringProcessing() {
    ; 创建长文本
    base := "The quick brown fox jumps over the lazy dog. "
    text := ""
    Loop 1500000 {
        text .= base
    }
    
    ; 查找 "the"
    count := 0
    pos := 1
    Loop {
        pos := InStr(text, "the", , pos)
        if (pos = 0)
            break
        count++
        pos++
    }
    
    ; 替换 "fox" 为 "cat"
    text := StrReplace(text, "fox", "cat")
    
    ; 分割：统计单词数
    words := StrSplit(text, " ")
    
    return words.Length
}

MeasureTime(name, fn) {
    start := A_TickCount
    result := %fn%()
    elapsed := A_TickCount - start
    return [result, elapsed]
}

Main() {
    OutputDebug "======================================================================`n"
    OutputDebug "AutoHotkey v2 性能测试`n"
    OutputDebug "======================================================================`n`n"
    
    MsgBox "AutoHotkey v2 性能测试`n`n注意：AHK2不适合计算密集型任务，测试可能需要很长时间。`n`n点击确定开始测试...", "性能测试", "OK"
    
    tests := [
        ["斐波那契(递归)", "Test1FibonacciRecursive"],
        ["斐波那契(迭代)", "Test2FibonacciIterative"],
        ["质数筛选", "Test3PrimeSieve"],
        ["快速排序", "Test4Sorting"],
        ["字符串拼接", "Test5StringConcat"],
        ["哈希表操作", "Test6HashTable"],
        ["文件I/O", "Test7FileIO"],
        ["内存分配", "Test8MemoryAllocation"],
        ["矩阵乘法", "Test9MatrixMultiplication"],
        ["字符串处理", "Test10StringProcessing"]
    ]
    
    results := ""
    totalStart := A_TickCount
    
    for test in tests {
        name := test[1]
        fn := test[2]
        
        result := MeasureTime(name, fn)
        results .= Format("{:-20} {:-15} {:>15.2f}`n", name, result[1], result[2])
        OutputDebug Format("{:-20} {:-15} {:>15.2f}`n", name, result[1], result[2])
    }
    
    totalElapsed := A_TickCount - totalStart
    results .= Format("{:-20} {:-15} {:>15.2f}`n", "总耗时", "", totalElapsed)
    
    MsgBox results, "测试结果", "OK"
}

Main()
