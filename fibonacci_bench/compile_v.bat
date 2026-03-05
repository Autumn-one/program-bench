@echo off
echo Compiling V fibonacci benchmark...
echo.

REM 基本生产模式编译
v -prod fib_v.v

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Compilation successful!
    echo Running the benchmark...
    echo.
    fib_v.exe
) else (
    echo.
    echo Compilation failed!
    echo Make sure V is installed and in your PATH
)

pause
