. ".\Settings_Design.ps1"

$Zip_File_Search = New-Object System.Windows.Forms.OpenFileDialog -Property @{

    InitialDirectory = "$home\Downloads"
    Title = "Select your newely downloaded .zip file"
    # Filter = ".exe"
}


$NameText = $Name.Text

if (Test-Path "$SWE\$NameText") {

    [System.Windows.Forms.MessageBox]::Show("There is already a file with the name: $SWE\$NameText", 'Name resolution')
    $NF_Form.Close()
}
else {

    if ($ModelingSoftwareE[1] -eq "y") {

        Start-Process $ModelingSoftwareE[0]
    }

    mkdir @(
        "$SWE\$NameText"
        "$SWE\$NameText\Notes"
        "$SWE\$NameText\Pictures"
        "$SWE\$NameText\Blend"
        "$SWE\$NameText\STL"
    )

    foreach ($Printer in $PrintersE) {

        mkdir "$SWE\$NameText\$Printer"

        foreach ($Material in $MaterialsE) {
            mkdir "$SWE\$NameText\$Printer\$Material"
        }
    }

    if ($ZIP_Check.Checked) {

        if ($Zip_File_Search.ShowDialog() -eq "ok") {
    
            Expand-Archive $Zip_File_Search.FileName "$SWE\$NameText\Unzipped"
        }
    }
}

Start-Process "$SWE\$NameText"