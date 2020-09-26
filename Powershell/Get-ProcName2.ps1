## Get-ProcName2.ps1
# 중복된 프로세스 명이 존재할 시 사용
$Restr = [string]::Empty
$Restr = "{`"data`":["

$process = Get-Process -ErrorAction SilentlyContinue |Sort-Object $_.processname |Select-Object Processname
$count = 0
$count2 = 0
$proccount = ($process|measure).Count
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

    $Restr = $Restr + "{ `"{#PROCESSNAME}`" : `""+ $name + "`" }"
    if(++$count2 -ne $proccount){$Restr += ","}
}
$Restr = $Restr + "]"
$Restr = $Restr + "}"

$fullpath = $MyInvocation.MyCommand.Definition
$scriptname = $MyInvocation.MyCommand.Name
$path = $fullpath.Replace($scriptname, "myProcess.txt")
[System.IO.File]::WriteAllLines($path, $Restr)