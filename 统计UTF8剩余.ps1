$utf8 = 0
$gbk = 0
$utf8List = @()

Get-ChildItem -Path "D:\MirServerNew" -Recurse -File -Include *.txt,*.lua,*.cfg,*.ini,*.dat | ForEach-Object {
    $b = [System.IO.File]::ReadAllBytes($_.FullName)
    if ($b.Length -ge 3 -and $b[0] -eq 0xEF -and $b[1] -eq 0xBB -and $b[2] -eq 0xBF) {
        $utf8++
        $utf8List += $_.FullName
    } else {
        $gbk++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  UTF8-BOM 文件统计" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host " UTF8-BOM: $utf8" -ForegroundColor Yellow
Write-Host " GBK/其他: $gbk" -ForegroundColor Green
Write-Host ""

if ($utf8 -gt 0) {
    Write-Host "UTF8-BOM 文件列表:" -ForegroundColor Yellow
    $utf8List | ForEach-Object { Write-Host $_ }
    $utf8List | Out-File -FilePath "D:\MirServerNew\UTF8剩余文件.txt" -Encoding UTF8
    Write-Host ""
    Write-Host "已保存到: D:\MirServerNew\UTF8剩余文件.txt" -ForegroundColor Cyan
} else {
    Write-Host "恭喜！所有文件已转换为 GBK 编码！" -ForegroundColor Green
}
pause
