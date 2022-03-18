# 收集 out 文件夹中的数据
$weatherList = [System.Collections.Generic.List[System.Object]]::new()
$files = Get-ChildItem "out"
$files | ForEach-Object {
    $weatherList.AddRange(("{" + [string]::join("",(Get-Content $_.fullname)[333..346]).replace("=", ":").remove(0, 5).trim(";") + “}” |ConvertFrom-Json).hours)
}
# '2021-nanjing.csv' 改成你想输出的 CSV 文件
# Excel 时间戳转时间：=(A1 + 8 * 3600) / (24 * 3600) + DATE(1970, 1, 1)
$weatherList | Select-Object -ExcludeProperty solar | Export-Csv '2021-nanjing.csv' -NoTypeInformation