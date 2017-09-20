#Load Module
Import-Module ActiveDirectory
#Variables
$DomainName = Read-Host "Domain name:"
$ComputerName = Read-Host "Computer name:"
$UserName = Read-Host "User name:"
#Add user to local admin group (Uses the ADSI adapter)
$AdminGroup = [ADSI]"WinNT://$ComputerName/Administrators,group"
$User = [ADSI]"WinNT://$DomainName/$UserName,user"
$AdminGroup.Add($User.Path)
