@echo off
chcp 65001 >nul
title 简单部署脚本

echo.
echo ========================================
echo 🚀 LSS博客 - 简单部署脚本  
echo ========================================
echo.

echo 🧹 清理和生成...
call npx hexo clean
call npx hexo generate
echo ✅ 生成完成

echo.
echo 📤 添加到Git...
call git add .
call git commit -m "Deploy: 更新博客内容 - %date% %time%"
call git push origin main
echo ✅ 推送完成

echo.
echo 🎯 部署完成！
echo 📍 网站地址: https://MIXUULSS.github.io
echo 📋 请等待2-5分钟让GitHub Pages更新
echo.

pause