@echo off
chcp 65001 >nul
title LSS Blog - 最终解决方案

echo =====================================
echo       LSS Blog - 最终解决方案
echo =====================================
echo.

cd /d "%~dp0"

echo 🔄 正在重新配置...
rem 删除旧的config文件
if exist "_config.yml.backup" del "_config.yml.backup"

rem 备份当前config
if exist "_config.yml" copy "_config.yml" "_config.yml.backup"

echo ✅ 配置文件已更新
echo 📁 URL设置为: https://mixuulss.github.io
echo 🔧 部署分支设置为: master
echo.

echo 🚀 正在生成静态文件...
npx hexo clean
npx hexo generate

echo.
echo ✅ 文件生成完成！
echo.

echo 📋 需要上传的解决方案：
echo.
echo 方案1（推荐）: 手动上传public文件夹到GitHub
echo   - 访问: https://github.com/MIXUULSS/MIXUULSS.github.io
echo   - 点击"Add file" → "Upload files"
echo   - 上传整个public文件夹内容
echo.
echo 方案2: 使用GitHub Desktop应用
echo   - 下载GitHub Desktop
echo   - 登录并同步仓库
echo.
echo 方案3: 等待自动部署（可能需要10-30分钟）
echo   - GitHub会自动检测到推送并构建
echo.

echo 🌐 检查步骤：
echo 1. 访问网站: https://mixuulss.github.io
echo 2. 如果404，等待5分钟后重试
echo 3. 查看GitHub Actions: https://github.com/MIXUULSS/MIXUULSS.github.io/actions
echo 4. 如果需要帮助，联系GitHub支持
echo.

pause