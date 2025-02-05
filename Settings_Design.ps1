$MaterialsE = Get-Content $MaterialsL
$ModelingSoftwareE = Get-Content $ModelingSoftwareL
$MCE = Get-Content $MCL
$SWE = Get-Content $SWL
$zipE = Get-Content $zipL
$Version_Local = Get-Content ".\Update\Version.ini"

$PrintersE = Get-Content $PrintersL -ErrorAction SilentlyContinue

. ".\Setting_Functions.ps1" # Imports form functions

# >> Form and properties <<

$Settings_Form = New-Object System.Windows.Forms.Form -Property @{
    
    Text = "Configuration Manager"
    AutoSize = $true
    StartPosition = 'CenterScreen'
}


$MC_Label = New-Object System.Windows.Forms.Label -Property @{

    Location = New-Object System.Drawing.Point(10, 10)
    AutoSize = $true
    Text = "Location of your model"
    Font = New-Object System.Drawing.Font("*",15)
    TextAlign = "MiddleLeft"
}
$Settings_Form.Controls.Add($MC_Label)



$MC_TextBox = New-Object System.Windows.Forms.TextBox -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($MC_Label.Height + $MC_Label.Top + 5))
    Width = 500
    Font = New-Object System.Drawing.Font("*",15)
    Text = $MCE
}
$Settings_Form.Controls.Add($MC_TextBox)



$MC_Button = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($MC_TextBox.Width + $MC_TextBox.Left), [Math]::Round($MC_TextBox.Top - 5))
    AutoSize = $true
    Text = "Browse"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ MC_BrowseClick })
}
$Settings_Form.Controls.Add($MC_Button)



$SW_Label = New-Object System.Windows.Forms.Label -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($MC_Button.Height + $MC_Button.Top + 20))
    AutoSize = $true
    Text = "Location of your downloaded model"
    Font = New-Object System.Drawing.Font("*",15)
    TextAlign = "MiddleLeft"
}
$Settings_Form.Controls.Add($SW_Label)



$SW_TextBox = New-Object System.Windows.Forms.TextBox -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($SW_Label.Height + $SW_Label.Top + 5))
    Width = 500
    Font = New-Object System.Drawing.Font("*",15)
    Text = $SWE
}
$Settings_Form.Controls.Add($SW_TextBox)



$SW_Button = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($SW_TextBox.Width + $SW_TextBox.Left), [Math]::Round($SW_TextBox.Top - 5))
    AutoSize = $true
    Text = "Browse"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ SW_BrowseClick })
}
$Settings_Form.Controls.Add($SW_Button)



$Model_Check = New-Object System.Windows.Forms.CheckBox -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($SW_Button.Height + $SW_Button.Top + 20))
    AutoSize = $true
    Text = "Auto-open 3D modeling sofware"
    Font = New-Object System.Drawing.Font("*",13)
    Add_CheckedChanged = ({ Model_Check })
}
if ($ModelingSoftwareE[1] -eq "y") {

    $Model_Check.Checked = $true
}
else {

    $Model_Check.Checked = $false
}
$Settings_Form.Controls.Add($Model_Check)



$Model_Label = New-Object System.Windows.Forms.Label -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($Model_Check.Height + $Model_Check.Top + 10))
    AutoSize = $true
    Text = "3D modeling sofware location"
    Font = New-Object System.Drawing.Font("*",15)
    TextAlign = "MiddleLeft"
}
$Settings_Form.Controls.Add($Model_Label)



$Model_TextBox = New-Object System.Windows.Forms.TextBox -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($Model_Label.Height + $Model_Label.Top + 5))
    Width = 500
    Font = New-Object System.Drawing.Font("*",15)
}
if ($ModelingSoftware_Item.Length -gt 0) {

    $Model_TextBox.Text = $ModelingSoftwareE[0]
}
else {

    $Model_TextBox.Text = ""
}

if ($Model_Check.Checked -eq $true) {

    $Model_TextBox.Enabled = $true
}
elseif ($Model_Check.Checked -eq $false) {

    $Model_TextBox.Enabled = $false
}
$Settings_Form.Controls.Add($Model_TextBox)



$Model_Button = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($Model_TextBox.Width + $Model_TextBox.Left), [Math]::Round($Model_TextBox.Top - 5))
    AutoSize = $true
    Text = "Browse"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ Model_BrowseClick })
}
$Settings_Form.Controls.Add($Model_Button)


$ZIP_Check = New-Object System.Windows.Forms.CheckBox -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($Model_Button.Height + $Model_Button.Top + 20))
    AutoSize = $true
    Text = "Search for zipped folder"
    Font = New-Object System.Drawing.Font("*",13)
}
if ($zipE -eq "y") {

    $ZIP_Check.Checked = $true
}
else {

    $ZIP_Check.Checked = $false
}
$Settings_Form.Controls.Add($ZIP_Check)


$Printer_TextBox = New-Object System.Windows.Forms.TextBox -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($ZIP_Check.Height + $ZIP_Check.Top + 60))
    Width = [Math]::Round($Model_TextBox.Width * 0.5)
    Font = New-Object System.Drawing.Font("*",15)
    TextAlign = "Center"
}
$Settings_Form.Controls.Add($Printer_TextBox)



$Printer_Label = New-Object System.Windows.Forms.Label -Property @{

    Location = New-Object System.Drawing.Point([Math]::Round($Printer_TextBox.Left), [Math]::Round($Printer_TextBox.Top - 35))
    Width = [Math]::Round($Printer_TextBox.Width)
    Text = 'Printers'
    Font = New-Object System.Drawing.Font("*",15)
    TextAlign = "MiddleCenter"
}
$Settings_Form.Controls.Add($Printer_Label)



$Printer_Add = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($Printer_TextBox.Left), [Math]::Round($Printer_TextBox.Height + $Printer_TextBox.Top + 3))
    AutoSize = $true
    Width = [Math]::Round(($Printer_TextBox.Width / 2) - 3)
    Text = "Add"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ Printer_Add })
}
$Settings_Form.Controls.Add($Printer_Add)



$Printer_Remove = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($Printer_Add.Left), [Math]::Round($Printer_Add.Height + $Printer_Add.Top))
    AutoSize = $true
    Width = [Math]::Round($Printer_Add.Width)
    Text = "Remove"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ Printer_Remove })
}
$Settings_Form.Controls.Add($Printer_Remove)



$Printer_List = New-Object System.Windows.Forms.ListBox -Property @{

    Location = New-Object System.Drawing.Point([Math]::Round(($Printer_TextBox.Width / 2) + $Printer_Add.Left), [Math]::Round($Printer_Add.Top))
    AutoSize = $true
    Width = [Math]::Round($Printer_TextBox.Width / 2)
}
foreach ($Printer in $PrintersE) { # Fetches the items that are in the printer config file

$Printer_List.Items.Add($Printer)
}
$Settings_Form.Controls.Add($Printer_List)



$Divider1 = New-Object System.Windows.Forms.Label -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round(($Printer_TextBox.Width + $Printer_TextBox.Left) + 20), [Math]::Round($Printer_List.Top - 70))
    Height = [Math]::Round($Printer_List.Height + 90)
    Width = 3
    BackColor = "200, 200, 200"
}
$Settings_Form.Controls.Add($Divider1)



$Mat_TextBox = New-Object System.Windows.Forms.TextBox -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($Divider1.Width + $Divider1.Left + 20), [Math]::Round($Printer_TextBox.Top))
    Width = [Math]::Round($Printer_TextBox.Width)
    Font = New-Object System.Drawing.Font("*",15)
    TextAlign = "Center"
}
$Settings_Form.Controls.Add($Mat_TextBox)



$Mat_Label = New-Object System.Windows.Forms.Label -Property @{
 
    Location = New-Object System.Drawing.Point([Math]::Round($Mat_TextBox.Left), [Math]::Round($Mat_TextBox.Top - 35))
    Width = [Math]::Round($Printer_TextBox.Width)
    AutoSize = $false
    Text = 'Materials'
    Font = New-Object System.Drawing.Font("*",15)
    TextAlign = "MiddleCenter"
}
$Settings_Form.Controls.Add($Mat_Label)



$Mat_Add = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($Mat_TextBox.Left), [Math]::Round($Mat_TextBox.Height + $Mat_TextBox.Top + 3))
    AutoSize = $true
    Width = [Math]::Round(($Mat_TextBox.Width / 2) - 3)
    Text = "Add"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ Mat_Add })
}
$Settings_Form.Controls.Add($Mat_Add)



$Mat_Remove = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($Mat_Add.Left), [Math]::Round($Mat_Add.Height + $Mat_Add.Top))
    AutoSize = $true
    Width = [Math]::Round($Mat_Add.Width)
    Text = "Remove"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ Mat_Remove })
}
$Settings_Form.Controls.Add($Mat_Remove)



$Mat_List = New-Object System.Windows.Forms.ListBox -Property @{

    Location = New-Object System.Drawing.Point([Math]::Round(($Mat_TextBox.Width / 2) + $Mat_Add.Left), [Math]::Round($Mat_Add.Top))
    AutoSize = $true
    Width = [Math]::Round($Mat_TextBox.Width / 2)
}
foreach ($Material in $MaterialsE) { # Fetches the items that are in the material config file
$Mat_List.Items.Add($Material)
}
$Settings_Form.Controls.Add($Mat_List)



$Cancel_Button = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point(0, [Math]::Round($Divider1.ClientSize.Height + $Divider1.Top + 20))
    AutoSize = $true
    Width = [Math]::Round($Settings_Form.Width * 0.5)
    Text = "Cancel"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ $Settings_Form.DialogResult = 'Cancel' })
}
$Settings_Form.Controls.Add($Cancel_button)



$Save_Button = New-Object System.Windows.Forms.Button -Property @{
    
    Location = New-Object System.Drawing.Point([Math]::Round($Settings_Form.ClientSize.Width * 0.5), [Math]::Round($Divider1.ClientSize.Height + $Divider1.Top + 20))
    AutoSize = $true
    Width = [Math]::Round($Settings_Form.Width * 0.5)
    Text = "Save"
    Font = New-Object System.Drawing.Font("*",15)
    Add_Click = ({ Save })
}
$Settings_Form.Controls.Add($Save_button)



$Version_Label = New-Object System.Windows.Forms.Label -Property @{

    Location = New-Object System.Drawing.Point(10, [Math]::Round($Cancel_Button.Top - 20))
    AutoSize = $true
    Width = [Math]::Round($Cancel_Button.Width + $Save_Button.Width)
    Text = $Version_Local
}
$Settings_Form.Controls.Add($Version_Label)

# >> Form and properties <<