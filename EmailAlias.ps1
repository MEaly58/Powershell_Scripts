#get mailboxes and iterate through each email address and shows it either primary or an alias
#Add snap in's This is for exchange 2010
Add-PSSNapin -Name Microsoft.Exchange.Management.PowerShell.E2010
#Execute script
get-mailbox | foreach{ 

 $host.UI.Write("Blue", $host.UI.RawUI.BackGroundColor, "`nUser Name: " + $_.DisplayName+"`n")

 for ($i=0;$i -lt $_.EmailAddresses.Count; $i++)
 {
    $address = $_.EmailAddresses[$i]
    
    $host.UI.Write("Blue", $host.UI.RawUI.BackGroundColor, $address.AddressString.ToString()+"`t")
 
    if ($address.IsPrimaryAddress)
    { 
    	$host.UI.Write("Green", $host.UI.RawUI.BackGroundColor, "Primary Email Address`n")
    }
   else
   {
    	$host.UI.Write("Green", $host.UI.RawUI.BackGroundColor, "Alias`n")
    }
 }
}