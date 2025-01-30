. ".\New_File_Functions.ps1"

$NF_Form = New-Object System.Windows.Forms.Form -Property @{
    
    AutoSize = $true
    Height = 200
    StartPosition = "CenterScreen"
    Text = "New file form"
}


$MC_Button = New-Object System.Windows.Forms.Button -Property @{

    Dock = 'Top'
    AutoSize = $true
    Height = [Math]::Round($NF_Form.Height * 0.5)
    Text = 'Your own creation'
    Font = New-Object System.Drawing.Font("*", 20)
    Add_Click = ({ MC_Click })
}
$NF_Form.Controls.Add($MC_Button)


$SW_Button = New-Object System.Windows.Forms.Button -Property @{

    Dock = 'Bottom'
    AutoSize = $true
    Height = [Math]::Round($NF_Form.Height * 0.5)
    Text = "Someone else's creation"
    Font = New-Object System.Drawing.Font("*", 20)
    Add_Click = ({ SW_Click })
}
$NF_Form.Controls.Add($SW_Button)