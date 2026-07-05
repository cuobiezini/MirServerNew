$utf8 = 0
$gbk = 0
$utf8List = @()
Get-ChildItem -Path "D:\MirServerNew\Mir200" -Recurse -File -Include *.txt | ForEach-Object {
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $utf8++
        $utf8List += $_.FullName
    } else {
        $gbk++
    }
}
Write-Host ""
Write-Host "========================================"
Write-Host "  编码统计结果"
Write-Host "========================================"
Write-Host ""
Write-Host " UTF8-BOM 文件: $utf8 个" -ForegroundColor Yellow
Write-Host " GBK/ASCII 文件: $gbk 个" -ForegroundColor Green
Write-Host ""
Write-Host "========================================"
Write-Host "  UTF8-BOM 文件列表" -ForegroundColor Yellow
Write-Host "========================================"
$utf8List | ForEach-Object { Write-Host $_ }
Write-Host ""
Write-Host "如果需要将 UTF8-BOM 转换为 GBK，请告诉我" -ForegroundColor Cyan
pause
