$utf8List = @()
Get-ChildItem -Path "D:\MirServerNew\Mir200" -Recurse -File -Include *.txt | ForEach-Object {
    $bytes = [System.IO.File]::ReadAllBytes($_.FullName)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $utf8List += $_.FullName
    }
}
$utf8List | Out-File -FilePath "D:\MirServerNew\UTF8-BOM文件列表.txt" -Encoding UTF8
Write-Host "已生成文件列表: D:\MirServerNew\UTF8-BOM文件列表.txt"
Write-Host "共计 $($utf8List.Count) 个 UTF8-BOM 文件"
pause
