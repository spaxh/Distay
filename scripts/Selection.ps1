<#
 * File: Selection.ps1
 * Author: Wendel Hammes
 * License: GPL-3.0
#>

Clear-Host

<#---------------------------------------
Language Translator
---------------------------------------#>

$config = (Get-Content "../config/config.json" -Raw) | ConvertFrom-Json

If ($config.language -eq 'en') {
    $locales = (Get-Content '../locales/en/panel.json' -Raw) | ConvertFrom-Json
}

Else {
    Start-Sleep -Seconds 0.1
    Write-Host "[ERROR]: INVALID LANGUAGE."
    Exit
}

<#---------------------------------------
Selection
---------------------------------------#>

$caption = "[distay]: $($locales.welcome) $env:UserName!
 "
$description = "[distay]: $($locales.select_option)
 "

$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((
        New-Object Management.Automation.Host.ChoiceDescription `
            -ArgumentList `
            "&1 Start $($locales.start_app)",
        "$($locales.desktop_panel_help)"
    ))
$choices.Add((
        New-Object Management.Automation.Host.ChoiceDescription `
            -ArgumentList `
            "&2 $($locales.settings)",
        "$($locales.settings_help)"
    ))
$choices.Add((
        New-Object Management.Automation.Host.ChoiceDescription `
            -ArgumentList `
            "&3 $($locales.exit)",
        "$($locales.exit_help)"
    ))

$selection = $host.ui.PromptForChoice($caption, $description, $choices, -1)
Write-Host

switch ($selection) {
    0 {
        Set-Location boot
        .\Checks.ps1
    }
    1 {
        Set-Location Settings
        .\Settings.ps1
    }
    2 {
        Exit
    }
}