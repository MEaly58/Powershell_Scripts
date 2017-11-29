#Hits the sapce bar to keepthe ssytem awake
param($minutes = 60)

$myShell = New-Object -com "Wscript.Shell"

for ($i = 0; $i -lt $minutes; $i++) 
{
  Start-Sleep -Seconds 30
  $myShell.sendkeys(" ")
}
<# 
Based on Blog here https://dmitrysotnikov.wordpress.com/2009/06/29/prevent-desktop-lock-or-screensaver-with-powershell/
Hitting "." would cause the system to confirm pop ups not always a good thing (Think Install this virus press yes) 
#>
