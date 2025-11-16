# ===============================
# Test-Entorno.ps1 (versión CI estable)
# ===============================

$logPath = "Test-Entorno.log"
$global:HasErrors = $false

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $line = "[$timestamp] $Message"
    Write-Host $line
    Add-Content -Path $logPath -Value $line
}

Write-Log "Inicio de las comprobaciones"

# 1) W3SVC
Write-Log "Comprobando servicio W3SVC"
$w3svc = Get-Service W3SVC -ErrorAction SilentlyContinue
if ($w3svc) {
    Write-Log "Servicio W3SVC: $($w3svc.Status)"
} else {
    Write-Log "ERROR: Servicio W3SVC no encontrado"
    $global:HasErrors = $true
}

# 2) Puerto API (5000)
Write-Log "Comprobando puerto 5000"
$apiPort = Test-NetConnection -ComputerName 127.0.0.1 -Port 5000 -WarningAction SilentlyContinue
if ($apiPort.TcpTestSucceeded) {
    Write-Log "Puerto 5000 accesible"
} else {
    Write-Log "ERROR: Puerto 5000 no accesible"
    $global:HasErrors = $true
}

# 3) Puerto SQL (1433)
Write-Log "Comprobando puerto 1433"
$sqlPort = Test-NetConnection -ComputerName 127.0.0.1 -Port 1433 -WarningAction SilentlyContinue
if ($sqlPort.TcpTestSucceeded) {
    Write-Log "Puerto 1433 accesible"
} else {
    Write-Log "ERROR: Puerto 1433 no accesible"
    $global:HasErrors = $true
}

# 4) Test de API
Write-Log "Prueba funcional API /api/Users"
try {
    $resp = Invoke-WebRequest -Uri "http://localhost:5000/api/Users" -TimeoutSec 5
    if ($resp.StatusCode -eq 200) {
        Write-Log "API responde con 200 OK"
    } else {
        Write-Log "ERROR: API respondio codigo $($resp.StatusCode)"
        $global:HasErrors = $true
    }
}
catch {
    Write-Log "ERROR: No se pudo llamar a la API: $($_.Exception.Message)"
    $global:HasErrors = $true
}

# 5) Test SQL (solo si existe sqlcmd)
Write-Log "Prueba funcional SQL con sqlcmd"
$sqlcmdExists = Get-Command sqlcmd -ErrorAction SilentlyContinue
if ($sqlcmdExists) {
    $query = "SET NOCOUNT ON; SELECT COUNT(*) FROM dbo.Users;"
    $res = sqlcmd -S localhost -d DevOpsCurso -E -Q $query -h -1 -W 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Log "SQL OK. Resultado: $res"
    } else {
        Write-Log "ERROR ejecutando sqlcmd: $res"
        $global:HasErrors = $true
    }
} else {
    Write-Log "sqlcmd no encontrado, omitiendo prueba SQL"
}

# Resultado final
if ($global:HasErrors) {
    Write-Log "RESULTADO FINAL: ERROR"
    exit 1
} else {
    Write-Log "RESULTADO FINAL: OK"
    exit 0
}
