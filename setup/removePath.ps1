function result_message {
    param($result)
    $wsobj = new-object -comobject wscript.shell
    if($result){
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
            result_message $true
        }else{
            result_message $false
        }
    }else{
        result_message $false
    }
}

# library path
$profilePath = "$HOME\Documents\WindowsPowerShell\Profile.ps1"
$path = '"' + (Split-Path $PSScriptRoot -Parent) + '\lib\"'
$setting = '$env:Path += ' + $path

setting_path $profilePath $setting