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
