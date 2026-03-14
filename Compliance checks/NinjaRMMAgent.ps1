$serviceName = "NinjaRMMAgent"
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

# We bepalen de status. Als de service niet bestaat, noemen we het "NotFound".
if ($null -eq $service) {
    $status = "NotFound"
} else {
    $status = $service.Status.ToString()
}

# Maak een object aan voor de output
$hash = @{
    NinjaServiceStatus = $status
}

# Converteer naar JSON (dit is wat Intune uitleest)
return $hash | ConvertTo-Json -Compress