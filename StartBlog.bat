@echo off
chcp 65001 >nul
title LSS Blog - Quick Start

echo =====================================
echo      LSS Blog - Quick Start
echo =====================================
echo.

cd /d "%~dp0"

:: Stop existing processes
echo Stopping existing Hexo processes...
for /f "tokens=2" %%i in ('tasklist /fi "imagename eq node.exe" /fo table /nh ^| findstr "node.exe"') do (
    taskkill /f /pid %%i >nul 2>&1
)

:: Find available port
echo Finding available port...
set PORT=4000
:check_port
netstat -an | findstr ":%PORT%" >nul
if not errorlevel 1 (
    set /a PORT+=1
    if %PORT% gtr 4010 (
        echo No available ports found
        pause
        exit /b 1
    )
    goto check_port
)
echo Found available port: %PORT%

:: Check dependencies
echo Checking dependencies...
if not exist "node_modules" (
    echo Installing dependencies...
    npm install
)

:: Generate static files
echo Generating static files...
hexo generate

:: Start server
echo Starting server...
echo.
echo =====================================
echo Blog URL: http://localhost:%PORT%
echo Live reload: Enabled
echo Mobile: Same URL
echo =====================================
echo.
echo Opening browser...
start http://localhost:%PORT%

:: Start Hexo server
start /b hexo server --port %PORT%

echo Server started successfully! Press any key to stop...
pause >nul

:: Stop server
echo Stopping server...
for /f "tokens=2" %%i in ('tasklist /fi "imagename eq node.exe" /fo table /nh ^| findstr "node.exe"') do (
    taskkill /f /pid %%i >nul 2>&1
)

echo.
echo Thank you for using LSS Blog!
pause