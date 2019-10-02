param(
    [string]$filePath,
    [string]$destPath
)

function check {
    param($filePath)
    
    $wsobj = new-object -comobject wscript.shell

    # check args exist
    if(!$filePath){
        $wsobj.popup("Please input FilePath at args[0].") | Out-Null
        return $false
    }

    # check path exist
    if(!($filePath | test-path)) {
        $wsobj.popup("Please input correct FilePath.`r`n'$($filePath)' does not exist.") | Out-Null
        return $false
    }

    # check file is PDF
    if([System.IO.Path]::GetExtension($filePath) -ne ".pdf"){
        $wsobj.popup("Please input PDF File.`r`n'$($filePath)' is not PDF.") | Out-Null
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
