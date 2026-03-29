# install_software.ps1

Write-Host "Starting automated software installation via Winget..." -ForegroundColor Cyan

# The master list of your essential software IDs
$softwareList = @(
    "hluk.CopyQ",
    "RamenSoftware.Windhawk",
    "Microsoft.PowerToys"
    # Add your web browsers, IDEs, and other tools here. 
    # Example: "Mozilla.Firefox", "Git.Git", "Python.Python.3.11"
)

foreach ($app in $softwareList) {
    Write-Host "Installing $app..." -ForegroundColor Yellow
    
    # --id and --exact ensure Winget doesn't get confused by similarly named apps
    # The accept flags bypass prompts, and --silent hides the installer GUI
    winget install --id $app --exact --accept-package-agreements --accept-source-agreements --silent
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully installed $app." -ForegroundColor Green
    } else {
        Write-Host "Failed or required manual intervention for $app. Exit code: $LASTEXITCODE" -ForegroundColor Red
    }
}

Write-Host "Software deployment complete!" -ForegroundColor Cyan