#Load AD Module
Import-Module ActiveDirectory
#Varibles
$Name = Read-Host "Account to look up?"
$File = "C:\Groupsfor$Name.txt"
#Run script
Get-ADPrincipalGroupMembership username | select $Name | Out-file $File 
