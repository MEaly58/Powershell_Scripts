# This script must be run as Administrator

cls

#set paths
$outpath = $PSScriptRoot
$outpathremove = $outpath + "\RemoveIt.txt"
$outpathkeep = $outpath + "\KeepIt.txt"

#make sure lists are empty
$RemoveIt=""
$KeepIt=""

#read lists from files
$RemoveIt = Get-Content $outpathremove -ErrorAction SilentlyContinue
$KeepIt = Get-Content $outpathkeep -ErrorAction SilentlyContinue

#if list(s) still empty assume file does not exist and use default data
if ($KeepIt.count -eq 0)
    {
        $KeepIt = "Microsoft.Appconnector","Microsoft.ConnectivityStore","Microsoft.DesktopAppInstaller","Microsoft.Messaging","Microsoft.Microsoft3DViewer","Microsoft.MicrosoftStickyNotes","Microsoft.MSPaint","Microsoft.OneConnect","Microsoft.People","Microsoft.StorePurchaseApp","Microsoft.Wallet","Microsoft.WindowsStore","Microsoft.windowscommunicationsapps","Microsoft.WindowsCalculator","Microsoft.WindowsAlarms"
    }
if ($RemoveIt.count -eq 0)
    {
        $RemoveIt = "Microsoft.3DBuilder","Microsoft.BingFinance","Microsoft.BingNews","Microsoft.BingSports","Microsoft.BingWeather","Microsoft.CommsPhone","Microsoft.Getstarted","Microsoft.MicrosoftOfficeHub","Microsoft.MicrosoftSolitaireCollection","Microsoft.Office.OneNote","Microsoft.Office.Sway","Microsoft.SkypeApp","Microsoft.WindowsCamera","Microsoft.WindowsFeedbackHub","Microsoft.WindowsMaps","Microsoft.WindowsPhone","Microsoft.WindowsSoundRecorder","Microsoft.XboxApp","Microsoft.XboxGameOverlay","Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay","Microsoft.ZuneMusic","Microsoft.ZuneVideo"
    }

#get list of provisioned packages
$App = Get-AppxProvisionedPackage -online

#process the packages
foreach  ($package in $app)
    {
        if ($RemoveIt -contains $package.Displayname)
            {
                #It is in the list of safe to remove so remove it
                Remove-AppXProvisionedPackage -Online -PackageName $package.PackageName
                write-host "Removed " $package.PackageName
            }
        else 
            {
                if ($KeepIt -notcontains $package.Displayname) #If it is not in the list of MUST Keep then
                    {
                        #Ask if OK to remove
                        write-host
                        write-host $package.Displayname
                        $ans=read-host "Delete Y/y/any other input aborts"
                        if ($ans -like "y") # if answer is 'y' or 'Y'
                            {
                                #add to list of 'Safe to Remove' apps
                                $RemoveIt+=$Package.Displayname
                                #remove it    
                                Remove-AppxProvisionedPackage -online -packagename $package.Packagename
                                write-host "Removed ++ " $package.PackageName

                            }
                        else  #Not ok to remove so add to list of 'Must Keep' apps
                            {
                                $keepIt+=$package.DisplayName
                                write-host "                     Kept " $package.PackageName
                            }
                    }
            }
    }                                                                                                                                                                                                
out-file $outpathremove -InputObject $RemoveIt 
out-file $outpathkeep -InputObject $KeepIt 


write-host "press enter"
read-host