function result_message {
    param($result1, $result2)
    $wsobj = new-object -comobject wscript.shell
    if($result1 -and $result2){
        $wsobj.popup("Path setting is complete.") | Out-Null
    }elseif($result1 -and !($result2)){
        $wsobj.popup("Path setting is complete.`r`nqpdf Path already exists. ") | Out-Null
    }elseif(!($result1) -and $result2){
        $wsobj.popup("Path setting is complete.`r`nBinary Path already exists. ") | Out-Null
    }else{
        $wsobj.popup("Path already exists. Exit without making any changes.") | Out-Null
    }
}

function setting_path {
    param($profilePath, $setting)
    # confirm profile.ps1 exist
    if(!(Test-Path $profilePath)){
        # create profile.ps1
        New-Item -path $profilePath -type file -force
        # add $env:Path
        Write-Output $setting | Add-Content $profilePath -Encoding Default
        result_message $true
    }else{
        # confirm path exist
        $existPath = $false
        $lines = Get-Content $profilePath
        foreach($line in $lines){
            if($line -eq $setting){
                $existPath = $true
                break
            }
        }
        # if not exist path, add $env:Path
        if(!$existPath){
            Write-Output $setting | Add-Content $profilePath -Encoding Default
            return $true
        }else{
            return $false
        }
    }
}


function main {
    # binary path
    $profilePath = "$HOME\Documents\WindowsPowerShell\Profile.ps1"
    $path = '"' + (Split-Path $PSScriptRoot -Parent) + '\bin\"'
    $setting = '$env:Path += ' + $path


    $result1 = setting_path $profilePath $setting

    # qpdf path
    $profilePath = "$HOME\Documents\WindowsPowerShell\Profile.ps1"
    $path = '"' + (Split-Path $PSScriptRoot -Parent) + '\plugins\qpdf-9.0.1\bin\"'
    $setting = '$env:Path += ' + $path

    $result2 = setting_path $profilePath $setting

    result_message $result1 $result2
}

main