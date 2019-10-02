'use Administrator
Dim WMI, OS, Value, Shell
do while WScript.Arguments.Count = 0 and WScript.Version >= 5.7
    Set WMI = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")
    Set OS = WMI.ExecQuery("SELECT *FROM Win32_OperatingSystem")
    For Each Value in OS
     if left(Value.Version, 3) < 6.0 then exit do
    Next
    Set Shell = CreateObject("Shell.Application")
    Shell.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas"
    WScript.Quit
loop

'get script paths
strPath = Replace(WScript.ScriptFullName,WScript.ScriptName,"")
strFile1 = strPath & + "removePath.ps1"

Dim wsh
Dim strPath, strName, strFile, strCmd
Set wsh = WScript.CreateObject("WScript.Shell")

'set-ExecutionPolicy
strCmd = "PowerShell -Command ""Set-ExecutionPolicy Unrestricted"""
wsh.Run strCmd,0,True

'start setup script
strCmd = "cmd /c powershell -file " + strFile1
wsh.Run strCmd,0,True