@echo off
chcp 65001 >nul
title 🔍 LSS博客 - 域名部署检查

echo.
echo ========================================
echo 🔍 LSS博客域名部署状态检查
echo ========================================
echo.

echo 📋 检查项目状态...
echo.

:: 检查关键文件
if exist "index.html" (
    echo ✅ index.html 存在
    :: 检查文件大小
    for %%A in (index.html) do echo    📏 文件大小: %%~zA 字节
) else (
    echo ❌ index.html 不存在
    goto :error
)

if exist "CNAME" (
    echo ✅ CNAME 文件存在
    set /p domain=<CNAME
    echo    🌐 配置域名: %domain%
) else (
    echo ❌ CNAME 文件不存在
)

if exist "vercel.json" (
    echo ✅ Vercel 配置文件存在
) else (
    echo ⚠️  Vercel 配置文件不存在
)

echo.
echo 🌐 检查网络连接...
echo.

:: 检查GitHub原生地址
echo 📍 检查 GitHub Pages...
curl -s -o nul -w "状态码: %%{http_code}\n" https://mixuulss.github.io 2>nul
if %errorlevel% equ 0 (
    echo ✅ GitHub Pages 可访问
) else (
    echo ❌ GitHub Pages 暂时不可访问
)

:: 检查自定义域名
echo 📍 检查自定义域名...
curl -s -o nul -w "状态码: %%{http_code}\n" https://lssblog.dpdns.org 2>nul
if %errorlevel% equ 0 (
    echo ✅ 自定义域名可访问
) else (
    echo ❌ 自定义域名暂时不可访问
)

echo.
echo 📊 DNS解析信息...
echo.

:: 检查DNS解析
nslookup lssblog.dpdns.org >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ DNS解析成功
) else (
    echo ❌ DNS解析失败或未生效
)

echo.
echo 🔄 Git状态检查...
echo.

cd /d "%~dp0"
git status --short >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Git仓库正常
    git log --oneline -1
) else (
    echo ❌ Git仓库状态异常
)

echo.
echo ========================================
echo 📋 域名配置说明
echo ========================================
echo.
echo 1. GitHub原生地址:
echo    https://mixuulss.github.io
echo.
echo 2. 自定义域名:
echo    https://lssblog.dpdns.org
echo.
echo 3. 如果自定义域名不可访问:
echo    - 等待DNS解析生效(通常5分钟-24小时)
echo    - 检查Cloudflare DNS设置
echo    - 确认CNAME指向: mixuulss.github.io
echo.
echo 4. Vercel部署(推荐):
echo    - 访问 vercel.com
echo    - 导入GitHub仓库: MIXUULSS/MIXUULSS.github.io
echo    - 在Vercel设置中添加自定义域名
echo.
echo ========================================

goto :end

:error
echo.
echo ❌ 检查失败，请查看错误信息
echo.

:end
echo.
echo 💡 按任意键退出...
pause >nul