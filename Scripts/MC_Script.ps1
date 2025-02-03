. ".\Settings_Design.ps1"

$NameText = $Name.Text.Replace(" ", "_")

if (Test-Path "$MCE\$NameText") {

    [System.Windows.Forms.MessageBox]::Show("There is already a file with the name: $NameText", 'Name resolution')
    $NF_Form.Close()
}
else {

    if ($ModelingSoftwareE[1] -eq "y") {

        Start-Process $ModelingSoftwareE[0]
    }

    mkdir @(
        "$MCE\$NameText"
        "$MCE\$NameText\Notes"
        "$MCE\$NameText\Pictures"
        "$MCE\$NameText\Blend"
        "$MCE\$NameText\STL"
    )

    foreach ($Printer in $PrintersE) {

        mkdir "$MCE\$NameText\$Printer"

        foreach ($Material in $MaterialsE) {
            mkdir "$MCE\$NameText\$Printer\$Material"
        }
    }
}

Start-Process "$MCE\$NameText"