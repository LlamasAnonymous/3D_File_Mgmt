. ".\Main_Form_Functions.ps1"

# >> Form and properties <<
$MainForm = New-Object System.Windows.Forms.Form -Property @{

    AutoSize = $true
    Height = 125
    Text = "3D File Management"
    StartPosition = "CenterScreen"
}


$NameL = New-Object System.Windows.Forms.Label -Property @{

    Location = New-Object System.Drawing.Point(0, 0)
    AutoSize = $true
    Text = "What do you want to name your new file?"
    TextAlign = "MiddleCenter"
    Font = New-Object System.Drawing.Font("*", 15)
}
$MainForm.Controls.Add($NameL)


$Name = New-Object System.Windows.Forms.TextBox -Property @{

    Location = New-Object System.Drawing.Point(0, [Math]::Round($NameL.Height + $NameL.Top + 10))
    Width = 383
    Font = New-Object System.Drawing.Font("*", 20)
}
$MainForm.Controls.Add($Name)


$SetupConfigButton = New-Object System.Windows.Forms.Button -Property @{

    Location = New-Object System.Drawing.Point([Math]::Round($Name.Width / 2), [Math]::Round($Name.Height + $Name.top + 5))
    Height = 100
    Width = [Math]::Round($Name.Width / 2)
    Text = "Settings"
    AutoSize = $true
    Font = New-Object System.Drawing.Font("*", 20)
    Add_Click = ({ Settings_Click })
}
$MainForm.Controls.Add($SetupConfigButton)

$NewFileButton = New-Object System.Windows.Forms.Button -Property @{

    Location = New-Object System.Drawing.Point(0, [Math]::Round($Name.Height + $Name.top + 5))
    Height = 100
    Width = [Math]::Round($Name.Width / 2)
    Text = "New File"
    AutoSize = $true
    Font = New-Object System.Drawing.Font("*", 20)
    Add_Click = ({ NewFile_Click })
}
$MainForm.Controls.Add($NewFileButton)