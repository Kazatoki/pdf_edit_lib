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

function inputPass {
    [void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

    $securestring = Read-Host -AsSecureString "Input PDF''s Password."
    
    return [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securestring))
}

function unlock {
    param(
        [string]$filePath,
        [string]$destPath
    )

    $pass = inputPass
    if((check $filePath) -And ($pass -ne "")) {
        # set filePath
        $filePath = Convert-Path $filePath

        # set Output destination
        if($destPath){
            $destFolder = Convert-Path $destPath
        }else{
            $destFolder = Split-Path $filePath -Parent
        }

        $fileName = [System.IO.Path]::GetFileNameWithoutExtension((Split-Path $filePath -Leaf)) + "_unlock.pdf"
        $newFile = $destFolder + "\" + $fileName
        
        # copy file -Avoid FileName Error-
        $tmp = $destFolder + "\_.pdf"
        $tmp2 = $destFolder + "\unlocked.pdf"
        cp $filePath $tmp

        # unlock pdf
        $cmd = "..\plugins\qpdf-9.0.1\bin\qpdf.exe --decrypt $tmp --password=$pass $tmp2"
        Invoke-Expression $cmd

        # File organization
        Remove-Item $tmp
        Rename-Item $tmp2 $newFile
    }
}

unlock $filePath $destPath
