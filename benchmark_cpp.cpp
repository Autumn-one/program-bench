#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <random>
#include <fstream>
#include <chrono>
#include <unordered_map>
#include <iomanip>

#ifdef _WIN32
#include <windows.h>
#endif

using namespace std;
using namespace std::chrono;

// 测试1：斐波那契数列（递归）
long long fib_recursive(int n) {
    if (n <= 1) return n;
    return fib_recursive(n - 1) + fib_recursive(n - 2);
}

long long test1_fibonacci_recursive() {
    return fib_recursive(41);
}

// 测试2：斐波那契数列（迭代）
long long test2_fibonacci_iterative() {
    int n = 10000000;
    if (n <= 1) return n;
    
    long long a = 0, b = 1;
    for (int i = 2; i <= n; i++) {
        long long temp = b;
        b = (a + b) % 1000000007;
        a = temp;
    }
    return b;
}

// 测试3：质数筛选
int test3_prime_sieve() {
    int limit = 20000000;
    vector<bool> is_prime(limit + 1, true);
    is_prime[0] = is_prime[1] = false;
    
    for (int i = 2; i * i <= limit; i++) {
        if (is_prime[i]) {
            for (int j = i * i; j <= limit; j += i) {
                is_prime[j] = false;
            }
        }
    }
    
    int count = 0;
    for (bool prime : is_prime) {
        if (prime) count++;
    }
    
    return count;
}

// 测试4：快速排序
int test4_sorting() {
    mt19937 rng(42);
    uniform_int_distribution<int> dist(0, 1000000);
    
    vector<int> arr(2000000);
    for (int i = 0; i < 2000000; i++) {
        arr[i] = dist(rng);
    }
    
    sort(arr.begin(), arr.end());
    return arr[0];
}

// 测试5：字符串拼接
int test5_string_concat() {
    string result;
    result.reserve(20000000);
    
    for (int i = 0; i < 20000000; i++) {
        result += 'a';
    }
    
    return result.length();
}

// 测试6：哈希表操作
int test6_hash_table() {
    unordered_map<string, int> hash_map;
    
    // 插入
    for (int i = 0; i < 1000000; i++) {
        hash_map["key_" + to_string(i)] = i;
    }
    
    // 查询
    mt19937 rng(42);
    uniform_int_distribution<int> dist(0, 1000000);
    
    int found_count = 0;
    for (int i = 0; i < 1000000; i++) {
        string key = "key_" + to_string(dist(rng));
        if (hash_map.find(key) != hash_map.end()) {
            found_count++;
        }
    }
    
    return found_count;
}

// 测试7：文件I/O
int test7_file_io() {
    const string filename = "test_file_cpp.txt";
    
    // 写入
    ofstream outfile(filename);
    for (int i = 0; i < 2000000; i++) {
        outfile << "Line " << i << ": This is a test line.\n";
    }
    outfile.close();
    
    // 读取
    ifstream infile(filename);
    string line;
    int count = 0;
    while (getline(infile, line)) {
        count++;
    }
    infile.close();
    
    // 清理
    remove(filename.c_str());
    
    return count;
}

// 测试8：内存分配与访问
struct DataObject {
    int id;
    int value;
    string name;
};

int test8_memory_allocation() {
    vector<DataObject> data;
    data.reserve(1000000);
    
    // 创建对象
    for (int i = 0; i < 1000000; i++) {
        data.push_back({i, i * 2, "item_" + to_string(i)});
    }
    
    // 随机访问
    mt19937 rng(42);
    uniform_int_distribution<int> dist(0, 999999);
    
    long long total = 0;
    for (int i = 0; i < 1000000; i++) {
        int idx = dist(rng);
        total += data[idx].value;
    }
    
    return static_cast<int>(total % 1000000);
}

// 测试9：矩阵乘法
int test9_matrix_multiplication() {
    int size = 400;
    
    // 初始化矩阵
    vector<vector<double>> A(size, vector<double>(size));
    vector<vector<double>> B(size, vector<double>(size));
    vector<vector<double>> C(size, vector<double>(size, 0.0));
    
    mt19937 rng(42);
    uniform_real_distribution<double> dist(0.0, 1.0);
    
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            A[i][j] = dist(rng);
            B[i][j] = dist(rng);
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
    
    return static_cast<int>(C[0][0] * 1000);
}

// 测试10：字符串处理
int test10_string_processing() {
    // 创建长文本 - 使用更高效的方式
    string base = "The quick brown fox jumps over the lazy dog. ";
    string text;
    
    // 预分配足够的空间
    try {
        text.reserve(base.length() * 1500000);
    } catch (const std::bad_alloc& e) {
        cerr << "内存分配失败: " << e.what() << endl;
        return -1;
    }
    
    // 使用更高效的拼接方式
    for (int i = 0; i < 1500000; i++) {
        text.append(base);
    }
    
    // 查找 "the" (不使用正则表达式)
    size_t pos = 0;
    int count = 0;
    while ((pos = text.find("the", pos)) != string::npos) {
        count++;
        pos += 3;  // 跳过已找到的 "the"
    }
    
    // 替换 "fox" 为 "cat"
    pos = 0;
    while ((pos = text.find("fox", pos)) != string::npos) {
        text.replace(pos, 3, "cat");
        pos += 3;
    }
    
    // 分割：统计单词数
    int word_count = 0;
    bool in_word = false;
    
    for (char c : text) {
        if (c == ' ' || c == '\n' || c == '\t') {
            if (in_word) {
                word_count++;
                in_word = false;
            }
        } else {
            in_word = true;
        }
    }
    
    // 最后一个单词
    if (in_word) {
        word_count++;
    }
    
    return word_count;
}

int main() {
    // 设置Windows控制台为UTF-8编码
    #ifdef _WIN32
    SetConsoleOutputCP(65001);  // 65001 是 UTF-8 的代码页
    #endif
    
    // 确保输出立即显示
    cout.sync_with_stdio(false);
    
    cout << "======================================================================" << endl;
    cout << "C++ (G++) 性能测试" << endl;
    cout << "======================================================================" << endl << endl;
    cout.flush();  // 强制刷新输出
    
    cout << left << setw(20) << "测试项目" 
         << left << setw(15) << "结果" 
         << right << setw(15) << "耗时(ms)" << endl;
    cout << "----------------------------------------------------------------------" << endl;
    cout.flush();
    
    auto total_start = high_resolution_clock::now();
    
    try {
        // 测试1
        auto start = high_resolution_clock::now();
        long long result1 = test1_fibonacci_recursive();
        auto end = high_resolution_clock::now();
        cout << left << setw(20) << "斐波那契(递归)" 
             << left << setw(15) << result1 
             << right << setw(15) << fixed << setprecision(2) 
             << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试2
        start = high_resolution_clock::now();
        long long result2 = test2_fibonacci_iterative();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "斐波那契(迭代)" 
             << left << setw(15) << result2 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试3
        start = high_resolution_clock::now();
        int result3 = test3_prime_sieve();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "质数筛选" 
             << left << setw(15) << result3 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试4
        start = high_resolution_clock::now();
        int result4 = test4_sorting();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "快速排序" 
             << left << setw(15) << result4 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试5
        start = high_resolution_clock::now();
        int result5 = test5_string_concat();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "字符串拼接" 
             << left << setw(15) << result5 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试6
        start = high_resolution_clock::now();
        int result6 = test6_hash_table();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "哈希表操作" 
             << left << setw(15) << result6 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试7
        start = high_resolution_clock::now();
        int result7 = test7_file_io();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "文件I/O" 
             << left << setw(15) << result7 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试8
        start = high_resolution_clock::now();
        int result8 = test8_memory_allocation();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "内存分配" 
             << left << setw(15) << result8 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试9
        start = high_resolution_clock::now();
        int result9 = test9_matrix_multiplication();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "矩阵乘法" 
             << left << setw(15) << result9 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
        // 测试10
        start = high_resolution_clock::now();
        int result10 = test10_string_processing();
        end = high_resolution_clock::now();
        cout << left << setw(20) << "字符串处理" 
             << left << setw(15) << result10 
             << right << setw(15) << duration<double, milli>(end - start).count() << endl;
        cout.flush();
        
    } catch (const exception& e) {
        cerr << "\n错误: " << e.what() << endl;
        return 1;
    }
    
    auto total_end = high_resolution_clock::now();
    
    cout << "----------------------------------------------------------------------" << endl;
    cout << left << setw(20) << "总耗时" 
         << left << setw(15) << "" 
         << right << setw(15) << duration<double, milli>(total_end - total_start).count() << endl;
    cout << "======================================================================" << endl;
    cout.flush();
    
    return 0;
}
