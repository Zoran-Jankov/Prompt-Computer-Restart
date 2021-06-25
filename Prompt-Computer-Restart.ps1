$WindowTitle = "Obaveštenje za restart računara"

$Message = "Poštovani, Vaš računar nije restartovan više od nedelju dana. Molim Vas da restartujete računar kako ne bi došlo do problema u radu Vašeg računara. Kliknite na dugme 'Yes' ako želite da odmah restartujete računar.`r`n`r`n
IT sektor, Univerexport doo"

$WmiObject = Get-WmiObject win32_operatingsystem
$LastBootTime = [Management.ManagementDateTimeConverter]::ToDateTime($WmiObject.LastBootUpTime)
$TimeTriger = $LastBootTime -lt (Get-Date).AddDays(-7)

while ($TimeTriger) {
    $MessageBox = [System.Windows.MessageBox]::Show($Message, $WindowTitle, 'YesNo', 'Exclamation')
    switch ($MessageBox) {
        'Yes' {
            Restart-Computer -Force
        }
        'No' {
            Start-Sleep -Seconds 900
        }
    }
}