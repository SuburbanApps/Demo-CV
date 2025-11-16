param(
    # Si lo llamas con -SkipTests no ejecutará Test-Entorno.ps1
    [switch]$SkipTests
)

# Rutas base
$root       = "C:\DevopsCurso"
$apiPath    = Join-Path $root "DevOpsCurso.Api"
$frontPath  = Join-Path $root "devops-front"
$testScript = Join-Path $root "Test-Entorno.ps1"

function Write-Info([string]$msg) {
    $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$ts] $msg" -ForegroundColor Cyan
}

Write-Info "=== INICIO DEMO CV ==="

# 1) Asegurar que SQL Server está arrancado
Write-Info "Comprobando servicios de SQL Server..."

$services = @("MSSQLSERVER","DEVOPS")   # uno de los dos será el tuyo
foreach ($svcName in $services) {
    $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
    if ($null -ne $svc) {
        if ($svc.Status -ne "Running") {
            Write-Info "Arrancando servicio SQL '$svcName'..."
            Start-Service $svcName
        } else {
            Write-Info "Servicio SQL '$svcName' ya está en ejecución."
        }
    }
}

# 2) Lanzar la API .NET en otra ventana de PowerShell
Write-Info "Lanzando API .NET en puerto 5000 (nueva ventana)..."
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "cd '$apiPath'; dotnet run"
) | Out-Null

# 3) Lanzar el front Angular en otra ventana
Write-Info "Lanzando front Angular en puerto 4200 (nueva ventana)..."
Start-Process powershell -ArgumentList @(
    "-NoExit",
    "-Command",
    "cd '$frontPath'; ng serve --port 4200"
) | Out-Null

# 4) Esperar a que todo arranque
Write-Info "Esperando a que arranquen API y front (20s)..."
Start-Sleep -Seconds 20

# 5) Ejecutar el test de entorno (si existe y no se ha pedido omitir)
if (-not $SkipTests -and (Test-Path $testScript)) {
    Write-Info "Ejecutando Test-Entorno.ps1..."
    & $testScript
} else {
    Write-Info "Saltando Test-Entorno.ps1 (no existe o se ha pasado -SkipTests)."
}

# 6) Abrir navegador con Swagger y el front
Write-Info "Abriendo navegador con Swagger y listado de usuarios..."
Start-Process "http://localhost:5000/swagger/index.html"
Start-Process "http://localhost:4200/users"

Write-Info "=== DEMO LISTA: API + Front funcionando. Puedes empezar a enseñar. ==="
