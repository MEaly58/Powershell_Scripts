Import-Module “sqlps”

$smo = 'Microsoft.SqlServer.Management.Smo.'  
$wmi = new-object ($smo + 'Wmi.ManagedComputer').  

# List the object properties, including the instance names.  
$Wmi  

# Enable the TCP protocol on the default instance.  
$uri = "ManagedComputer[@Name='<computer_name>']/ ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"  

<#  Local host 
$uri = "ManagedComputer[@Name='" + (get-item env:\computername).Value + "']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"  
#>

$Tcp = $wmi.GetSmoObject($uri)  
$Tcp.IsEnabled = $true  
$Tcp.Alter()  
$Tcp  

# Enable the named pipes protocol for the default instance.  
$uri = "ManagedComputer[@Name='<computer_name>']/ ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Np']"  
<# Local Host
$uri = "ManagedComputer[@Name='" + (get-item env:\computername).Value + "']/ServerInstance[@Name='MSSQLSERVER']/ServerProtocol[@Name='Tcp']"  
#>

$Np = $wmi.GetSmoObject($uri)  
$Np.IsEnabled = $true  
$Np.Alter()  
$Np  

<# Firewall rule
netsh advfirewall firewall add rule name = SQLPort dir = in protocol = tcp action = allow localport = 1433 remoteip = localsubnet profile = DOMAIN 
#>
