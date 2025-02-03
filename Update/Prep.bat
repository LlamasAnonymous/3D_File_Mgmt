taskkill /im powershell.exe /f
taskkill /im pwsh.exe /f

start /min pwsh -WindowStyle Hidden -File "C:\3D_File_Mgmt\Update\Setup.ps1"
Timeout 1