function Out-WeatherPage {
    param (
        [datetime]$Date,
        [System.Tuple[double, double]]$GeoPosition,
        [string]$OutDirectory
    )
    $outFile = Join-Path $OutDirectory "$($Date.ToString('yyyy-MM-dd')).html"
    Invoke-WebRequest "https://darksky.net/details/$($GeoPosition.Item1),$($GeoPosition.Item2)/$($Date.ToString('yyyy-MM-dd'))/si12/zh" -OutFile $outFile
}
# 起始时间
[datetime]$startDate = [datetime]::new(2021, 1, 1);
# 地理位置 (经度, 纬度)
[System.Tuple[double, double]]$geo = [System.Tuple[double, double]]::new(32.0412, 118.7891)
for ($i = 0; $i -lt 365; $i++) {
    Out-WeatherPage -Date $startDate -GeoPosition $geo -OutDirectory "out";
    $startDate = $startDate.AddDays(1);
}