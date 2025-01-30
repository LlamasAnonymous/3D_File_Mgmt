# Allows file explorer to open
$Browse_Folder = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{
    
    InitialDirectory = $home
    Description = "Select a folder"
}


$File_Browse = New-Object System.Windows.Forms.OpenFileDialog -Property @{

    InitialDirectory = "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs"
    Title = "Select your 3D modeling software"    
}


# Functions
function MC_BrowseClick {

    if ($Browse_Folder.ShowDialog() -eq "ok") {

        $MC_TextBox.Text = $Browse_Folder.SelectedPath
    }
}


function SW_BrowseClick {

    if ($Browse_Folder.ShowDialog() -eq "ok") {

        $SW_TextBox.Text = $Browse_Folder.SelectedPath
    }
}


function Model_Check {

    if ($Model_Check.Checked) {

        if ($Model_TextBox.Enabled -eq $false) {

            $Model_TextBox.Enabled = $true
        }
    }
    elseif ($Model_Check.Checked -eq $false) {
        
        $Model_TextBox.Enabled = $false
    }
}


function Model_BrowseClick {
    
    if ($File_Browse.ShowDialog() -eq "ok") {

        $Model_TextBox.Text = $File_Browse.FileName
    }
}


function Printer_Add {
    
    if ($Printer_TextBox.Text -eq "" -or $Printer_TextBox.Text -in $Printer_List.Items) {

        [System.Windows.Forms.MessageBox]::Show('Please enter a valid printer name.', 'Name resolution') 
        $Printer_TextBox.Text = ""
    }
    else {

        $Printer_TextBox.Text = $Printer_TextBox.Text.Replace(' ', '_')
        $Printer_List.Items.Add($Printer_TextBox.Text)
        $Printer_TextBox.Text = ""
    }
}


function Printer_Remove {
    
    if ($Printer_List.SelectedIndex -ne -1) {

        $Printer_List.Items.RemoveAt($Printer_List.SelectedIndex)
    }
    else {
        [System.Windows.Forms.MessageBox]::Show('Please select an item to remove.', 'No Item Selected')
    }
}


function Mat_Add {
    
    if ($Mat_TextBox.Text -eq "" -or $Mat_TextBox.Text -in $Mat_List.Items) {

        [System.Windows.Forms.MessageBox]::Show('Please enter a valid material name.', 'Name resolution') 
        $Mat_TextBox.Text = ""
    }
    else {

        $Mat_TextBox.Text = $Mat_TextBox.Text.Replace(' ', '_')
        $Mat_List.Items.Add($Mat_TextBox.Text)
        $Mat_TextBox.Text = ""
    }
}


function Mat_Remove {
    
    if ($Mat_List.SelectedIndex -ne -1) {

        $Mat_List.Items.RemoveAt($Mat_List.SelectedIndex)
    }
    else {
        [System.Windows.Forms.MessageBox]::Show('Please select an item to remove.', 'No Item Selected')
    }
}


function Save {
    
    $Check = @()

    if ((Test-Path "$home\3D_Mgmt\Configs") -eq $false) {

        mkdir  "$home\3D_Mgmt\Configs" | Out-Null
    }

    $MC_TextBox.Text = $MC_TextBox.Text.Replace('"', '')
    if (Test-Path $MC_TextBox.Text) {

        $MC_TextBox.Text | Out-File "$home\3D_Mgmt\Configs\ScratchConfig.ini"
        $check += 1
    }
    else {

        [System.Windows.Forms.MessageBox]::Show("We could not find the path: " + $MC_TextBox.Text, 'Filepath resolution')
        $Check += 0
    }
    

    $SW_TextBox.Text = $SW_TextBox.Text.Replace('"', '')
    if (Test-Path $SW_TextBox.Text) {

        $SW_TextBox.Text | Out-File "$home\3D_Mgmt\Configs\SomewhereConfig.ini"
        $check += 1
    }
    else {

        [System.Windows.Forms.MessageBox]::Show("We could not find the path: " + $SW_TextBox.Text, 'Filepath resolution')
        $Check += 0
    }

    
    $Model_TextBox.Text = $Model_TextBox.Text.Replace('"', '')
    if ((Test-Path $Model_TextBox.Text) -and $Model_Check.Checked -eq $true) {

        $Model_TextBox.Text | Out-File "$home\3D_Mgmt\Configs\ModelingSoftwareLocation.ini"
        "y" | Out-File "$home\3D_Mgmt\Configs\ModelingSoftwareLocation.ini" -Append
        $Check += 1
    }
    elseif ($Model_Check.Checked -eq $false) {
        $Model_TextBox.Text | Out-File "$home\3D_Mgmt\Configs\ModelingSoftwareLocation.ini"
        "n" | Out-File "$home\3D_Mgmt\Configs\ModelingSoftwareLocation.ini" -Append
        $Check += 1
    }
    else {
        [System.Windows.Forms.MessageBox]::Show('We could not find the path: ' + $Model_TextBox.Text, 'Filepath resolution')
        $Check += 0
    }


    if (Test-Path "$home\3D_Mgmt\Configs\zipconf.ini") {

        Remove-Item "$home\3D_Mgmt\Configs\zipconf.ini"
    }

    if ($ZIP_Check.Checked) {

        "y" | Out-File "$home\3D_Mgmt\Configs\zipconf.ini"
    }
    else {
        
        "n" | Out-File "$home\3D_Mgmt\Configs\zipconf.ini"
    }

    
    if ($Printer_List.Items -gt 0) {

        Remove-Item "$home\3D_Mgmt\Configs\Printers.ini" -Force | Out-Null
        New-Item "$home\3D_Mgmt\Configs\Printers.ini" | Out-Null

        foreach ($Printer in $Printer_List.Items) {

            $Printer | Out-File "$home\3D_Mgmt\Configs\Printers.ini" -Append
        }

        $check += 1
    }
    else {

        [System.Windows.Forms.MessageBox]::Show('Add printers to the list' , 'No Items')
        $Check += 0
    
    }

    if ($Mat_List.Items -gt 0) {

        Remove-Item "$home\3D_Mgmt\Configs\Materials.ini" -Force | Out-Null
        New-Item "$home\3D_Mgmt\Configs\Materials.ini" | Out-Null

        foreach ($Printer in $Mat_List.Items) {

            $Printer | Out-File "$home\3D_Mgmt\Configs\Materials.ini" -Append
        }

        $check += 1
    }
    else {

        [System.Windows.Forms.MessageBox]::Show('Add Materials to the list' , 'No Items')
        $Check += 0
    
    }

    if ($Check -notcontains 0) {

        $Settings_Form.DialogResult = "OK"
    }
}
