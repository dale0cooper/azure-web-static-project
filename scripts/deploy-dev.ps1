param(
  [string]$Source = "./src",
  [string]$AccountName = "pdvstatic",
  [string]$Container = "`$web",
  [switch]$DeleteDestination
)

$ErrorActionPreference = "Stop"

function Get-AzCli {
  $cmd = Get-Command az -ErrorAction SilentlyContinue
  if ($cmd) { return "az" }
  $fallback = "C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\az.cmd"
  if (Test-Path $fallback) { return $fallback }
  throw "Azure CLI (az) nicht gefunden."
}

$az = Get-AzCli

if (-not (Test-Path $Source)) {
  throw "Source-Pfad nicht gefunden: $Source"
}

& $az account show 1>$null 2>$null
if ($LASTEXITCODE -ne 0) {
  Write-Host "Keine aktive Azure-Session. Bitte zuerst: az login" -ForegroundColor Yellow
  exit 1
}

$deleteFlag = if ($DeleteDestination) { "true" } else { "false" }

Write-Host "Deploy nach Azure Storage..." -ForegroundColor Cyan
Write-Host "Account: $AccountName | Container: $Container | Source: $Source | Delete: $deleteFlag"

& $az storage blob sync `
  --account-name $AccountName `
  --container $Container `
  --source $Source `
  --auth-mode login `
  --delete-destination $deleteFlag

if ($LASTEXITCODE -ne 0) {
  throw "Deployment fehlgeschlagen."
}

Write-Host "Deployment erfolgreich." -ForegroundColor Green
