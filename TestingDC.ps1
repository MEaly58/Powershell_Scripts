#Requires -Version 5.1
Write-Host "If you see this, you are running Version 5.1"
###################################################################################################
#Powershell script to test dc connections
#Variables uncomment to connecto to specific DC
#$DCServer = READ-HOST -Prompt "DC to check"
#Folder location variable
#Script runs saving to logged in users desktop uncomment varaible & comment defined path to change this
#$FOLDERLOC = READ-HOST -Prompt "Folder Path?"
####################################################################################################
$FOLDERLOC = $env:userprofile\Desktop\Outfile.txt
#Script for detailed info
TEST-ComputerSecureChannel -verbose | Out-File -filepath $FOLDERLOC

#Script to reconnect
Set-Alias tcsc Test-ComputerSecureChannel
if (!(tcsc))
{Test-ComputerSecureChannel -Repair}
else {Write-Host "Connection Confirmed"}
