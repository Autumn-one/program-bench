@echo off
echo Compiling SBCL fibonacci benchmark to executable...
echo.

sbcl --load fib_sbcl.lisp --eval "(sb-ext:save-lisp-and-die \"fib_sbcl.exe\" :toplevel #'main :executable t)"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Compilation successful!
    echo Running the benchmark...
    echo.
    fib_sbcl.exe
) else (
    echo.
    echo Compilation failed!
    echo Make sure SBCL is installed and in your PATH
)

pause
