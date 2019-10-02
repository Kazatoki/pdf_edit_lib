function set-shortcut {
    param ( [string]$SourceLnk, [string]$DestinationPath, [string]$Args, [string]$WorkingPath )

    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($SourceLnk)
    $Shortcut.TargetPath = """$DestinationPath"""
    $Shortcut.Arguments = $Args
    $Shortcut.WorkingDirectory = $WorkingPath
    $Shortcut.Save()

}

$folderPath = (Split-Path $PSScriptRoot -Parent)
$scripts = @("pdf_join.ps1","pdf_split.ps1","pdf_unlock.ps1")

$shortcutLinks = @()
$exeArgs = @()
foreach($scriptPath in $scripts){
    $shortcutLinks += $folderPath + "\" + $scriptPath + ".lnk"
    $exeArgs += "-NoProfile -ExecutionPolicy Unrestricted -File $($folderPath)\bin\$($scriptPath)"
}

$exePath = "$($PSHOME)\powershell.exe"

$WorkingPath = $folderPath + "\bin\"

for($i=0; $i -lt $shortcutLinks.Length; $i++){
    set-shortcut $shortcutLinks[$i] $exePath $exeArgs[0] $WorkingPath
}
