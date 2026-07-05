$utf8List = @()
$gbkList = @()
$total = 0

Get-ChildItem -Path "D:\MirServerNew" -Recurse -File -Include *.txt,*.lua,*.cfg,*.ini,*.dat | ForEach-Object {
    $total++
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $utf8List += $_.FullName
    } else {
        $gbkList += $_.FullName
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  编码统计结果 (D:\MirServerNew)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host " 总文件数: $total" -ForegroundColor White
Write-Host " UTF8-BOM: $($utf8List.Count)" -ForegroundColor Yellow
Write-Host " GBK/其他: $($gbkList.Count)" -ForegroundColor Green
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  UTF8-BOM 文件列表 ($($utf8List.Count)个)" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
$utf8List | Sort-Object | ForEach-Object { Write-Host $_ }

$utf8List | Out-File -FilePath "D:\MirServerNew\UTF8-BOM文件列表_全目录.txt" -Encoding UTF8
Write-Host ""
Write-Host "已保存到: D:\MirServerNew\UTF8-BOM文件列表_全目录.txt" -ForegroundColor Cyan
pause
