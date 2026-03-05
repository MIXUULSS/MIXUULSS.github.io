@echo off
chcp 65001 >nul
title 🔧 LSS博客 - DNS修复指南

echo.
echo ========================================
echo 🔧 LSS博客 - DNS配置修复指南
echo ========================================
echo.

echo ❌ 当前问题诊断:
echo   • 域名 lssblog.dpdns.org 无法解析
echo   • 没有A/AAAA DNS记录
echo   • Cloudflare配置缺失
echo.

echo ✅ 解决方案:
echo   1. 登录 Cloudflare (cloudflare.com)
echo   2. 选择域名: dpdns.org
echo   3. 添加以下DNS记录:
echo.

echo ┌─────────────────────────────────────┐
echo │ 推荐方案: CNAME记录                │
echo │ 类型: CNAME                         │
echo │ 名称: lssblog                       │
echo │ 目标: mixuulss.github.io           │
echo │ 代理: 仅DNS (灰色云朵)              │
echo └─────────────────────────────────────┘
echo.

echo ┌─────────────────────────────────────┐
echo │ 备选方案: A记录                    │
echo │ 类型: A                             │
echo │ 名称: lssblog                       │
echo │ 目标1: 185.199.108.153            │
echo │ 目标2: 185.199.109.153            │
echo │ 目标3: 185.199.110.153            │
echo │ 目标4: 185.199.111.153            │
echo │ 代理: 仅DNS (灰色云朵)              │
echo └─────────────────────────────────────┘
echo.

echo 📋 GitHub Pages IP地址说明:
echo   • 这些是GitHub Pages的官方IP
echo   • 使用A记录需要全部4个IP
echo   • CNAME记录更简单直接
echo.

echo 🔄 验证步骤:
echo   1. 配置完成后等待5-30分钟
echo   2. 运行: nslookup lssblog.dpdns.org
echo   3. 运行: ping lssblog.dpdns.org
echo   4. 访问: https://lssblog.dpdns.org
echo.

echo ⚠️  重要提醒:
echo   • 必须关闭Cloudflare代理(灰色云朵)
echo   • 不要启用橙色云朵(代理模式)
echo   • HTTPS证书由GitHub Pages提供
echo   • DNS生效可能需要几分钟到几小时
echo.

echo 🎯 临时解决方案:
echo   如果域名配置困难，可以使用:
echo   • GitHub原生: https://mixuulss.github.io
echo   • 部署到Vercel获得更好体验
echo.

echo ========================================
echo 📞 如需帮助:
echo   • GitHub Pages文档: bit.ly/github-pages
echo   • Cloudflare支持: dash.cloudflare.com
echo ========================================
echo.

echo 💡 配置完成后，按任意键检查DNS状态...
pause >nul

echo.
echo 🔄 正在检查DNS解析状态...
echo.

nslookup lssblog.dpdns.org >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ DNS解析成功!
    echo 🌐 域名 lssblog.dpdns.org 已正确配置
    echo 📍 可以尝试访问: https://lssblog.dpdns.org
) else (
    echo ❌ DNS解析失败
    echo 🔧 请检查Cloudflare配置
    echo 📋 确认已添加正确的DNS记录
    echo ⏳ DNS更改可能需要时间生效
)

echo.
echo 📊 当前网络测试:
echo.

echo 📍 检查GitHub原生地址...
curl -s -o nul -w "状态码: %%{http_code}\n" https://mixuulss.github.io 2>nul
if %errorlevel% equ 0 (
    echo ✅ GitHub Pages正常
) else (
    echo ❌ GitHub Pages异常
)

echo.
echo 🎯 完成DNS配置后，你的精美博客将可通过以下地址访问:
echo   🌟 https://lssblog.dpdns.org
echo   🌟 http://lssblog.dpdns.org
echo.

pause