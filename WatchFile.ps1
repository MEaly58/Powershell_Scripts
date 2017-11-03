<#
We setup a witness file at the root of our main share with its twin in a read-only area for reference. 
On start we make sure both files are identical. 
We setup a watcher routine using System.IO.FileSystemWatcher to trigger an event on a modification in our root file share. 
We make sure both are not identical, we kill the LanmanServer service and send out an email warning.
#########
Schedule task set up
    powershell.exe  -command C:\Support\watchfile.ps1 -ExecutionPolicy Bypass
#>

## Variables
$ErrorActionPreference = "Stop"
$originalpath = "\\path\to\file"   
$originalfile = "AA_DO_Not_Delete.docx" 
$witnesspath = "\\path\to\file"
$witnessfile = $originalfile

## SEND MAIL FUNCTION
function sendMail($s, $to) {
    $smtpServer = "exchangeserver.com"
    $smtpFrom = "contact@email.com"
    $smtpTo = $to

    $messageSubject = $s[0]
    $message = New-Object System.Net.Mail.MailMessage $smtpfrom, $smtpto
    $message.Subject = $messageSubject
    $message.IsBodyHTML = $false
    $message.Body = $s[1]

    $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
    $smtp.Send($message)
}

 ##Check original files
 try {
    $origin = Get-Content "$originalpath\$originalfile"
    $witness = Get-Content "$witnesspath\$witnessfile"
}
catch
    {
    ## Probably a file not found error
    $subject = "Error logged on $Witnesspath\$Witnessfile by $env:username on $env:computername"
    $body = "The original or witness file has not been found.  Aborting monitor script."
    $email =@($subject,$body)
    sendMail -s $email -to "contact2@email.com"
    Exit
}


## If files don't match, then Send messaged and quit
if (Compare-Object $origin $witness){
    ## files don't match
    $subject = "Error logged on $witnesspath\$witnessfile by $env:username on $env:computername"
    $body = "The original file does not match the witness file.  Aborting monitor script."
    $email =@($subject,$body)
    sendMail -s $email -to "contact2@email.com"
    Exit
}


## CREATE WATCHER ON DIRECTORY
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $witnesspath
$watcher.IncludeSubdirectories = $false
$watcher.EnableRaisingEvents = $false
$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite -bor [System.IO.NotifyFilters]::FileName

## Execute Watcher
while($TRUE){
    $result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::Changed `
        -bor [System.IO.WatcherChangeTypes]::Renamed `
        -bor [System.IO.WatcherChangeTypes]::Deleted `
        -bor [System.IO.WatcherChangeTypes]::Created, 1000);
    if ($result.TimedOut){
        continue;
    }

    if ($result.Name -eq $witnessfile) {
        ### Make sure the files do not match
        try {
            $origin = Get-Content "$originalpath\$originalfile"
            $witness = Get-Content "$witnesspath\$witnessfile"
            if (Compare-Object $origin $witness){
                ## files don't match
                $body = "Witness file $witnesspath\$witnessfile on $env:computername has been modified."
            }
        }
        catch {
            ## file deleted
            $body = "Witness file $witnesspath\$witnessfile on $env:computername has been deleted"
        }
        finally {
            ## scorched earth - disconnect all shares
            Stop-Service "RandomService" -force
            $subject = "EMERGENCY ON FILE SERVER -- $Witnesspath\$Witnessfile by $env:username on $env:computername"
            $email =@($subject,$body)
            sendMail -s $email -to "contact2@email.com"
            sendMail -s $email -to "contact@email.com"
            Exit
        }

    }

}
