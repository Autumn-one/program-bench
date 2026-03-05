@echo off
echo Compiling V fibonacci benchmark with maximum optimization...
echo.

REM 极致优化编译
v -prod -cc gcc -cflags "-O3 -march=native" fib_v.v

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Compilation successful!
    echo Running the benchmark...
    echo.
    fib_v.exe
) else (
    echo.
    echo Compilation failed!
    echo Make sure V and GCC are installed and in your PATH
)

pause
