## Employee Seperation script for IT
## Load Snap ins for Exchange and AD
Add-PSSNapin -Name Microsoft.Exchange.Management.PowerShell.E2010
Import-Module ActiveDirectory 
## Prompt for variable
$Who = Read-Host 'User account to remove'
$Forward = Read-Host 'Forward Emails to whom?'
$oof = Get-Content -RAW c:\GoodBye_oof.txt
## Set out of office
Set-MailboxAutoReplyConfiguration $Who -AutoReplyState Enabled -ExternalMessage $oof -InternalMessage $oof
## Forward Emails
Set-Mailbox $Who -ForwardingAddress $Forward -DeliverToMailboxAndForward $True
## Move user to inactive accounts in AD
Get-AdUser $Who | Move-ADObject -TargetPath 'OU=Closed Accounts,DC=xyz,DC=ad,DC=company,DC=com'
Disable-Adaccount $Who
##Send Email
Send-MailMessage -From "administrator@yourcompany.com" -To "you@yourcompany.com" -Subject "$Who disabled account" -Body "$Who emails being forwarded to $Forward" -Priority High