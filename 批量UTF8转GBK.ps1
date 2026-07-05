Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  UTF8-BOM 转 GBK 批量转换工具" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$success = 0
$fail = 0
$failList = @()

Get-ChildItem -Path "D:\MirServerNew" -Recurse -File -Include *.txt,*.lua,*.cfg,*.ini,*.dat | ForEach-Object {
    $file = $_.FullName
    $bytes = [System.IO.File]::ReadAllBytes($file)

    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        try {
            $content = [System.Text.Encoding]::UTF8.GetString($bytes, 3, $bytes.Length - 3)
            $gbkBytes = [System.Text.Encoding]::GetEncoding("GBK").GetBytes($content)
            [System.IO.File]::WriteAllBytes($file, $gbkBytes)
            $success++
            Write-Host "[$success] 转换: $file" -ForegroundColor Green
        } catch {
            $fail++
            $failList += $file
            Write-Host "[失败] $file" -ForegroundColor Red
        }
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  转换完成" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  成功: $success 个" -ForegroundColor Green
Write-Host "  失败: $fail 个" -ForegroundColor Red
Write-Host ""

if ($fail -gt 0) {
    Write-Host "  失败文件列表:" -ForegroundColor Yellow
    $failList | ForEach-Object { Write-Host "    $_" }
}

Write-Host ""
pause
