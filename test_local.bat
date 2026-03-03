@echo off
chcp 65001 >nul
title LSS博客 - 本地测试

echo.
echo ========================================
echo 🎉 LSS博客 - 本地测试脚本
echo ========================================
echo.

echo 📋 检查环境...
echo.

:: 检查Node.js
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Node.js 未安装，请先安装 Node.js
    pause
    exit /b 1
)
echo ✅ Node.js 已安装: 
node --version

:: 检查npm
npm --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ npm 不可用
    pause
    exit /b 1
)
echo ✅ npm 已安装:
npm --version

:: 检查Hexo
npx hexo --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Hexo CLI 未安装，正在安装...
    npm install -g hexo-cli
)
echo ✅ Hexo CLI 已就绪

echo.
echo 📁 检查项目文件...
echo.

:: 检查关键文件
if exist "_config.yml" (
    echo ✅ 找到 Hexo 配置文件
) else (
    echo ❌ 未找到 _config.yml
    pause
    exit /b 1
)

if exist "package.json" (
    echo ✅ 找到 package.json
) else (
    echo ❌ 未找到 package.json
    pause
    exit /b 1
)

if exist "source" (
    echo ✅ 找到 source 目录
) else (
    echo ❌ 未找到 source 目录
    pause
    exit /b 1
)

echo.
echo 🔧 安装依赖...
call npm install
if %errorlevel% neq 0 (
    echo ❌ 依赖安装失败
    pause
    exit /b 1
)
echo ✅ 依赖安装完成

echo.
echo 🧹 清理旧文件...
call npx hexo clean
echo ✅ 清理完成

echo.
echo 🏗️ 生成静态文件...
call npx hexo generate
if %errorlevel% neq 0 (
    echo ❌ 生成失败
    pause
    exit /b 1
)
echo ✅ 静态文件生成完成

echo.
echo 🌐 启动本地服务器...
echo.
echo 📍 访问地址: http://localhost:4000
echo 📍 访问地址: http://127.0.0.1:4000
echo.
echo 💡 按 Ctrl+C 停止服务器
echo.

call npx hexo server

echo.
echo 🎯 本地测试完成！
pause