using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;

class Benchmark
{
    // 简单的随机数生成器（LCG）
    class SimpleRandom
    {
        private long state;

        public SimpleRandom(long seed)
        {
            state = seed;
        }

        public int Next()
        {
            state = (state * 1103515245 + 12345) & 0x7FFFFFFF;
            return (int)(state >> 16);
        }

        public int Next(int minValue, int maxValue)
        {
            int range = maxValue - minValue + 1;
            return minValue + (Next() % range);
        }

        public double NextDouble()
        {
            return (double)Next() / int.MaxValue;
        }
    }

    // 测试1：斐波那契数列（递归）
    static long FibRecursive(int n)
    {
        if (n <= 1) return n;
        return FibRecursive(n - 1) + FibRecursive(n - 2);
    }

    static long Test1FibonacciRecursive()
    {
        return FibRecursive(41);
    }

    // 测试2：斐波那契数列（迭代）
    static long Test2FibonacciIterative()
    {
        int n = 10000000;
        if (n <= 1) return n;

        long a = 0, b = 1;
        for (int i = 2; i <= n; i++)
        {
            long temp = b;
            b = (a + b) % 1000000007;
            a = temp;
        }
        return b;
    }

    // 测试3：质数筛选
    static int Test3PrimeSieve()
    {
        int limit = 20000000;
        bool[] isPrime = new bool[limit + 1];
        
        for (int i = 0; i <= limit; i++)
        {
            isPrime[i] = true;
        }
        isPrime[0] = isPrime[1] = false;

        for (int i = 2; i * i <= limit; i++)
        {
            if (isPrime[i])
            {
                for (int j = i * i; j <= limit; j += i)
                {
                    isPrime[j] = false;
                }
            }
        }

        int count = 0;
        for (int i = 0; i <= limit; i++)
        {
            if (isPrime[i]) count++;
        }

        return count;
    }

    // 测试4：快速排序
    static int Test4Sorting()
    {
        SimpleRandom rng = new SimpleRandom(42);
        int[] arr = new int[2000000];
        
        for (int i = 0; i < arr.Length; i++)
        {
            arr[i] = rng.Next(0, 1000000);
        }

        Array.Sort(arr);
        return arr[0];
    }

    // 测试5：字符串拼接
    static int Test5StringConcat()
    {
        StringBuilder sb = new StringBuilder(20000000);
        
        for (int i = 0; i < 20000000; i++)
        {
            sb.Append('a');
        }

        return sb.Length;
    }

    // 测试6：哈希表操作
    static int Test6HashTable()
    {
        Dictionary<string, int> hashMap = new Dictionary<string, int>();

        // 插入
        for (int i = 0; i < 1000000; i++)
        {
            hashMap[$"key_{i}"] = i;
        }

        // 查询
        SimpleRandom rng = new SimpleRandom(42);
        int foundCount = 0;
        for (int i = 0; i < 1000000; i++)
        {
            string key = $"key_{rng.Next(0, 1000000)}";
            if (hashMap.ContainsKey(key))
            {
                foundCount++;
            }
        }

        return foundCount;
    }

    // 测试7：文件I/O
    static int Test7FileIO()
    {
        string filename = "test_file_csharp.txt";

        // 写入
        using (StreamWriter writer = new StreamWriter(filename))
        {
            for (int i = 0; i < 2000000; i++)
            {
                writer.WriteLine($"Line {i}: This is a test line.");
            }
        }

        // 读取
        int count = 0;
        using (StreamReader reader = new StreamReader(filename))
        {
            while (reader.ReadLine() != null)
            {
                count++;
            }
        }

        // 清理
        File.Delete(filename);

        return count;
    }

    // 测试8：内存分配与访问
    class DataObject
    {
        public int Id { get; set; }
        public int Value { get; set; }
        public string Name { get; set; }
    }

    static int Test8MemoryAllocation()
    {
        List<DataObject> data = new List<DataObject>(1000000);

        // 创建对象
        for (int i = 0; i < 1000000; i++)
        {
            data.Add(new DataObject
            {
                Id = i,
                Value = i * 2,
                Name = $"item_{i}"
            });
        }

        // 随机访问
        SimpleRandom rng = new SimpleRandom(42);
        long total = 0;
        for (int i = 0; i < 1000000; i++)
        {
            int idx = rng.Next(0, 999999);
            total += data[idx].Value;
        }

        return (int)(total % 1000000);
    }

    // 测试9：矩阵乘法
    static int Test9MatrixMultiplication()
    {
        int size = 400;
        double[,] A = new double[size, size];
        double[,] B = new double[size, size];
        double[,] C = new double[size, size];

        // 初始化矩阵
        SimpleRandom rng = new SimpleRandom(42);
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                A[i, j] = rng.NextDouble();
                B[i, j] = rng.NextDouble();
            }
        }

        // 矩阵乘法
        for (int i = 0; i < size; i++)
        {
            for (int j = 0; j < size; j++)
            {
                for (int k = 0; k < size; k++)
                {
                    C[i, j] += A[i, k] * B[k, j];
                }
            }
        }

        return (int)(C[0, 0] * 1000);
    }

    // 测试10：字符串处理
    static int Test10StringProcessing()
    {
        // 创建长文本
        string baseText = "The quick brown fox jumps over the lazy dog. ";
        StringBuilder sb = new StringBuilder(baseText.Length * 1500000);
        
        for (int i = 0; i < 1500000; i++)
        {
            sb.Append(baseText);
        }
        string text = sb.ToString();

        // 查找 "the" (不使用正则表达式)
        int count = 0;
        int pos = 0;
        while ((pos = text.IndexOf("the", pos, StringComparison.Ordinal)) != -1)
        {
            count++;
            pos += 3;
        }

        // 替换 "fox" 为 "cat"
        text = text.Replace("fox", "cat");

        // 分割：统计单词数 (不使用正则，直接计数)
        int wordCount = 0;
        bool inWord = false;

        for (int i = 0; i < text.Length; i++)
        {
            char c = text[i];
            if (c == ' ' || c == '\n' || c == '\t')
            {
                if (inWord)
                {
                    wordCount++;
                    inWord = false;
                }
            }
            else
            {
                inWord = true;
            }
        }

        // 最后一个单词
        if (inWord)
        {
            wordCount++;
        }

        return wordCount;
    }

    static (object result, double elapsed) MeasureTime(Func<object> func)
    {
        Stopwatch sw = Stopwatch.StartNew();
        object result = func();
        sw.Stop();
        return (result, sw.Elapsed.TotalMilliseconds);
    }

    static void Main(string[] args)
    {
        // 设置控制台编码为UTF-8
        Console.OutputEncoding = Encoding.UTF8;

        string version = Environment.Version.ToString();
        Console.WriteLine("======================================================================");
        Console.WriteLine($"C# (.NET {version}) 性能测试");
        Console.WriteLine("======================================================================");
        Console.WriteLine();

        // JIT预热：让.NET运行时优化关键代码路径
        // 这对JIT语言是公平的，因为生产环境中代码会运行多次
        for (int i = 0; i < 3; i++)
        {
            FibRecursive(20);
            Test2FibonacciIterative();
        }

        Console.WriteLine($"{"测试项目",-20} {"结果",-15} {"耗时(ms)",15}");
        Console.WriteLine("----------------------------------------------------------------------");

        Stopwatch totalSw = Stopwatch.StartNew();

        // 测试1
        var (result1, time1) = MeasureTime(() => Test1FibonacciRecursive());
        Console.WriteLine($"{"斐波那契(递归)",-20} {result1,-15} {time1,15:F2}");

        // 测试2
        var (result2, time2) = MeasureTime(() => Test2FibonacciIterative());
        Console.WriteLine($"{"斐波那契(迭代)",-20} {result2,-15} {time2,15:F2}");

        // 测试3
        var (result3, time3) = MeasureTime(() => Test3PrimeSieve());
        Console.WriteLine($"{"质数筛选",-20} {result3,-15} {time3,15:F2}");

        // 测试4
        var (result4, time4) = MeasureTime(() => Test4Sorting());
        Console.WriteLine($"{"快速排序",-20} {result4,-15} {time4,15:F2}");

        // 测试5
        var (result5, time5) = MeasureTime(() => Test5StringConcat());
        Console.WriteLine($"{"字符串拼接",-20} {result5,-15} {time5,15:F2}");

        // 测试6
        var (result6, time6) = MeasureTime(() => Test6HashTable());
        Console.WriteLine($"{"哈希表操作",-20} {result6,-15} {time6,15:F2}");

        // 测试7
        var (result7, time7) = MeasureTime(() => Test7FileIO());
        Console.WriteLine($"{"文件I/O",-20} {result7,-15} {time7,15:F2}");

        // 测试8
        var (result8, time8) = MeasureTime(() => Test8MemoryAllocation());
        Console.WriteLine($"{"内存分配",-20} {result8,-15} {time8,15:F2}");

        // 测试9
        var (result9, time9) = MeasureTime(() => Test9MatrixMultiplication());
        Console.WriteLine($"{"矩阵乘法",-20} {result9,-15} {time9,15:F2}");

        // 测试10
        var (result10, time10) = MeasureTime(() => Test10StringProcessing());
        Console.WriteLine($"{"字符串处理",-20} {result10,-15} {time10,15:F2}");

        totalSw.Stop();

        Console.WriteLine("----------------------------------------------------------------------");
        Console.WriteLine($"{"总耗时",-20} {"",-15} {totalSw.Elapsed.TotalMilliseconds,15:F2}");
        Console.WriteLine("======================================================================");
    }
}
