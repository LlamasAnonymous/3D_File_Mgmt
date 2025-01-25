# >> Setup <<

# $ErrorActionPreference = 'SilentlyContinue'
$ErrorActionPreference = 'Continue'
cd $PSScriptRoot
. ".\Diag.ps1"

$MaterialsL = ".\Configs\Materials.txt"
$ModelingSoftwareL = ".\Configs\ModelingSoftwareLocation.txt"
$PrintersL = ".\Configs\Printers.txt"
$MCL = ".\Configs\ScratchConfig.txt"
$SWL = ".\Configs\SomewhereConfig.txt"

mkdir ".\Configs" | Out-Null
New-Item ($MaterialsL, $ModelingSoftwareL, $PrintersL, $MCL, $SWL) | Out-Null

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# >> Setup <<

function Config_Check {

    $TP_Locations = @()

    $Materials_Item = Get-Item $MaterialsL
    $ModelingSoftware_Item = Get-Item $ModelingSoftwareL
    $Printers_Item = Get-Item $PrintersL
    $MC_Item = Get-Item $MCL
    $SW_Item = Get-Item $SWL

    $MaterialsE = Get-Content $MaterialsL
    $ModelingSoftwareE = Get-Content $ModelingSoftwareL
    $MCE = Get-Content $MCL
    $SWE = Get-Content $SWL
    
    if ($MC_Item.Length -lt 1 -or $SW_Item.Length -lt 1 -or $Materials_Item.Length -lt 1 -or $Printers_Item.Length -lt 1 -or $ModelingSoftware_Item.Length -lt 1) {
        $TP_Locations += $false
    }
    else {
        $ModelingSoftwareE.Replace('"', '') | Out-File $ModelingSoftwareL
        $MCE.Replace('"', '') | Out-File $MCL
        $SWE.Replace('"', '') | Out-File $SWL
    
        $ModelingSoftwareE = Get-Content $ModelingSoftwareL
        $MCE = Get-Content $MCL
        $SWE = Get-Content $SWL
    } 

    $Locations = (Test-Path $MCE, $SWE, $ModelingSoftwareE[0])

    if ($ModelingSoftwareE[1] -eq "y" -or $ModelingSoftwareE[1] -eq "n" -or $Locations -notcontains $false) {
        $TP_Locations += $true
    }
    else {
        $TP_Locations += $false
    }

    $Script:TP_Locations = $TP_Locations
    $Script:ModelingSoftware_Item = $ModelingSoftware_Item
}

Config_Check

$TP_Locations = $Script:TP_Locations
$ModelingSoftware_Item = $Script:ModelingSoftware_Item

# Launch_if_Check
if ($TP_Locations -contains $false) {

    . ".\Settings_Design.ps1"
    $Settings_Form.ShowDialog()
}

Config_Check
# Launch_if_Check
if ($TP_Locations -notcontains $false) {

    . ".\Main_Form_Design.ps1"
    $MainForm.ShowDialog()
}