$TP_Check = @()

$Materials_Item = Get-Item $MaterialsL
$ModelingSoftware_Item = Get-Item $ModelingSoftwareL
$Printers_Item = Get-Item $PrintersL
$MC_Item = Get-Item $MCL
$SW_Item = Get-Item $SWL

$ModelingSoftwareE = Get-Content $ModelingSoftwareL
$MCE = Get-Content $MCL
$SWE = Get-Content $SWL

$File_Length = @(

    $MC_Item
    $SW_Item
    $Materials_Item
    $ModelingSoftware_Item
    $Printers_Item
)

foreach ($Item in $File_Length) {

    if ($Item.Length -lt 3) {

        $TP_Check += $false
    }
    else {

        $TP_Check += $true
    }
}

$Locations = @(

    $MCE
    $SWE
)

if (Test-Path $Locations) {

    $TP_Check += $true
}
else {

    $TP_Check += $false
}


if ($ModelingSoftwareE[1] -eq 'n') {
    
    $TP_Check += $true
}
elseif ($ModelingSoftwareE[1] -eq 'y' -and (Test-Path $ModelingSoftwareE[0])) {

    $TP_Check += $true
}
else {

    $TP_Check += $false
}

$TP_Check