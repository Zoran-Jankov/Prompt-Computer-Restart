$CimObject = Get-CimInstance win32_operatingsystem
$LastBootTime = $CimObject.LastBootUpTime
$TimeTriger = $LastBootTime -lt (Get-Date).AddDays(-0)

if ($TimeTriger) {
    $WindowTitle = "Obaveštenje za restart računara"
    $Message = "Poštovani, Vaš računar nije restartovan više od nedelju dana. Molim Vas da restartujete računar kako ne bi došlo do problema u radu Vašeg računara. Ukoliko sami ne restartujete računar on će se sam restartovati u roku od sedam sati.`r`n`r`nIT sektor, Univerexport doo"
    $RestartButtonName = "Restartuj odmah"
    $PostponeButtonName = "Odloži"

    $Margin = 30
    $WindowHeight = 400
    $WindowWidth = 620
    $ButtonWith = 200
    $ButtonHeight = 50
    
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $Window = New-Object system.Windows.Forms.Form
    $Window.Text = $WindowTitle
    $Window.TopMost = $true
    $Window.Height = $WindowHeight
    $Window.Width = $WindowWidth
    $Window.ControlBox = $false
    $Window.ShowIcon = $false
    $Window.FormBorderStyle = 'Fixed3D'
    $Window.MaximizeBox = $false
    $Window.Padding = 30

    $MessageField = New-Object system.Windows.Forms.Label
    $MessageField.Text= $Message
    $MessageField.Height = 150
    $MessageField.Width = 550
    $MessageField.Location = New-Object System.Drawing.Point(30, 30)
    $MessageField.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 13)

    $RestartButton = New-Object system.Windows.Forms.Button
    $RestartButton.Text = $RestartButtonName
    $RestartButton.Width = $ButtonWith
    $RestartButton.Height = $ButtonHeight
    $RestartButton.Location = New-Object System.Drawing.Point($Margin, 210)
    $RestartButton.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 13)
    $RestartButton.Add_Click({
        Restart-Computer -Force
    })

    $PostponeButton = New-Object system.Windows.Forms.Button
    $PostponeButton.Text = $PostponeButtonName
    $PostponeButton.Width = $ButtonWith
    $PostponeButton.Height = $ButtonHeight
    $PostponeButton.Location = New-Object System.Drawing.Point(($WindowWidth - $ButtonWith - $Margin), 210)
    $PostponeButton.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 13)
    $PostponeButton.Add_Click({
        $Window.Close()
    })

    $Window.controls.AddRange(@($MessageField, $RestartButton, $PostponeButton))

    Start-Job -ScriptBlock {
        Start-Sleep -Seconds 25200
        Restart-Computer -Force
    }

    while ($TimeTriger) {
        [void]$Window.ShowDialog()
        Start-Sleep -Seconds 3600
    }
}