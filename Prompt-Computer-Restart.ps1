$WmiObject = Get-CimInstance win32_operatingsystem
$LastBootTime = $WmiObject.LastBootUpTime
$TimeTriger = $LastBootTime -lt (Get-Date).AddDays(-7)

if ($TimeTriger) {
    $WindowTitle = "Obaveštenje za restart računara"
    $Message = "Poštovani, Vaš računar nije restartovan više od nedelju dana.`r`n
    Molim Vas da restartujete računar kako ne bi došlo do problema u radu Vašeg računara.`r`n
    Ukoliko sami ne restartujete računar on će se sam restartovati u roku od sedam sati.`r`n`r`n
    IT sektor, Univerexport doo"
    $RestartButtonName = "Restartuj odmah"
    $PostponeButtonName = "Odloži"

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $PromptComputerRestartForm = New-Object system.Windows.Forms.Form
    $PromptComputerRestartForm.ClientSize = New-Object System.Drawing.Point(800, 350)
    $PromptComputerRestartForm.text = $WindowTitle
    $PromptComputerRestartForm.TopMost = $true

    $MessageField = New-Object system.Windows.Forms.Label
    $MessageField.text = $Message
    $MessageField.AutoSize = $true
    $MessageField.width = 500
    $MessageField.height = 300
    $MessageField.location = New-Object System.Drawing.Point(50, 50)
    $MessageField.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)

    $RestartButton = New-Object system.Windows.Forms.Button
    $RestartButton.text = $RestartButtonName
    $RestartButton.width = 160
    $RestartButton.height = 50
    $RestartButton.location = New-Object System.Drawing.Point(210, 170)
    $RestartButton.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)

    $PostponeButton = New-Object system.Windows.Forms.Button
    $PostponeButton.text = $PostponeButtonName
    $PostponeButton.width = 160
    $PostponeButton.height = 50
    $PostponeButton.location = New-Object System.Drawing.Point(450, 170)
    $PostponeButton.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 10)

    $PromptComputerRestartForm.controls.AddRange(@($MessageField, $RestartButton, $PostponeButton))

    $RestartButton.Add_Click( {
            Restart-Computer -Force
        })
    $PostponeButton.Add_Click( {
            $PromptComputerRestartForm.Close()
        })

    Start-Job -ScriptBlock {
        Start-Sleep -Seconds 2520
        Restart-Computer -Force
    }

    while ($TimeTriger) {
        [void]$PromptComputerRestartForm.ShowDialog()
        Start-Sleep -Seconds 3600
    }
}