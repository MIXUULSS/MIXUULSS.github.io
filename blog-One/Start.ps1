# 博客快速启动 - 简化版
Write-Host "LSS博客 - 快速启动" -ForegroundColor Green

$BlogDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $BlogDir

# 停止现有进程
Get-Process node -ErrorAction SilentlyContinue | Where-Object {$_.CommandLine -like "*hexo*"} | Stop-Process -Force

# 查找端口
$port = 4000
while ($port -le 4010) {
    $connection = New-Object System.Net.Sockets.TcpClient
    try {
        $connection.Connect("localhost", $port)
        $connection.Close()
        $port++
    } catch {
        break
    }
}

Write-Host "使用端口: $port" -ForegroundColor Yellow

# 检查依赖
if (!(Test-Path "node_modules")) {
    Write-Host "安装依赖..." -ForegroundColor Yellow
    npm install
}

# 生成和启动
Write-Host "启动服务器..." -ForegroundColor Yellow
Start-Job -ScriptBlock { param($dir, $p) Set-Location $dir; hexo server --port $p } -ArgumentList $BlogDir, $port

Start-Sleep -Seconds 3
Write-Host "博客地址: http://localhost:$port" -ForegroundColor Green
Start-Process "http://localhost:$port"

Write-Host "按回车键停止服务器..." -ForegroundColor Cyan
Read-Host

Stop-Job -Name * -Force