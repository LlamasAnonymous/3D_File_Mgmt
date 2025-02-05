ping github.com -n 1

if ($LASTEXITCODE -eq 0) {
    git clone https://github.com/LlamasAnonymous/Versions.git C:\Versions

    $Local_Version = Get-Content ".\Update\Version.ini"
    $Remote_Version = Get-Content "C:\Versions\3D_File_Mgmt.ini"

    $Local_Version1 = $Local_Version.Replace('.', '')
    $Remote_Version1 = $Remote_Version.Replace('.', '')

    $VersionTotal = $Remote_Version1 - $Local_Version1

    if ($VersionTotal -ne 0) {

        rd -r C:\Versions -Force
        Start-Process "C:\3D_File_Mgmt\Update\Prep.bat"
    }
    else {
        rd -r C:\Versions -Force
    }
}