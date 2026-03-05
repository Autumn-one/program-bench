fib(n) {
    if (n <= 1)
        return n
    return fib(n - 1) + fib(n - 2)
}

start := A_TickCount
result := fib(41)
elapsed_ms := A_TickCount - start

MsgBox("Result: " . result . "`nAutoHotkey v2: " . elapsed_ms . " ms")
