<#!
.SYNOPSIS
	Delete all files older than X days in set path
.DESCRIPTION
	This is a server side script to clean up older files after a set number of days controlled in the $DaysBack Varriable 
.NOTES
	File Name: Delete_OlderThan.ps1
	Author: Mathew Ealy
	Requires Powershell 2.0
.LINK
	https://github.com/MEaly58
#>

#Variables
$Path = "C:\Folder_Path"
$DaysBack = "-XX"

#Date Calculations
$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($DaysBack) 

#Script
Get-ChildItem $Path | Where-Object {$_.LastWriteTime -lt $DatetoDelete } | Remove-Item
