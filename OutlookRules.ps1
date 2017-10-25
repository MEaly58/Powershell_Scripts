##Load the Exchnage Management Sanp in
Add-PSSNapin -Name Microsoft.Exchange.Management.PowerShell.E2010
##Set the echange server parameter.
$PSEmailServer = "exchange.Server"
##Enable The Rule
Enable-InboxRule -Mailbox <user>  -Identity "Rule Name"
##Send Email
Send-MailMessage -From "From@work.com" -To "Recipiant@company.com" -Subject "Rules On" -Body "Emails Are forwarded" -Priority High