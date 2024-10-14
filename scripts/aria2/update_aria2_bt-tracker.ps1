# aria2.conf 文件路径
$confPath = ".\aria2.conf"

# 检查当前目录是否存在 aria2.conf 文件
if (-not (Test-Path -Path $confPath)) {
    Write-Host "当前目录下不存在 aria2.conf 文件,请先从 <https://github.com/P3TERX/aria2.conf> 下载该文件。" -ForegroundColor Red
    exit
}

# 定义 tracker 列表源
$sources = @(
    @{
        Name = "精选列表 (XIU2/TrackersListCollection)"
        Url  = "https://cf.trackerslist.com/best_aria2.txt"
    },
    @{
        Name = "完整列表 (XIU2/TrackersListCollection)"
        Url  = "https://cf.trackerslist.com/all_aria2.txt"
    },
    @{
        Name = "HTTP(S) 列表 (XIU2/TrackersListCollection)"
        Url  = "https://cf.trackerslist.com/http_aria2.txt"
    },
    @{
        Name = "无 HTTP 列表 (XIU2/TrackersListCollection)"
        Url  = "https://cf.trackerslist.com/nohttp_aria2.txt"
    },
    @{
        Name = "trackers_best (ngosang/trackerslist)"
        Url  = "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_best.txt"
    },
    @{
        Name = "trackers_all (ngosang/trackerslist)"
        Url  = "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all.txt"
    },
    @{
        Name = "trackers_all_udp (ngosang/trackerslist)"
        Url  = "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all_udp.txt"
    },
    @{
        Name = "trackers_all_http (ngosang/trackerslist)"
        Url  = "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all_http.txt"
    },
    @{
        Name = "trackers_all_https (ngosang/trackerslist)"
        Url  = "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all_https.txt"
    },
    @{
        Name = "trackers_all_ws (ngosang/trackerslist)"
        Url  = "https://cdn.jsdelivr.net/gh/ngosang/trackerslist@master/trackers_all_ws.txt"
    }
)

# 打印列表供用户选择
Write-Host "请选择要更新 bt-tracker 列表的源:"
Write-Host ""
for ($i = 0; $i -lt $sources.Count; $i++) {
    Write-Host "$i. $($sources[$i].Name) => $($sources[$i].Url)"
}
Write-Host ""

do {
    $choice = Read-Host "请输入编号 [0-$($sources.Count - 1)]"
    if ($choice -notmatch "^\d+$" -or [int]$choice -lt 0 -or [int]$choice -ge $sources.Count) {
        Write-Host "无效的输入,请输入 0 到 $($sources.Count - 1) 之间的数字。" -ForegroundColor Red
    }
} while ($choice -notmatch "^\d+$" -or [int]$choice -lt 0 -or [int]$choice -ge $sources.Count)

# 获取选择的源
$selectedSource = $sources[[int]$choice]

# 下载 tracker 列表
$trackers = Invoke-WebRequest -Uri $selectedSource.Url -UseBasicParsing

# 去除空行并用逗号连接
$trackers = ($trackers.Content.Trim() -split "\n" | Where-Object { $_ -ne "" }) -join ","

# 更新 aria2.conf 文件
$configContent = Get-Content $confPath -Raw

if ($configContent -match "bt-tracker=") {
    $configContent = $configContent -replace "(bt-tracker=).*", "`$1$trackers"
}

$configContent | Set-Content -Path $confPath -Encoding UTF8 -NoNewline

Write-Host "更新 $($selectedSource.Name) 成功!" -ForegroundColor Green
