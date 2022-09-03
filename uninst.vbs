rem Set Shell = CreateObject("Shell.Application")
rem Set objShell = CreateObject( "WScript.Shell" )
dim programDir

rem CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) rem 
rem cmdS= chr(34) & programDir & "installer.bat" & chr(34)
rem Shell.ShellExecute  programDir, , "runas", 0
rem Dim WshShell, strCurDir
rem Set WshShell = CreateObject("WScript.Shell")
rem Set WshShell = CreateObject("WScript.Shell")
rem strCurDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
Set objShell = CreateObject( "WScript.Shell" )
rem strCurDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName))&"\"
rem objShell.CurrentDirectory=strCurDir
Dim WshNetwork
Set WshNetwork = CreateObject("WScript.Network")
ComputerName = WshNetwork.ComputerName
user=objShell.ExpandEnvironmentStrings( "%USERNAME%" )
csu = ComputerName&"\\"&user

rem objShell.CurrentDirectory = programDir
rem objShell.CurrentDirectory=strCurDir

rem if IsEmpty(Session) then
rem programDir=strCurDir
rem else
rem programDir= property("CustomActionData")
rem end if
objShell.Run "schtasks /delete /tn WebroamTask /f" rem schtasks /create /f /tn ""WebroamTask"" /tr ""wscript.exe \""" & programDir & "gui\start.vbs\"""" /sc ONLOGON /RU " & csu & " /RL HIGHEST"

rem objShell.Run "Powershell.exe -windowstyle hidden -command ""Set-ScheduledTask -TaskName WebroamTask -Settings $(New-ScheduledTaskSettingsSet -AllowStartifOnbatteries -DontStopIfGoingOnBatteries)"""

objShell.Run "sc stop clamd"
           rem  KillAll ("WRSETUP.exe")
            KillAll ("onlineProtector.exe")
            KillAll ("wrMainAntiRansomeware.exe")
            KillAll ("webroam_diver_packets.exe")
            KillAll ("WRAREngine.exe")
            KillAll ("WebRoamAV.exe")
            KillAll ("WrArServ.exe")
            KillAll ("WRAREngine.exe")          
            KillAll ("webroamransomwgui.exe")
            KillAll ("clamd.exe")
            KillAll ("clamdscan.exe")
            KillAll ("ProcessCritical64.exe")
            objShell.Run "sc delete clamd"
            objShell.Run "sc stop wrips"
            objShell.Run "sc delete wrips"
Sub KillAll(ProcessName)
    Dim objWMIService, colProcess
    Dim strComputer, strList, p
    strComputer = "."
    Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2") 
    Set colProcess = objWMIService.ExecQuery ("Select * from Win32_Process Where Name like '" & ProcessName & "'")
    For Each p in colProcess
        p.Terminate             
    Next
End Sub
rem WScript.Quit

rem WScript.Quit
rem MsgBox(cmdS)
rem ret = objShell.Run (cmdS, 0, 0)

