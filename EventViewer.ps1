<#!
.SYNOPSIS
	Gather information from envet log on Nas Service failures
.DESCRIPTION
	This script will pull Event log info from the Application Log with a Level of Error and a source of one of the Dynamics Nav Nas Services, including the ErrorCode & the message. 
.NOTES
	File Name: ELNas.ps1
	Author: Mathew Ealy
	Requires Powershell 2.0
.LINK
	https://github.com/MEaly58
#>

#Variables
$Log = "Application"
$Level = "Error"
$Message = "*message*"
#uncomment to save file for review or email
#$File = "C:\Application-Error.csv"
#Uncomment below sections to email file
<#!
$smtpServer="exchange"
$expireindays = 3
$from = "Admin <admin@yourcompany.com>"
$user = "<user@yourcompany.com>"
$Subject = "$HostName Nas Errors"
$body = "Please find attached Nas error log report"
#>

#Script
Get-EventLog -Log $Log -EntryType $Level -Message $Message -After (Get-Date).AddHours(-24) | ConvertTo-CSV #| Out-File $File

#Email File
#Uncomment below sections to email file
<#!
Send-Mailmessage -smtpServer $smtpServer -from $from -to $user -subject $subject -body $body -Attachments $File 
#>
