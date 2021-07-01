$WindowTitle = "Obaveštenje za restart računara"

$Message = "Poštovani, Vaš računar nije restartovan više od nedelju dana.`r`n
Molim Vas da restartujete računar kako ne bi došlo do problema u radu Vašeg računara.`r`n`r`n
IT sektor, Univerexport doo"

$RestartButtonName = "Restartuj odmah"

$PostponeButtonName = "Odloži"

$WmiObject = Get-WmiObject win32_operatingsystem
$LastBootTime = [Management.ManagementDateTimeConverter]::ToDateTime($WmiObject.LastBootUpTime)
$TimeTriger = $LastBootTime -lt (Get-Date).AddDays(0)

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$PromptComputerRestartForm = New-Object system.Windows.Forms.Form
$PromptComputerRestartForm.ClientSize = New-Object System.Drawing.Point(800, 250)
$PromptComputerRestartForm.text = $WindowTitle
$PromptComputerRestartForm.TopMost = $true
$PromptComputerRestartForm.ControlBox = $false

$MessageField = New-Object system.Windows.Forms.Label
$MessageField.text = $Message
$MessageField.AutoSize = $true
$MessageField.width = 500
$MessageField.height = 300
$MessageField.location = New-Object System.Drawing.Point(50, 50)
$MessageField.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 12)

$RestartButton = New-Object system.Windows.Forms.Button
$RestartButton.text = $RestartButtonName
$RestartButton.width = 160
$RestartButton.height = 50
$RestartButton.location = New-Object System.Drawing.Point(210, 170)
$RestartButton.Font = New-Object System.Drawing.Font('Microsoft Sans Serif', 12)

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
        Start-Sleep -Seconds 10
    })

<<<<<<< HEAD
<<<<<<< HEAD
while ($TimeTriger) {
=======
=======
>>>>>>> parent of ee9063a (Update Prompt-Computer-Restart.ps1)
if ($TimeTriger) {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.Application]::EnableVisualStyles()

    $PromptComputerRestartForm             = New-Object system.Windows.Forms.Form
    $PromptComputerRestartForm.ClientSize  = New-Object System.Drawing.Point(800,250)
    $PromptComputerRestartForm.text        = $WindowTitle
    $PromptComputerRestartForm.TopMost     = $true

    $MessageField                    = New-Object system.Windows.Forms.Label
    $MessageField.text               = $Message
    $MessageField.AutoSize           = $true
    $MessageField.width              = 500
    $MessageField.height             = 300
    $MessageField.location           = New-Object System.Drawing.Point(50,50)
    $MessageField.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $RestartButton                   = New-Object system.Windows.Forms.Button
    $RestartButton.text              = $RestartButtonName
    $RestartButton.width             = 160
    $RestartButton.height            = 50
    $RestartButton.location          = New-Object System.Drawing.Point(210,170)
    $RestartButton.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $PostponeButton                  = New-Object system.Windows.Forms.Button
    $PostponeButton.text             = $PostponeButtonName
    $PostponeButton.width            = 160
    $PostponeButton.height           = 50
    $PostponeButton.location         = New-Object System.Drawing.Point(450,170)
    $PostponeButton.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

    $PromptComputerRestartForm.controls.AddRange(@($MessageField,$RestartButton,$PostponeButton))

    $RestartButton.Add_Click({
        Restart-Computer -Force
    })
    $PostponeButton.Add_Click({
        $PromptComputerRestartForm.Close()
    })

<<<<<<< HEAD
>>>>>>> parent of ee9063a (Update Prompt-Computer-Restart.ps1)
=======
>>>>>>> parent of ee9063a (Update Prompt-Computer-Restart.ps1)
    [void]$PromptComputerRestartForm.ShowDialog()
}