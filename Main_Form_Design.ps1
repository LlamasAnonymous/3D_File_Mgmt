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


$Name = New-Object System.Windows.Forms.TextBox -Property @{

    Location = New-Object System.Drawing.Point(0, [Math]::Round($NameL.Height + $NameL.Top + 10))
    Width = 383
    Font = New-Object System.Drawing.Font("*", 20)
}


$SetupConfigButton = New-Object System.Windows.Forms.Button -Property @{

    Location = New-Object System.Drawing.Point([Math]::Round($Name.Width / 2), [Math]::Round($Name.Height + $Name.top + 5))
    Height = 100
    Width = [Math]::Round($Name.Width / 2)
    Text = "Settings"
    AutoSize = $true
    Font = New-Object System.Drawing.Font("*", 20)
    Add_Click = ({ Settings_Click })
}


$NewFileButton = New-Object System.Windows.Forms.Button -Property @{

    Location = New-Object System.Drawing.Point(0, [Math]::Round($Name.Height + $Name.top + 5))
    Height = 100
    Width = [Math]::Round($Name.Width / 2)
    Text = "New File"
    AutoSize = $true
    Font = New-Object System.Drawing.Font("*", 20)
    Add_Click = ({ NewFile_Click })
}

# >> Form and properties <<

# >> Add items to form <<

$MainForm.Controls.Add($NameL)
$MainForm.Controls.Add($Name)
$MainForm.Controls.Add($SetupConfigButton)
$MainForm.Controls.Add($NewFileButton)

# >> Add items to form <<