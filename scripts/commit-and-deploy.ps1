param(
  [string]$Message = "chore: update",
  [string]$Source = "./src",
  [string]$AccountName = "pdvstatic",
  [string]$Container = "`$web"
)
$ErrorActionPreference = "Stop"

# 1) Commit (wenn Änderungen vorhanden)
git add -A
$pending = git diff --cached --name-only
if (-not $pending) {
  Write-Host "Keine Änderungen zum Committen." -ForegroundColor Yellow
} else {
  git commit -m $Message
}

# 2) Deploy
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\deploy-dev.ps1 -Source $Source -AccountName $AccountName -Container $Container

Write-Host "Commit + Deploy erfolgreich" -ForegroundColor Green
