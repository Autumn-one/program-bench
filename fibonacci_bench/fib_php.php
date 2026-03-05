<?php

function fib($n) {
    if ($n <= 1) return $n;
    return fib($n - 1) + fib($n - 2);
}

$start = microtime(true);
$result = fib(41);
$elapsed_ms = (microtime(true) - $start) * 1000;

echo "Result: $result\n";
echo "PHP: " . number_format($elapsed_ms, 2) . " ms\n";
