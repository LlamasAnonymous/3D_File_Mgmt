ping github.com -n 1

if ($LASTEXITCODE -eq 0) {
    git clone https://github.com/LlamasAnonymous/Versions.git C:\Versions

    $Local_Version = Get-Content ".\Update\Version.ini"
    $Remote_Version = Get-Content "C:\Versions\3D_File_Mgmt.ini"

    $Local_Version1 = $Local_Version.Replace('.', '')
    $Remote_Version1 = $Remote_Version.Replace('.', '')

    $VersionTotal = $Remote_Version1 - $Local_Version1

    if ($VersionTotal -ne 0) {

        Start-Process "C:\Versions\3D_Mgmt_Update\Prep.bat"
    }
    else {
        rd C:\Versions -r -Force
    }
}