<#
 * File: Start.ps1
 * Author: Wendel Hammes
 * License: GPL-3.0
#>

<#---------------------------------------
Distay Web Boot-up
---------------------------------------#>

Write-Host ""
Write-Host "[Distay]: $($locales.checking_system)"
If (Test-Path "..\..\index.js") {
    Write-Host "[Distay]: $($locales.check_success)"
    Write-Host

    Write-Host "[Distay]: $($locales.booting)"
    Write-Host

    node ./boot.js

    $caption = ""
    $description = ""

    Write-Host
    $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
    $choices.Add((
            New-Object Management.Automation.Host.ChoiceDescription `
                -ArgumentList `
                "&1 $($locales.go_back)",
            "$($locales.go_back_help)"
        ))
    $choices.Add((
            New-Object Management.Automation.Host.ChoiceDescription `
                -ArgumentList `
                "&2 $($locales.exit)",
            "$($locales.exit_help)"
        ))

    $selection = $host.ui.PromptForChoice($empty, $empty2, $choices, -1)

    Write-Host

    switch ($selection) {
        0 {
            Set-Location ..
            .\Selection.ps1
        }
        1 {
            Exit
        }
    }

}
Else {
    Write-Host "[Distay]: $($locales.check_failure)"
    Write-Host

    Write-Host "[Distay]: $($locales.check_index)"
    Write-Host "[Distay]: $($locales.get_help)"
}
Write-Host