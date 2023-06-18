<#
 * File: Update.ps1
 * Author: Wendel Hammes
 * License: GPL-3.0
#>

Clear-Host

<#---------------------------------------
Updater
---------------------------------------#>

Function Exit-distay-Updater {
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
      Set-Location scripts
      Set-Location Settings
      .\Settings.ps1
    }
    1 {
      Exit
    }
  }
}


Write-Host "[distay]: $($locales.checking_system)"

Set-Location ..
Set-Location ..

If (-Not (Test-Path ".git")) {
  Write-Host "[distay]: $($locales.check_failure)"
  Write-Host

  Write-Host "[distay]: $($locales.check_installation)"
  Write-Host "[distay]: $($locales.check_repo_download_method)"
  Write-Host "[distay]: $($locales.get_help) https://discord.gg/ceCdg9wGVq"

  Exit-distay-Updater
}

Clear-Host

Write-Host "[distay]: $($locales.check_success)"
Write-Host

Write-Host "[distay]: $($locales.updating)"
Write-Host

git pull
If (-Not ($?)) {
  Write-Host "[distay]: $($locales.updating_failure)"
  Write-Host "[distay]: $($locales.get_help) https://discord.gg/ceCdg9wGVq"
  Write-Host

  Exit-distay-Updater
}

If (-Not (Test-Path "node_modules")) {
  Write-Host "[distay]: Installing dependicies."
  Write-Host

  npm install
  If (-Not ($?)) {
    Write-Host "[distay]: $($locales.updating_failure)"
    Write-Host "[distay]: $($locales.get_help) https://discord.gg/ceCdg9wGVq"
    Write-Host

    Exit-distay-Updater
  }
}

# Update was successful
Set-Location scripts
Set-Location boot
.\Start.ps1