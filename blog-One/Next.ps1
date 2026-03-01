# 博客快速启动脚本
# 解决所有启动常见问题和坑

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "     LSS博客 - 快速启动工具" -ForegroundColor Yellow
Write-Host "=====================================" -ForegroundColor Cyan

# 获取脚本所在目录
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$BlogDir = $ScriptDir

Write-Host "📂 博客目录: $BlogDir" -ForegroundColor Green

# 检查并停止现有进程
Write-Host "`n🔄 正在检查并停止现有的Hexo进程..." -ForegroundColor Yellow

# 查找所有相关的node进程
$existingProcesses = Get-Process | Where-Object { 
    $_.ProcessName -like "*node*" -and 
    ($_.CommandLine -like "*hexo*" -or $_.MainWindowTitle -like "*localhost*")
}

if ($existingProcesses) {
    Write-Host "⚠️  发现到正在运行的Hexo进程，正在停止..." -ForegroundColor Orange
    foreach ($proc in $existingProcesses) {
        try {
            $proc.Kill() | Out-Null
            Write-Host "   ✓ 已停止进程: $($proc.Id)" -ForegroundColor Green
        } catch {
            Write-Host "   ⚠️  无法停止进程: $($proc.Id)" -ForegroundColor Orange
        }
    }
    # 等待进程完全停止
    Start-Sleep -Seconds 2
} else {
    Write-Host "   ✓ 没有发现正在运行的Hexo进程" -ForegroundColor Green
}

# 检查必要文件
Write-Host "`n🔍 正在检查必要文件..." -ForegroundColor Yellow

$packageJson = Join-Path $BlogDir "package.json"
$configYml = Join-Path $BlogDir "_config.yml"
$configButterfly = Join-Path $BlogDir "_config.butterfly.yml"

if (-not (Test-Path $packageJson)) {
    Write-Host "❌ 错误: 找不到 package.json 文件" -ForegroundColor Red
    Write-Host "   请确保脚本位于正确的博客目录中" -ForegroundColor Red
    pause
    exit 1
}

if (-not (Test-Path $configYml)) {
    Write-Host "❌ 错误: 找不到 _config.yml 文件" -ForegroundColor Red
    pause
    exit 1
}

if (-not (Test-Path $configButterfly)) {
    Write-Host "❌ 错误: 找不到 _config.butterfly.yml 文件" -ForegroundColor Red
    pause
    exit 1
}

Write-Host "   ✓ 所有必要文件检查通过" -ForegroundColor Green

# 检查依赖
Write-Host "`n📦 正在检查依赖..." -ForegroundColor Yellow

$nodeModules = Join-Path $BlogDir "node_modules"
if (-not (Test-Path $nodeModules)) {
    Write-Host "⚠️  node_modules 目录不存在，正在安装依赖..." -ForegroundColor Orange
    Set-Location $BlogDir
    npm install
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ 依赖安装失败！" -ForegroundColor Red
        pause
        exit 1
    }
    Write-Host "   ✓ 依赖安装完成" -ForegroundColor Green
} else {
    Write-Host "   ✓ 依赖检查通过" -ForegroundColor Green
}

# 检查配置文件语法
Write-Host "`n🔧 正在检查配置文件语法..." -ForegroundColor Yellow

try {
    # 简单的YAML语法检查
    $yamlContent = Get-Content $configYml -Raw
    if ($yamlContent -match "^\s*-\s*[^#]" -and $yamlContent -match "^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*:") {
        Write-Host "   ✓ _config.yml 语法检查通过" -ForegroundColor Green
    }
    
    $butterflyContent = Get-Content $configButterfly -Raw
    if ($butterflyContent -match "^\s*-\s*[^#]" -and $butterflyContent -match "^\s*[a-zA-Z_][a-zA-Z0-9_]*\s*:") {
        Write-Host "   ✓ _config.butterfly.yml 语法检查通过" -ForegroundColor Green
    }
} catch {
    Write-Host "   ⚠️  配置文件检查出现问题，但继续启动..." -ForegroundColor Orange
}

# 查找可用端口
Write-Host "`n🔍 正在查找可用端口..." -ForegroundColor Yellow

$ports = @(4000, 4001, 4002, 4003, 4004, 4005, 4006, 4007, 4008, 4009, 4080, 4090)
$availablePort = $null

foreach ($port in $ports) {
    $connection = New-Object System.Net.Sockets.TcpClient
    try {
        $connection.Connect("localhost", $port)
        $connection.Close()
        Write-Host "   ⚠️  端口 $port 被占用" -ForegroundColor Orange
    } catch {
        $availablePort = $port
        break
    }
}

if (-not $availablePort) {
    Write-Host "❌ 无法找到可用端口！" -ForegroundColor Red
    pause
    exit 1
}

Write-Host "   ✓ 找到可用端口: $availablePort" -ForegroundColor Green

# 生成静态文件
Write-Host "`n🏗️  正在生成静态文件..." -ForegroundColor Yellow

Set-Location $BlogDir
$generateResult = & hexo generate 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ 生成静态文件失败！" -ForegroundColor Red
    Write-Host $generateResult -ForegroundColor Red
    pause
    exit 1
}
Write-Host "   ✓ 静态文件生成完成" -ForegroundColor Green

# 启动服务器
Write-Host "`n🚀 正在启动本地服务器..." -ForegroundColor Yellow

$hexoArgs = @(
    "server", 
    "--cwd", $BlogDir, 
    "--port", $availablePort,
    "--debug"
)

try {
    # 在后台启动Hexo服务器
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = "hexo"
    $startInfo.ArgumentList = $hexoArgs
    $startInfo.WorkingDirectory = $BlogDir
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.CreateNoWindow = $true

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $startInfo
    $process.Start() | Out-Null

    # 等待服务器启动
    Start-Sleep -Seconds 3
    
    # 检查服务器是否启动成功
    $serverRunning = $false
    for ($i = 0; $i -lt 10; $i++) {
        $connection = New-Object System.Net.Sockets.TcpClient
        try {
            $connection.Connect("localhost", $availablePort)
            $connection.Close()
            $serverRunning = $true
            break
        } catch {
            Start-Sleep -Seconds 1
        }
    }

    if ($serverRunning) {
        Write-Host "`n🎉 博客启动成功！" -ForegroundColor Green
        Write-Host "=====================================" -ForegroundColor Cyan
        Write-Host "📍 访问地址: http://localhost:$availablePort" -ForegroundColor Yellow
        Write-Host "🔄 实时重载: 已启用" -ForegroundColor Green
        Write-Host "📱 移动端: 访问同一地址" -ForegroundColor Blue
        Write-Host "=====================================" -ForegroundColor Cyan
        
        # 自动打开浏览器
        Write-Host "`n🌐 正在打开浏览器..." -ForegroundColor Yellow
        Start-Process "http://localhost:$availablePort"
        
        Write-Host "`n✅ 启动完成！按任意键停止服务器..." -ForegroundColor Green
        $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        
        # 停止服务器
        try {
            $process.Kill() | Out-Null
            Write-Host "`n🛑 服务器已停止" -ForegroundColor Orange
        } catch {
            Write-Host "`n⚠️  无法正常停止服务器，请手动检查" -ForegroundColor Orange
        }
        
    } else {
        Write-Host "❌ 服务器启动失败！" -ForegroundColor Red
        $errorOutput = $process.StandardError.ReadToEnd()
        Write-Host "错误信息: $errorOutput" -ForegroundColor Red
        pause
    }
    
} catch {
    Write-Host "❌ 启动过程中发生异常！" -ForegroundColor Red
    Write-Host "错误信息: $_" -ForegroundColor Red
    pause
}

Write-Host "`n感谢使用 LSS博客快速启动工具！" -ForegroundColor Cyan
pause