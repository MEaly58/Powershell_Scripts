#Import the module for Active Directory 
import-Module ActiveDirectory

#Enter log in name for user to mirror
$copy = Read-host "Enter username to copy from: "

#Enter log in name to copy to
$paste  = Read-host "Enter username to copy to: "

# copy-paste process. Get-ADuser membership     | then selecting membership                       | and add it to the second user
get-ADuser -identity $copy -properties memberof | select-object memberof -expandproperty memberof | Add-AdGroupMember -Members $paste
