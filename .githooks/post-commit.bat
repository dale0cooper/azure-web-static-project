@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0\..\scripts\deploy-dev.ps1" -Source "%~dp0\..\src" -AccountName "pdvstatic" -Container "$web"
