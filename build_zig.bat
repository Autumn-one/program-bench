@echo off
echo Building Zig benchmark...
zig build-exe benchmark_zig.zig -O ReleaseFast
if %errorlevel% equ 0 (
    echo Build successful! Executable: benchmark_zig.exe
) else (
    echo Build failed!
)
pause
