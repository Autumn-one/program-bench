#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <stdbool.h>

#ifdef _WIN32
#include <windows.h>
#endif

// 计时函数
double get_time_ms(clock_t start, clock_t end) {
    return ((double)(end - start)) / CLOCKS_PER_SEC * 1000.0;
}

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
    bool *is_prime = (bool*)malloc((limit + 1) * sizeof(bool));
    
    // 使用memset更高效
    memset(is_prime, 1, (limit + 1) * sizeof(bool));
    is_prime[0] = is_prime[1] = false;
    
    for (int i = 2; i * i <= limit; i++) {
        if (is_prime[i]) {
            for (int j = i * i; j <= limit; j += i) {
                is_prime[j] = false;
            }
        }
    }
    
    int count = 0;
    for (int i = 0; i <= limit; i++) {
        if (is_prime[i]) count++;
    }
    
    free(is_prime);
    return count;
}

// 比较函数用于qsort
int compare_int(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

// 测试4：快速排序
int test4_sorting() {
    srand(42);
    int size = 2000000;
    int *arr = (int*)malloc(size * sizeof(int));
    
    for (int i = 0; i < size; i++) {
        arr[i] = rand() % 1000001;
    }
    
    qsort(arr, size, sizeof(int), compare_int);
    int result = arr[0];
    
    free(arr);
    return result;
}

// 测试5：字符串拼接
int test5_string_concat() {
    int count = 20000000;
    char *str = (char*)malloc(count + 1);
    
    for (int i = 0; i < count; i++) {
        str[i] = 'a';
    }
    str[count] = '\0';
    
    // 使用str的内容，防止编译器优化掉整个操作
    int len = strlen(str);
    free(str);
    return len;
}

// 测试6：哈希表操作（简化版，使用数组模拟）
int test6_hash_table() {
    int size = 1000000;
    int *hash_map = (int*)calloc(size, sizeof(int));
    
    // 插入
    for (int i = 0; i < size; i++) {
        hash_map[i] = i;
    }
    
    // 查询
    srand(42);
    int found_count = 0;
    for (int i = 0; i < size; i++) {
        int key = rand() % 1000001;
        if (key < size && hash_map[key] >= 0) {
            found_count++;
        }
    }
    
    free(hash_map);
    return found_count;
}

// 测试7：文件I/O
int test7_file_io() {
    const char *filename = "test_file_c.txt";
    int line_count = 2000000;
    
    // 写入 - 使用更大的缓冲区
    FILE *f = fopen(filename, "w");
    // 设置更大的缓冲区 (1MB)
    char *write_buffer = (char*)malloc(1024 * 1024);
    setvbuf(f, write_buffer, _IOFBF, 1024 * 1024);
    
    for (int i = 0; i < line_count; i++) {
        fprintf(f, "Line %d: This is a test line.\n", i);
    }
    fclose(f);
    free(write_buffer);
    
    // 读取 - 使用更大的缓冲区
    f = fopen(filename, "r");
    char *read_buffer = (char*)malloc(1024 * 1024);
    setvbuf(f, read_buffer, _IOFBF, 1024 * 1024);
    
    int count = 0;
    char line_buffer[256];
    while (fgets(line_buffer, sizeof(line_buffer), f) != NULL) {
        count++;
    }
    fclose(f);
    free(read_buffer);
    
    // 清理
    remove(filename);
    
    return count;
}

// 测试8：内存分配与访问
typedef struct {
    int id;
    int value;
    char name[32];
} DataObject;

int test8_memory_allocation() {
    int count = 1000000;
    DataObject *data = (DataObject*)malloc(count * sizeof(DataObject));
    
    // 创建对象
    for (int i = 0; i < count; i++) {
        data[i].id = i;
        data[i].value = i * 2;
        sprintf(data[i].name, "item_%d", i);
    }
    
    // 随机访问
    srand(42);
    long long total = 0;
    for (int i = 0; i < count; i++) {
        int idx = rand() % count;
        total += data[idx].value;
    }
    
    int result = (int)(total % 1000000);
    free(data);
    return result;
}

// 测试9：矩阵乘法
int test9_matrix_multiplication() {
    int size = 400;
    
    // 使用一维数组模拟二维矩阵，提高缓存命中率
    double *A = (double*)malloc(size * size * sizeof(double));
    double *B = (double*)malloc(size * size * sizeof(double));
    double *C = (double*)calloc(size * size, sizeof(double));
    
    // 初始化
    srand(42);
    for (int i = 0; i < size * size; i++) {
        A[i] = (double)rand() / RAND_MAX;
        B[i] = (double)rand() / RAND_MAX;
    }
    
    // 矩阵乘法
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            double sum = 0.0;
            for (int k = 0; k < size; k++) {
                sum += A[i * size + k] * B[k * size + j];
            }
            C[i * size + j] = sum;
        }
    }
    
    int result = (int)(C[0] * 1000);
    
    // 释放内存
    free(A);
    free(B);
    free(C);
    
    return result;
}

// 测试10：字符串处理
int test10_string_processing() {
    // 创建长文本
    const char *base = "The quick brown fox jumps over the lazy dog. ";
    int repeat = 1500000;
    size_t base_len = strlen(base);
    size_t total_len = base_len * repeat;
    
    char *text = (char*)malloc(total_len + 1);
    if (text == NULL) {
        printf("内存分配失败\n");
        return -1;
    }
    
    // 拼接字符串
    for (int i = 0; i < repeat; i++) {
        memcpy(text + i * base_len, base, base_len);
    }
    text[total_len] = '\0';
    
    // 查找 "the" 出现次数
    int count = 0;
    char *pos = text;
    while ((pos = strstr(pos, "the")) != NULL) {
        count++;
        pos += 3;  // 跳过已找到的 "the"
    }
    
    // 替换 "fox" 为 "cat" (原地替换，因为长度相同)
    pos = text;
    while ((pos = strstr(pos, "fox")) != NULL) {
        memcpy(pos, "cat", 3);
        pos += 3;
    }
    
    // 分割：统计单词数
    int word_count = 0;
    bool in_word = false;
    
    for (size_t i = 0; i < total_len; i++) {
        if (text[i] == ' ' || text[i] == '\n' || text[i] == '\t') {
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
    
    free(text);
    return word_count;
}

int main() {
    // 设置Windows控制台为UTF-8编码
    #ifdef _WIN32
    SetConsoleOutputCP(65001);  // 65001 是 UTF-8 的代码页
    #endif
    
    // 获取C版本
    printf("======================================================================\n");
    printf("C (GCC) 性能测试\n");
    printf("======================================================================\n\n");
    
    printf("%-20s %-15s %15s\n", "测试项目", "结果", "耗时(ms)");
    printf("----------------------------------------------------------------------\n");
    
    clock_t total_start = clock();
    
    // 测试1
    clock_t start = clock();
    long long result1 = test1_fibonacci_recursive();
    clock_t end = clock();
    printf("%-20s %-15lld %15.2f\n", "斐波那契(递归)", result1, get_time_ms(start, end));
    
    // 测试2
    start = clock();
    long long result2 = test2_fibonacci_iterative();
    end = clock();
    printf("%-20s %-15lld %15.2f\n", "斐波那契(迭代)", result2, get_time_ms(start, end));
    
    // 测试3
    start = clock();
    int result3 = test3_prime_sieve();
    end = clock();
    printf("%-20s %-15d %15.2f\n", "质数筛选", result3, get_time_ms(start, end));
    
    // 测试4
    start = clock();
    int result4 = test4_sorting();
    end = clock();
    printf("%-20s %-15d %15.2f\n", "快速排序", result4, get_time_ms(start, end));
    
    // 测试5
    start = clock();
    int result5 = test5_string_concat();
    end = clock();
    printf("%-20s %-15d %15.2f\n", "字符串拼接", result5, get_time_ms(start, end));
    
    // 测试6
    start = clock();
    int result6 = test6_hash_table();
    end = clock();
    printf("%-20s %-15d %15.2f\n", "哈希表操作", result6, get_time_ms(start, end));
    
    // 测试7
    start = clock();
    int result7 = test7_file_io();
    end = clock();
    printf("%-20s %-15d %15.2f\n", "文件I/O", result7, get_time_ms(start, end));
    
    // 测试8
    start = clock();
    int result8 = test8_memory_allocation();
    end = clock();
    printf("%-20s %-15d %15.2f\n", "内存分配", result8, get_time_ms(start, end));
    
    // 测试9
    start = clock();
    int result9 = test9_matrix_multiplication();
    end = clock();
    printf("%-20s %-15d %15.2f\n", "矩阵乘法", result9, get_time_ms(start, end));
    
    // 测试10
    start = clock();
    int result10 = test10_string_processing();
    end = clock();
    printf("%-20s %-15d %15.2f\n", "字符串处理", result10, get_time_ms(start, end));
    
    clock_t total_end = clock();
    
    printf("----------------------------------------------------------------------\n");
    printf("%-20s %-15s %15.2f\n", "总耗时", "", get_time_ms(total_start, total_end));
    printf("======================================================================\n");
    
    return 0;
}
