function check {
    param([array]$filePaths)
    
    $wsobj = new-object -comobject wscript.shell

    # check args exist
    if(!$filePaths){
        $wsobj.popup("Please input FilePath at args[0].") | Out-Null
        return $false
    }

    # check path length
    if($filePaths.Length -lt 2){
        $wsobj.popup("Please input at least two FilePaths.") | Out-Null
        return $false
    }

    # check path exist
    foreach($filePath in $filePaths) {
        if(!($filePath | test-path)) {
            $wsobj.popup("Please input correct FilePath.`r`n'$($filePath)' does not exist.") | Out-Null
            return $false
        }
    }

    # check file is PDF
    foreach($filePath in $filePaths) {
        if([System.IO.Path]::GetExtension($filePath) -ne ".pdf"){
            $wsobj.popup("Please input PDF File.`r`n'$($filePath)' is not PDF.") | Out-Null
            return $false
        }
    }

    return $true
}

function join {
    param(
        [array]$filePaths
    )

    if(check $filePaths){
        # convert FilePath
        $files = @()
        foreach($filePath in $filePaths){
            $files += Convert-Path $filePath
        }
        # conbine PDF
        $inputFiles = $null
        foreach($file in $files){
            if($inputFiles -eq $null){
                $inputFiles = $file
            }else{
                $inputFiles = "$inputFiles $file"
            }
        }
        $outputFile = (Split-Path $filePaths[0] -Parent) + "\" +  ([System.IO.Path]::GetFileNameWithoutExtension((Split-Path $filePaths[0] -Leaf))) + "_combine.pdf"
        $cmd = "pdftk $inputFiles cat output $outputFile"
        Invoke-Expression $cmd
    }
    
}

join $args