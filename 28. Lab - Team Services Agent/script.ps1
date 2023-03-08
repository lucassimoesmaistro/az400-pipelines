Install-WindowsFeature -name Web-Server -IncludeManagementTools
Write-Output "Installed IIS"

New-Item -Path "D:\" -Name "tmp" -ItemType "directory"
$Path = "D:\tmp\"
$Url = "https://templatestore465656.blob.core.windows.net/installers/dotnet-hosting-6.0.8-win.exe"

$Location = $Path + [System.IO.Path]::GetFileName($Url)
Invoke-WebRequest -Uri $Url -OutFile $Location

Start-Process -FilePath $Location -Wait -ArgumentList /passive
net stop was /y
net start w3svc
Write-Output "Installed Hosting Bundle"


