# >> Setup <<

$ErrorActionPreference = 'SilentlyContinue'
# $ErrorActionPreference = 'Continue'
# $ErrorActionPreference = 'Stop'
cd $PSScriptRoot

git clone https://github.com/LlamasAnonymous/Versions.git C:\Versions

$Local_Version = Get-Content ".\Update\Version.ini"
$Remote_Version = Get-Content "C:\Versions\3D_File_Mgmt.ini"

$Local_Version1 = $Local_Version.Replace('.','')
$Remote_Version1 = $Remote_Version.Replace('.','')

$VersionTotal = $Remote_Version1 - $Local_Version1

if ($VersionTotal -ne 0) {

    $Remote_Version | Out-File ".\Update\Version.ini"
    rd -r C:\Versions -Force
    Start-Process "C:\3D_File_Mgmt\Update\Prep.bat"
}
else {
    rd -r C:\Versions -Force
}

$MaterialsL = "$home\3D_Mgmt\Configs\Materials.ini"
$ModelingSoftwareL = "$home\3D_Mgmt\Configs\ModelingSoftwareLocation.ini"
$PrintersL = "$home\3D_Mgmt\Configs\Printers.ini"
$MCL = "$home\3D_Mgmt\Configs\ScratchConfig.ini"
$SWL = "$home\3D_Mgmt\Configs\SomewhereConfig.ini"
$zipL = "$home\3D_Mgmt\Configs\zipconf.ini"

$TP = @(

    $MaterialsL
    $ModelingSoftwareL
    $PrintersL
    $MCL
    $SWL
    $zipL
)

if ((Test-Path $TP) -eq $false) {
    if ((Test-Path "$home\3D_Mgmt\Configs") -eq $false) {
        mkdir "$home\3D_Mgmt\Configs" | Out-Null
    }

    New-Item $TP
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# >> Setup <<

function Config_Check {

    $TP_Check = @()

    $Materials_Item = Get-Item $MaterialsL
    $ModelingSoftware_Item = Get-Item $ModelingSoftwareL
    $Printers_Item = Get-Item $PrintersL
    $MC_Item = Get-Item $MCL
    $SW_Item = Get-Item $SWL
    $zip_Item = Get-Item $zipL

    $MaterialsE = Get-Content $MaterialsL
    $ModelingSoftwareE = Get-Content $ModelingSoftwareL
    $MCE = Get-Content $MCL
    $SWE = Get-Content $SWL
    $zipE = Get-Content $zipL

    $File_Length = @(

        $MC_Item
        $SW_Item
        $Materials_Item
        $Printers_Item
        $ModelingSoftware_Item
        $zip_Item
    )
    
    foreach ($Item in $File_Length) {

        if ($Item.Length -lt 1) {

            $TP_Check += $false
        }
        else {

            $ModelingSoftwareE.Replace('"', '') | Out-File $ModelingSoftwareL
            $MCE.Replace('"', '') | Out-File $MCL
            $SWE.Replace('"', '') | Out-File $SWL
    
            $ModelingSoftwareE = Get-Content $ModelingSoftwareL
            $MCE = Get-Content $MCL
            $SWE = Get-Content $SWL

            $TP_Check += $true
        }
    }

    $Locations = @(

        $MCE
        $SWE
        $ModelingSoftwareE[0]
        $zipL
    )

    $Locations = Test-Path $Locations

    if ($ModelingSoftwareE[1] -eq "n" -or $ModelingSoftwareE[1] -eq "y" -and $Locations -notcontains $false) {
        $TP_Check += $true
    }
    else {
        $TP_Check += $false
    }

    $Script:TP_Check = $TP_Check
    $Script:ModelingSoftware_Item = $ModelingSoftware_Item
    $Script:ModelingSoftwareE = $ModelingSoftwareE
    $Script:MCE = $MCE
    $Script:SWE = $SWE
    $Script:zipE = $zipE
}

Config_Check

$TP_Check = $Script:TP_Check
$ModelingSoftware_Item = $Script:ModelingSoftware_Item
$ModelingSoftwareE = $Script:ModelingSoftwareE
$MCE = $Script:MCE
$SWE = $Script:SWE
$zipE = $Script:zipE

. ".\Diag.ps1"
. ".\Settings_Design.ps1"
. ".\Main_Form_Design.ps1"

# Diag_if_Check
if ($TP_Check -contains $false) {

    $Settings_Form.ShowDialog()
}

Config_Check

$TP_Check = $Script:TP_Check
$ModelingSoftware_Item = $Script:ModelingSoftware_Item
$ModelingSoftwareE = $Script:ModelingSoftwareE
$MCE = $Script:MCE
$SWE = $Script:SWE

# Diag_if_Check
if ($TP_Check -notcontains $false) {

    $MainForm.ShowDialog()
}