$ErrorActionPreference = "Stop"

$Source = $PSScriptRoot
$OpenCodeDir = Join-Path $HOME ".config\opencode"

Write-Host "== Sincronizando configuración de OpenCode =="

New-Item -ItemType Directory -Force -Path $OpenCodeDir | Out-Null
New-Item -ItemType Directory -Force -Path "$OpenCodeDir\skills" | Out-Null

Copy-Item "$Source\opencode\opencode.jsonc" "$OpenCodeDir\opencode.jsonc" -Force
Copy-Item "$Source\opencode\AGENTS.md" "$OpenCodeDir\AGENTS.md" -Force

if (Test-Path "$Source\opencode\skills") {
    Copy-Item "$Source\opencode\skills\*" "$OpenCodeDir\skills" -Recurse -Force
}

Write-Host "== Instalando ccusage =="

if (-not (Get-Command ccusage -ErrorAction SilentlyContinue)) {
    npm install -g ccusage
}

Write-Host "== Instalando RTK =="

if (-not (Get-Command rtk -ErrorAction SilentlyContinue)) {
    winget install --exact --id rtk-ai.rtk
}

Write-Host "== Verificando Graphify =="

if (-not (Get-Command graphify -ErrorAction SilentlyContinue)) {
    Write-Warning "Graphify no está instalado. Instálalo con el método oficial que uses en Windows."
}

Write-Host ""
Write-Host "Listo. Verifica:"
Write-Host "  opencode --version"
Write-Host "  ccusage --help"
Write-Host "  rtk --version"
Write-Host "  graphify --help"