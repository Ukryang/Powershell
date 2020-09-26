﻿## GET-UniqProcName.ps1
# 일반 프로세스 추출
Write-Host "{"
Write-Host " `"data`":[`n"

$process = Get-Process -ErrorAction SilentlyContinue |Sort-Object $_.processname |Select-Object Processname
$uniqprocess = $process.processname |Get-Unique
$proccount = ($uniqprocess|measure).Count

foreach($proc in $uniqprocess){
    $line = "{ `"{#PROCESSNAME}`" : `""+$proc+ "`" }"
    if(++$count -ne $proccount){$line += ","}
    Write-Host $line
}
Write-Host "`n]}"

## UserParameter=[key value],powershell -File "[Script Path]"