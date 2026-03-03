import java.io.*;
import java.util.*;
import java.util.regex.*;

public class Benchmark {
    
    // 测试1：斐波那契数列（递归）
    static long fibRecursive(int n) {
        if (n <= 1) return n;
        return fibRecursive(n - 1) + fibRecursive(n - 2);
    }
    
    static long test1FibonacciRecursive() {
        return fibRecursive(41);
    }
    
    // 测试2：斐波那契数列（迭代）
    static long test2FibonacciIterative() {
        int n = 10000000;
        if (n <= 1) return n;
        
        long a = 0, b = 1;
        for (int i = 2; i <= n; i++) {
            long temp = b;
            b = (a + b) % 1000000007;
            a = temp;
        }
        return b;
    }
    
    // 测试3：质数筛选
    static int test3PrimeSieve() {
        int limit = 20000000;
        boolean[] isPrime = new boolean[limit + 1];
        Arrays.fill(isPrime, true);
        isPrime[0] = isPrime[1] = false;
        
        for (int i = 2; i * i <= limit; i++) {
            if (isPrime[i]) {
                for (int j = i * i; j <= limit; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        
        int count = 0;
        for (boolean prime : isPrime) {
            if (prime) count++;
        }
        return count;
    }
    
    // 测试4：快速排序
    static int test4Sorting() {
        Random rng = new Random(42);
        int[] arr = new int[2000000];
        for (int i = 0; i < arr.length; i++) {
            arr[i] = rng.nextInt(1000001);
        }
        Arrays.sort(arr);
        return arr[0];
    }
    
    // 测试5：字符串拼接
    static int test5StringConcat() {
        StringBuilder sb = new StringBuilder(20000000);
        for (int i = 0; i < 20000000; i++) {
            sb.append('a');
        }
        return sb.length();
    }
    
    // 测试6：哈希表操作
    static int test6HashTable() {
        HashMap<String, Integer> hashMap = new HashMap<>();
        
        // 插入
        for (int i = 0; i < 1000000; i++) {
            hashMap.put("key_" + i, i);
        }
        
        // 查询
        Random rng = new Random(42);
        int foundCount = 0;
        for (int i = 0; i < 1000000; i++) {
            String key = "key_" + rng.nextInt(1000001);
            if (hashMap.containsKey(key)) {
                foundCount++;
            }
        }
        return foundCount;
    }
    
    // 测试7：文件I/O
    static int test7FileIO() throws IOException {
        String filename = "test_file_java.txt";
        
        // 写入
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
            for (int i = 0; i < 2000000; i++) {
                writer.write("Line " + i + ": This is a test line.\n");
            }
        }
        
        // 读取
        int count = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            while (reader.readLine() != null) {
                count++;
            }
        }
        
        // 清理
        new File(filename).delete();
        
        return count;
    }
    
    // 测试8：内存分配与访问
    static class DataObject {
        int id;
        int value;
        String name;
        
        DataObject(int id, int value, String name) {
            this.id = id;
            this.value = value;
            this.name = name;
        }
    }
    
    static int test8MemoryAllocation() {
        List<DataObject> data = new ArrayList<>();
        
        // 创建对象
        for (int i = 0; i < 1000000; i++) {
            data.add(new DataObject(i, i * 2, "item_" + i));
        }
        
        // 随机访问
        Random rng = new Random(42);
        long total = 0;
        for (int i = 0; i < 1000000; i++) {
            int idx = rng.nextInt(1000000);
            total += data.get(idx).value;
        }
        
        return (int)(total % 1000000);
    }
    
    // 测试9：矩阵乘法
    static int test9MatrixMultiplication() {
        int size = 400;
        Random rng = new Random(42);
        
        double[][] A = new double[size][size];
        double[][] B = new double[size][size];
        double[][] C = new double[size][size];
        
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                A[i][j] = rng.nextDouble();
                B[i][j] = rng.nextDouble();
            }
        }
        
        // 矩阵乘法
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                for (int k = 0; k < size; k++) {
                    C[i][j] += A[i][k] * B[k][j];
                }
            }
        }
        
        return (int)(C[0][0] * 1000);
    }
    
    // 测试10：字符串处理
    static int test10StringProcessing() {
        // 创建长文本
        String base = "The quick brown fox jumps over the lazy dog. ";
        StringBuilder sb = new StringBuilder(base.length() * 1500000);
        
        for (int i = 0; i < 1500000; i++) {
            sb.append(base);
        }
        String text = sb.toString();
        
        // 查找 "the" (不使用正则表达式)
        int count = 0;
        int index = 0;
        while ((index = text.indexOf("the", index)) != -1) {
            count++;
            index += 3;  // 跳过已找到的 "the"
        }
        
        // 替换 "fox" 为 "cat"
        text = text.replace("fox", "cat");
        
        // 分割：统计单词数 (不使用正则，直接计数)
        int wordCount = 0;
        boolean inWord = false;
        
        for (int i = 0; i < text.length(); i++) {
            char c = text.charAt(i);
            if (c == ' ' || c == '\n' || c == '\t') {
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
    
    public static void main(String[] args) throws IOException {
        String version = System.getProperty("java.version");
        System.out.println("======================================================================");
        System.out.println("Java " + version + " 性能测试");
        System.out.println("======================================================================");
        System.out.println();
        
        // JIT预热：让JVM优化关键代码路径
        // 这对JIT语言是公平的，因为生产环境中代码会运行多次
        System.out.print("JIT预热中...");
        for (int i = 0; i < 5; i++) {
            fibRecursive(20);
            test2FibonacciIterative();
            test3PrimeSieve();
        }
        System.out.println(" 完成");
        System.out.println();
        
        System.out.printf("%-20s %-15s %15s%n", "测试项目", "结果", "耗时(ms)");
        System.out.println("----------------------------------------------------------------------");
        
        long totalStart = System.nanoTime();
        
        // 测试1
        long start = System.nanoTime();
        long result1 = test1FibonacciRecursive();
        double time1 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "斐波那契(递归)", result1, time1);
        
        // 测试2
        start = System.nanoTime();
        long result2 = test2FibonacciIterative();
        double time2 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "斐波那契(迭代)", result2, time2);
        
        // 测试3
        start = System.nanoTime();
        int result3 = test3PrimeSieve();
        double time3 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "质数筛选", result3, time3);
        
        // 测试4
        start = System.nanoTime();
        int result4 = test4Sorting();
        double time4 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "快速排序", result4, time4);
        
        // 测试5
        start = System.nanoTime();
        int result5 = test5StringConcat();
        double time5 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "字符串拼接", result5, time5);
        
        // 测试6
        start = System.nanoTime();
        int result6 = test6HashTable();
        double time6 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "哈希表操作", result6, time6);
        
        // 测试7
        start = System.nanoTime();
        int result7 = test7FileIO();
        double time7 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "文件I/O", result7, time7);
        
        // 测试8
        start = System.nanoTime();
        int result8 = test8MemoryAllocation();
        double time8 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "内存分配", result8, time8);
        
        // 测试9
        start = System.nanoTime();
        int result9 = test9MatrixMultiplication();
        double time9 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "矩阵乘法", result9, time9);
        
        // 测试10
        start = System.nanoTime();
        int result10 = test10StringProcessing();
        double time10 = (System.nanoTime() - start) / 1_000_000.0;
        System.out.printf("%-20s %-15d %15.2f%n", "字符串处理", result10, time10);
        
        double totalTime = (System.nanoTime() - totalStart) / 1_000_000.0;
        
        System.out.println("----------------------------------------------------------------------");
        System.out.printf("%-20s %-15s %15.2f%n", "总耗时", "", totalTime);
        System.out.println("======================================================================");
    }
}
