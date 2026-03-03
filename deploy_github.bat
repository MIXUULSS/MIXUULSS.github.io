@echo off
chcp 65001 >nul
title GitHub Pages 部署

echo.
echo ========================================
echo 🚀 GitHub Pages 一键部署
echo ========================================
echo.

echo 📋 生成静态文件...
call npx hexo clean
call npx hexo generate

echo.
echo 📤 推送到gh-pages分支...
call git subtree push --prefix public origin gh-pages

echo.
echo ✅ 部署完成！
echo.
echo 🔧 重要提示：
echo 1. 访问 https://github.com/MIXUULSS/MIXUULSS.github.io/settings/pages
echo 2. 确保Source选择"Deploy from a branch"
echo 3. Branch选择"gh-pages"，Folder选择"/(root)"
echo 4. 点击Save保存设置
echo.
echo 🌐 网站地址: https://MIXUULSS.github.io
echo ⏱️ 等待2-5分钟让GitHub Pages生效
echo.

pause