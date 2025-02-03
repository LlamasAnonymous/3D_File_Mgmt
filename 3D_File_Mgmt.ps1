# >> Setup <<

$ErrorActionPreference = 'SilentlyContinue'
# $ErrorActionPreference = 'Continue'
# $ErrorActionPreference = 'Stop'
cd $PSScriptRoot

. ".\Update\Version_Check.ps1"

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

. ".\ConfigCheck.ps1"
. ".\Settings_Design.ps1"
. ".\Main_Form_Design.ps1"

if ($TP_Check -contains $false) {

    $Settings_Form.ShowDialog()
}

. ".\ConfigCheck.ps1"

if ($TP_Check -notcontains $false) {

    $MainForm.ShowDialog()
}