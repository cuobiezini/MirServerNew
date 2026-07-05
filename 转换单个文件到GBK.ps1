$file = "D:\MirServerNew\Mir200\Envir\Market_Def\特殊NPC\修炼宝宝-b136.txt"
$bytes = [System.IO.File]::ReadAllBytes($file)

if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
    Write-Host "当前编码: UTF8-BOM" -ForegroundColor Yellow
    $content = [System.Text.Encoding]::UTF8.GetString($bytes, 3, $bytes.Length - 3)
} else {
    Write-Host "当前编码: GBK/ASCII" -ForegroundColor Green
    $content = [System.Text.Encoding]::GetEncoding("GBK").GetString($bytes)
}

Write-Host ""
Write-Host "========== 转换前内容预览 ==========" -ForegroundColor Cyan
Write-Host $content
Write-Host ""
Write-Host "========== 开始转换为 GBK ==========" -ForegroundColor Cyan

$gbkBytes = [System.Text.Encoding]::GetEncoding("GBK").GetBytes($content)
[System.IO.File]::WriteAllBytes($file, $gbkBytes)

Write-Host ""
Write-Host "转换完成！" -ForegroundColor Green
Write-Host "文件已保存为 GBK 编码: $file" -ForegroundColor Cyan

$newBytes = [System.IO.File]::ReadAllBytes($file)
if ($newBytes[0] -eq 0xEF -and $newBytes[1] -eq 0xBB -and $newBytes[2] -eq 0xBF) {
    Write-Host "验证结果: 仍为 UTF8-BOM (转换失败)" -ForegroundColor Red
} else {
    Write-Host "验证结果: 已转为 GBK 编码 ?" -ForegroundColor Green
}
pause
