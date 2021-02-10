# 麻将脸打包重命名脚本
# 需要PowerShell 7以上运行
# 若需查询debug信息，运行脚本前加入 -debug 参数

# 命令行参数
# rootpath 是脚本操作的基础目录，默认为和类别文件夹同级的脚本所在目录，可修改
# destpath 是重命名后的文件夹位置，默认为rootpath下的publish文件夹
param (
    [string]$rootpath = $PSScriptRoot,
    [string]$destpath = $(Join-Path $PSScriptRoot "publish"),
    [switch]$debug = $false 
)

# 修改PowerShell debug环境变量
if ($debug) {
    $DebugPreference = "Continue"
}

Write-Debug "rootpath is: $($rootpath)"
Write-Debug "destpath is: $($destpath)"

# folders 打包包含的文件夹
$folders = "animal", "bundam", "carton", "device", "face", "goose"

foreach ($foldername in $folders) {
    $source = Join-Path $rootpath $foldername
    $destination = Join-Path $destpath $foldername
    Write-Debug "source is $($source)"
    Write-Debug "destination is $($destination)"
    Copy-Item $source $destination -Recurse
}


# 把debug环境变量改回来
if ($debug) {
    $DebugPreference = "SilentlyContinue"
}

