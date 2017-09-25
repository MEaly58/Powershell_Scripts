##################################################################################################################
#
#Variables Go Here
#
$smtpServer="exchange"
$expireindays = 3
$from = "Admin <admin@yourcompany.com>"
#This script emails a manager that a direct report has an expiring password and has ignored requests to change the password. 
#
###################################################################################################################

#Get Ad Users who have Passsword experations set
Import-Module ActiveDirectory
$users = get-aduser -Filter * -Properties Name, PasswordNeverExpires, PasswordExpired, PasswordLastSet, EmailAddress |Where {$_.Enabled -eq "True"} | where { $_.PasswordNeverExpires -eq $false } | where { $_.passwordexpired -eq $false }
$DefaultmaxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge

#Process Each User For Pasword Expiry
foreach ($user in $users)
{
    $Name = $user.Name
    $passwordSetDate = $user.PasswordLastSet
    $PasswordPol = (Get-AduserResultantPasswordPolicy $user)
    # Check for Fine Grained Password
    if (($PasswordPol) -ne $null)
    {
        $maxPasswordAge = ($PasswordPol).MaxPasswordAge
    }
    else
    {
        # No FGP set to Domain Default
        $maxPasswordAge = $DefaultmaxPasswordAge
    }

  
    $expireson = $passwordsetdate + $maxPasswordAge
    $today = (get-date)
    $daystoexpire = (New-TimeSpan -Start $today -End $Expireson).Days

	#Get Manager email
    $Manager = (Get-ADUser -Identity dcollison -Properties manager |
    Select-Object -ExpandProperty manager |
    Get-ADUser -Properties mail |
    Select-Object mail | out-string ) 

    # Set Greeting based on Number of Days to Expiry.

    # Check Number of Days to Expiry
    $messageDays = $daystoexpire

    if (($messageDays) -ge "1")
    {
        $messageDays = "in " + "$daystoexpire" + " days."
    }
    else
    {
        $messageDays = "today."
    }

    # Email Subject Set Here
    $subject="$Name has a password that will expire $messageDays"
  
    # Email Body Set Here, Note You can use HTML, including Images.
    $body ="
    <p>Your Direct Report $name has a password that will expire $messageDays.<br>
    Please advice them that they will not be able to log in after their password expires.<br>
    <p>Thanks, <br> 
    IT</P>"

 
    # Send Email Message
    if (($daystoexpire -ge "0") -and ($daystoexpire -lt $expireindays))
    {
    # Send Email Message
        Send-Mailmessage -smtpServer $smtpServer -from $from -to $manager -cc it@yourcompany.com -subject $subject -body $body -bodyasHTML -priority High  

    } # End Send Message
    
} # End User Processing
