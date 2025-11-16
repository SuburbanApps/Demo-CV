param(
    [string]$ProjectPath    = "C:\DevopsCurso\DevOpsCurso.Api",
    [string]$PublishPath    = "C:\DevopsCurso\out-api2",
    [string]$IisSiteName    = "DevOpsApi2",
    [string]$IisDestination = "C:\inetpub\wwwroot\api"
)

Write-Host "===== DEPLOY API ====="

Import-Module WebAdministration

Write-Host "Publicando API desde $ProjectPath a $PublishPath ..."
dotnet publish $ProjectPath -c Release -f net8.0 -o $PublishPath

Write-Host "Parando sitio IIS '$IisSiteName' ..."
Stop-Website -Name $IisSiteName -ErrorAction SilentlyContinue

Write-Host "Limpiando carpeta destino (salvo web.config si existe) ..."

# Si existe web.config en IIS, lo guardamos en memoria
$webConfigPath = Join-Path $IisDestination "web.config"
$hasWebConfig = Test-Path $webConfigPath
if ($hasWebConfig) {
    Write-Host "   -> web.config existente será preservado"
    $webConfig = Get-Content $webConfigPath -Raw
}

# Borramos TODO el destino
Remove-Item "$IisDestination\*" -Recurse -Force -ErrorAction SilentlyContinue

# Copiamos todo lo publicado
Write-Host "Copiando ficheros publicados a $IisDestination ..."
Copy-Item -Path "$PublishPath\*" -Destination $IisDestination -Recurse -Force

# Si teníamos un web.config previo, lo volvemos a dejar
if ($hasWebConfig) {
    Write-Host "Restaurando web.config previo ..."
    $webConfig | Set-Content -Path $webConfigPath -Encoding UTF8
}

Write-Host "Arrancando sitio IIS '$IisSiteName' ..."
Start-Website -Name $IisSiteName

Write-Host "===== DEPLOY API COMPLETADO ====="
