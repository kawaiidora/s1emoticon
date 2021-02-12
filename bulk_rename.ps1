# 麻将脸打包重命名脚本
# 需要PowerShell 7以上运行

# 关于debug
# powershell的debug需要设置环境变量
# $DebugPreference = "Continue"
# $ErrorActionPreference = "Stop"

# 命令行参数
# rootpath 是脚本操作的基础目录，默认为和类别文件夹同级的脚本所在目录，可修改
# destpath 是重命名后的文件夹位置，默认为rootpath下的publish文件夹
param (
    [string]$rootpath = $PSScriptRoot,
    [string]$destpath = $(Join-Path $PSScriptRoot "publish")
)

# Write-Debug "rootpath is: $($rootpath)"
# Write-Debug "destpath is: $($destpath)"

# 复制文件，只复制几个打包需要的文件夹

$folders = "animal", "bundam", "carton", "device", "face", "goose"

# 绕开“如果目标文件夹已存在，则copy-item会报错”
if (-not (Test-Path $destpath)) {
    foreach ($foldername in $folders) {
        $source = Join-Path $rootpath $foldername
        $destination = Join-Path $destpath $foldername
        # Write-Debug "source is: $($source)"
        # Write-Debug "destination is: $($destination)"
        Copy-Item $source $destination -Recurse
    }
}

# 重命名文件，规范要求文件只保留序号的三个数字，不保留后缀和首个类别字母

# $result = Get-ChildItem -Path $(Join-Path $destpath "animal") -Name
# Write-Debug $result[0].GetType()

function NameMatchThreeDigit {
    param (
        [string]$filename
    )
    $filename -match "^[0-9][0-9][0-9]"
}

function NameMatchOneLetterThreeDigit {
    param (
        [string]$filename
    )
    $filename -match "^[A-Z][0-9][0-9][0-9]"
}


# Write-Debug "going to rename"
foreach ($foldername in $folders) {
    $targetpath = Join-Path $destpath $foldername
    # Write-Debug "targetpath is: $targetpath"
    $filenames = Get-ChildItem -Path $targetpath -Name
    foreach ($filename in $filenames) {
        # $withoutletter = $filename -match "^[0-9][0-9][0-9]"
        # $withletter = $filename -match "^[A-Z][0-9][0-9][0-9]"
        # $withletter = NameMatchOneLetterThreeDigit $filename
        # $withoutletter = NameMatchThreeDigit $filename
        # Write-Debug "$filename matches withletter is $withletter"
        # Write-Debug "$filename matches withoutletter is $withoutletter"
        
        $substring_index = -1;
        if (NameMatchOneLetterThreeDigit $filename) {
            # $newname = $filename.Substring(1, 3) + [System.IO.Path]::GetExtension($filename)
            # Rename-Item -Path $(Join-Path $targetpath $filename) -NewName $newname
            # continue
            $substring_index = 1;
        }
        if (NameMatchThreeDigit $filename) {
            $substring_index = 0;
        }
        if ($substring_index -eq -1) {
            Write-Error "something wrong in the filename, fix it or contact script author"
            exit
        }
        $newname = $filename.Substring($substring_index, 3) + [System.IO.Path]::GetExtension($filename)

        # 如果编号有重复，这里就会提示文件名错误
        try {
        Rename-Item -Path $(Join-Path $targetpath $filename) -NewName $newname
        } catch {
            throw "renaming $filename got error, check the file"
        }
    }
}

# 将文件名和新的排序写入新表格中

# 类别和表中typeid的对应关系
$typeid = @{
    "animal" = 1468;
    "bundam" = 1471;
    "carton" = 1467;
    "device" = 1469;
    "face"   = 1465;
    "goose"  = 1470;
}

# 打包文件夹

