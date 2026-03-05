@echo off
echo Compiling Racket fibonacci benchmark to executable...
echo.

raco exe fib_racket.rkt

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Compilation successful!
    echo Running the benchmark...
    echo.
    fib_racket.exe
) else (
    echo.
    echo Compilation failed!
    echo Make sure Racket is installed and in your PATH
)

pause
