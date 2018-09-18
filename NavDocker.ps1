<#
Run Powershell as Admin
#>

#Remote into Nano Server
# Variables
#Nano Server IP
$ip = "127.0.0.1"
#
Set-Item WSMan:\localhost\Client\TrustedHosts "$ip" -Force
Enter-PSSession -ComputerName $ip -Credential "~\Administrator"
#Enter password

#Scan for updates to Nano Server
$ci = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession

$result = $ci | Invoke-CimMethod -MethodName ScanForUpdates -Arguments @{SearchCriteria="IsInstalled=0";OnlineScan=$true}

$result.Updates

#Update Windows
$ci = New-CimInstance -Namespace root/Microsoft/Windows/WindowsUpdate -ClassName MSFT_WUOperationsSession
Invoke-CimMethod -InputObject $ci -MethodName ApplyApplicableUpdates
Restart-Computer; exit

#Install Docker
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider
Restart-Computer -Force


#Download Nav Docker Image
docker pull microsoft/dynamics-nav:2018
docker images
docker run -e accept_eula=Y -m 4G microsoft/dynamics-nav
