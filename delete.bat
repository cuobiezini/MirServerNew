@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
echo ==========================================
echo  正在删除当前目录下的 DLL 和 EXE 文件
echo ==========================================
echo.

cd /d %cd%

set dllCount=0
set exeCount=0

echo [1/2] 正在删除 DLL 文件...
echo ----------------------------------------
for /r %%i in (*.dll) do (
    echo   删除: %%i
    del /f /q "%%i"
    set /a dllCount+=1
)

echo.
echo [2/2] 正在删除 EXE 文件...
echo ----------------------------------------
for /r %%i in (*.exe) do (
    echo   删除: %%i
    del /f /q "%%i"
    set /a exeCount+=1
)

echo.
echo ==========================================
echo  删除完成！
echo ==========================================
echo.
echo  DLL 文件: !dllCount! 个
echo  EXE 文件: !exeCount! 个
echo.
pause
