#Powershell to Post to Slack
#Variables
$Message = Write-Host "What would you like to say?"
$APIKey = "<Your API Key>"
$Channel = "<Slack Channel>"
$UserName = "<Slack User name>"
$Body =  @{
$APIKey ; 
$Channel ; 
$Message ;
$UserName
}
#Run Script
Invoke-RestMethod -Uri https://slack.com/api/chat.postMessage -Body $Body
