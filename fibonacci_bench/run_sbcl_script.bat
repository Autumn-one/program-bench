@echo off
echo Running SBCL fibonacci benchmark in script mode...
echo (This is slower than compiled executable)
echo.

sbcl --script fib_sbcl.lisp

pause
