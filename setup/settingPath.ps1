function result_message {
    param($result)
    $wsobj = new-object -comobject wscript.shell
    if($result){
        $wsobj.popup("Path setting is complete.") | Out-Null
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
            result_message $true
        }else{
            result_message $false
        }
    }
}

# library path
$profilePath = "$HOME\Documents\WindowsPowerShell\Profile.ps1"
$path = '"' + (Split-Path $PSScriptRoot -Parent) + '\lib\"'
$setting = '$env:Path += ' + $path

setting_path $profilePath $setting