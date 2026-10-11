# Version PowerShell de watch.sh (Windows). Lancer dans un second terminal.
$js = 'const h=db.hello(); print(h.isWritablePrimary ? "PRIMARY" : (h.secondary ? "SECONDARY" : "AUTRE"))'
while ($true) {
  $line = (Get-Date -Format "HH:mm:ss") + "  "
  foreach ($n in "mongo2","mongo3") {
    $r = docker exec $n mongosh --quiet --eval $js 2>$null
    if (-not $r) { $r = "injoignable" }
    $line += "$n=$r   "
  }
  Write-Host $line
  Start-Sleep -Seconds 1
}
