## Get-ProcName2.ps1
# 중복된 프로세스 명이 존재할 시 사용
Write-Host "{"
Write-Host " `"data`":[`n"

$process = Get-Process -ErrorAction SilentlyContinue |Sort-Object $_.processname |Select-Object Processname
$count = 0
$count2 = 0
$proccount = ($uniqprocess|measure).Count
$prename = $null

foreach($proc in $process){
    if($prename -eq $null -or $prename -eq $proc.ProcessName){
        if($count -eq 0){
            $name = $proc.ProcessName
        } else{
            $name = $proc.ProcessName + "#$count"
        }
    } else{
        $count = 0
        $name = $proc.ProcessName
    }
    $count++
    $prename = $proc.ProcessName
    $line = "{ `"{#PROCESSNAME}`" : `""+ $name + "`" }"
    if(++$count2 -ne $proccount){$line += ","}
    Write-Host $line
}
Write-Host "`n]}"

## UserParameter=[key value],powershell -File "[Script Path]"