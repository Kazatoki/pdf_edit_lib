param(
    [string]$filePath,
    [string]$destPath
)

function check {
    param($filePath)
    
    # check args exist
    if(!$filePath){
        Write-Host "please input FilePath at args[0]."
        return $false
    }

    # check path exist
    if(!($filePath | test-path)) {
        Write-Host "please input correct FilePath at args[0]."
        return $false
    }

    return $true
}

function split {
    param(
        [string]$filePath,
        [string]$destPath
    )

    if(check $filePath) {
        # set filePath
        $filePath = Convert-Path $filePath

        # set Output destination
        if($destPath){
            $destFolder = Convert-Path $destPath
        }else{
            $destFolder = Split-Path $filePath -Parent
        }

        $fileName = [System.IO.Path]::GetFileNameWithoutExtension((Split-Path $filePath -Leaf)) + "_%02d.pdf"

        $newFile = $destFolder + "\" + $fileName

        pdftk $filePath burst output $newFile
    }
}

split $filePath $destPath