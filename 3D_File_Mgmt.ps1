# >> Setup <<

# $ErrorActionPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Continue'
# $ErrorActionPreference = 'Stop'
cd $PSScriptRoot

mkdir "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Llama_Toolz"
Copy-Item "C:\Llama_Toolz\3D_File_Mgmt\Misc\3D File Mgmt.lnk" "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Llama_Toolz"

$MaterialsL = "$home\3D_Mgmt\Configs\Materials.ini"
$ModelingSoftwareL = "$home\3D_Mgmt\Configs\ModelingSoftwareLocation.ini"
$PrintersL = "$home\3D_Mgmt\Configs\Printers.ini"
$MCL = "$home\3D_Mgmt\Configs\ScratchConfig.ini"
$SWL = "$home\3D_Mgmt\Configs\SomewhereConfig.ini"
$zipL = "$home\3D_Mgmt\Configs\zipconfig.ini"

$TP = @(

    $MaterialsL
    $ModelingSoftwareL
    $PrintersL
    $MCL
    $SWL
    $zipL
)

if ((Test-Path $TP) -contains $false) {
    if ((Test-Path "$home\3D_Mgmt\Configs") -eq $false) {
        mkdir "$home\3D_Mgmt\Configs"
    }

    New-Item $TP
}

if (Test-Path "$PSScriptRoot\Update\FirstTime.ini") {

    Start-Process "$PSScriptRoot\Misc\Help\3D_File_Mgmt_Guide.pdf"
    Remove-Item ".\Update\FirstTime.ini"
}

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

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