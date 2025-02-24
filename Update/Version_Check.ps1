cd $PSScriptRoot
cd ..

function Check_Git {

    try {
        
        git --version
        return $true
    }
    catch {
        
        return $false
    }
}

function Check_Pwsh {

    try {
        
        pwsh --version
        return $true
    }
    catch {
        
        return $false
    }
}

ping github.com -n 1

if ($LASTEXITCODE -eq 0) {

    $Error1 = $null
    $Error2 = $null
    $a = 0

    if (! (Check_Git)) {

        while ($Error1 -ne -1978335189 -or $a -eq 10) {

            winget install git.git --accept-package-agreements --accept-source-agreements
            $Error1 = $LASTEXITCODE
            $a = $a + 1
        }

        if ($a -eq 10) {

            "There is a problem installing Git. Try relaunching or reach out to the administrator." | Out-File ~\ErrorGit.txt
            Start-Process ~\ErrorGit.txt -Wait
            rd ~\ErrorGit.txt
            exit
        }
    }

    $a = 0

    if (! (Check_Pwsh)) {

        while ($Error2 -ne -1978335189 -or $a -eq 10) {

            winget install pwsh --accept-package-agreements --accept-source-agreements
            $Error2 = $LASTEXITCODE
            $a = $a + 1
        }

        if ($a -eq 10) {

            "There is a problem installing PowerShell 7. Try relaunching or reach out to the administrator." | Out-File ~\ErrorPwsh.txt
            Start-Process ~\ErrorPwsh.txt -Wait
            rd ~\ErrorPwsh.txt
            exit
        }
    }

    $env:Path += ";C:\Program Files\Git\bin;C:\Program Files\PowerShell\7;"

    git clone https://github.com/LlamasAnonymous/Versions.git C:\Llama_Toolz\Versions

    Remove-Item "C:\3D_File_Mgmt" -r
    Remove-Item "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\3D File Mgmt.lnk"

    $Local_Version = Get-Content ".\Update\Version.ini"
    $Remote_Version = Get-Content "C:\Llama_Toolz\Versions\3D_File_Mgmt.ini"

    $Local_Version1 = $Local_Version.Replace('.', '')
    $Remote_Version1 = $Remote_Version.Replace('.', '')

    $VersionTotal = $Remote_Version1 - $Local_Version1

    if ($VersionTotal -ne 0) {

        Start-Process "C:\Llama_Toolz\Versions\3D_Mgmt_Update\Rm3D.bat"
    }
    else {
        
        rd C:\Llama_Toolz\Versions -r -Force
        pwsh -WindowStyle Hidden "C:\Llama_Toolz\3D_File_Mgmt\3D_File_Mgmt.ps1"
    }
}
else {

    pwsh -WindowStyle Hidden "C:\Llama_Toolz\3D_File_Mgmt\3D_File_Mgmt.ps1"
}