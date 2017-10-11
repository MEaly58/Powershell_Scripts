#Load AD Module
Import-
#Request User
$Name = Read-Host "Account to look up?"
Get-ADPrincipalGroupMembership username | select $Name
