# Disable GameDVR and Game Bar triggers in the current user profile.
# Safe to run multiple times; values are simply enforced to disabled.

Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Name "AppCaptureEnabled" -Value 0 -Type DWord -ErrorAction SilentlyContinue

Write-Host "Game Bar hooks severed successfully." -ForegroundColor Green
