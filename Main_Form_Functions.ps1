function Settings_Click {
    
    . ".\Settings_Design.ps1"
    $Settings_Form.ShowDialog()
}

function NewFile_Click {

    if ($Name.Text -ne "") {

        . ".\New_File_Form_Design.ps1"
        $NF_Form.ShowDialog()
    }
    else {

        [System.Windows.Forms.MessageBox]::Show('Enter a valid name.', 'Name resolution')
    }
}