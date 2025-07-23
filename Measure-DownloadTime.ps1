param(
    [Parameter(Mandatory=$false)]
    [string[]]$Urls = @(
        "https://sample-videos.com/img/Sample-jpg-image-20mb.jpg",
        "https://photoruction.com/speed-test/Sample-jpg-image-20mb.jpg",
        "https://github.com/kentaro-sumi-photoruction/image-test/blob/main/Sample-jpg-image-20mb.jpg?raw=true",
        "https://drive.usercontent.google.com/u/0/uc?id=1xdQxZZtAPPIUhNfaMMXj1F-E4NcchRYY&export=download",
        "https://svs.gsfc.nasa.gov/vis/a030000/a030800/a030877/frames/5760x3240_16x9_01p/BlackMarble_2016_928m_asia_east_labeled.png",
        "https://photoruction.com/speed-test/BlackMarble_2016_928m_asia_east_labeled.png",
        "https://github.com/kentaro-sumi-photoruction/image-test/blob/main/BlackMarble_2016_928m_asia_east_labeled.png?raw=true",
        "https://drive.usercontent.google.com/download?id=1x-302oYmM6vp6vIKkwqYd4lYWU9RjMV6&export=download"
    )
)

$curlPath = (Get-Command curl.exe -ErrorAction Stop).Source

foreach ($url in $Urls) {
    Write-Host "=== Measuring: $url ===" -ForegroundColor Cyan

    [double]$totalSum = 0

    for ($i = 1; $i -le 10; $i++) {
        # 合計時間のみ取得
        $timeStr = & $curlPath @(
            '--silent',
            '--location',
            '--output','NUL:',
            '--write-out','%{time_total}',
            '--request','GET',
            $url
        )
        # 文字列を double に変換して累積
        [double]$totalSum += [double]$timeStr
    }

    $average = $totalSum / 10

    Write-Host ("Average Total Time (10 runs): {0:N3} s" -f $average) -ForegroundColor Green
    Write-Host ("-" * 40)
}
