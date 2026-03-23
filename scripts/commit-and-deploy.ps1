param(
  [string]$Message = "chore: update",
  [string]$Source = "./src",
  [string]$AccountName = "pdvstatic",
  [string]$Container = "`$web"
)
$ErrorActionPreference = "Stop"

if (-not (Get-Command az -ErrorAction SilentlyContinue)) { throw "Azure CLI fehlt" }

# 1) Commit (wenn Änderungen vorhanden)
git add -A
$pending = git diff --cached --name-only
if (-not $pending) {
  Write-Host "Keine Änderungen zum Committen." -ForegroundColor Yellow
} else {
  git commit -m $Message
}

# 2) Deploy
az account show 1>$null 2>$null
if ($LASTEXITCODE -ne 0) { throw "Nicht bei Azure angemeldet. Bitte az login." }

az storage blob sync --account-name $AccountName --container $Container --source $Source --auth-mode login --delete-destination false
if ($LASTEXITCODE -ne 0) { throw "Azure Sync fehlgeschlagen" }

Write-Host "Commit + Deploy erfolgreich" -ForegroundColor Green
