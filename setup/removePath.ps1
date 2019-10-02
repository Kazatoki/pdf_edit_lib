function result_message {
    param($result1, $result2)
    $wsobj = new-object -comobject wscript.shell
    if($result1 -or $result2){
        $wsobj.popup("Deletion of path is complete.") | Out-Null
    }else{
        $wsobj.popup("Path does not exist. Exit without making any changes.") | Out-Null
    }
}

function setting_path {
    param($profilePath, $setting)
    # confirm profile.ps1 exist
    if(Test-Path $profilePath){
        # confirm path exist
        $existPath = $false
        $lines = Get-Content $profilePath
        foreach($line in $lines){
            if($line -eq $setting){
                $existPath = $true
                break
            }
        }
        # if exist path, remove $env:Path
        if($existPath){
            Get-Content $profilePath | Where-Object {$_ -ne $setting} | Out-File $profilePath
            return $true
        }else{
            return $false
        }
    }else{
        return $false
    }
}


function main {
    # library path
    $profilePath = "$HOME\Documents\WindowsPowerShell\Profile.ps1"
    $path = '";' + (Split-Path $PSScriptRoot -Parent) + '\bin\;"'
    $setting = '$env:Path += ' + $path

    $result1 = setting_path $profilePath $setting

    # binary path
    $profilePath = "$HOME\Documents\WindowsPowerShell\Profile.ps1"
    $path = '";' + (Split-Path $PSScriptRoot -Parent) + '\plugins\qpdf-9.0.1\bin\;"'
    $setting = '$env:Path += ' + $path

    $result2 = setting_path $profilePath $setting

    result_message $result1 $result2
}

main