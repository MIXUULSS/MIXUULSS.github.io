@echo off
chcp 65001 >nul
title LSS Blog - 优化版快速启动

echo =====================================
echo      LSS Blog - 优化版快速启动
echo =====================================
echo.

cd /d "%~dp0"

echo 正在清理缓存...
if exist "public" rmdir /s /q public
if exist ".deploy" rmdir /s /q .deploy

echo 正在生成静态文件...
npx hexo generate

echo.
echo 正在启动本地服务器...
echo 服务器地址: http://localhost:4000
echo 按 Ctrl+C 停止服务器
echo.

npx hexo server --port 4000

pause