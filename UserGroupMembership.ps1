<#
.SYNOPSIS
    Simple script to produce a listing of user's group memberships
.DESCRIPTION
    Script will create a simple listing of a user's group memberships.
    Output is in object format so you can use other Powershell cmdlet's
    with the output, such as Export-CSV, Out-File, ConvertTo-HTML, etc.
    
    Groups are presented using the friendly name, and are sorted
    alphabetically.
.PARAMETER User
    Name of the user you want to list
.INPUTS
    Pipeline
    Get-ADUser    
.OUTPUTS
    PSObject    User Name
                Group Name
.EXAMPLE
    .\Get-UserGroupMembership.ps1 -User thesurlyadmin
    List all of the groups for "thesurlyadmin"
.NOTES
    Author:            Martin Pugh
    Twitter:           @thesurlyadm1n
    Spiceworks:        Martin9700
    Blog:              www.thesurlyadmin.com
       
    Changelog:
       1.0             Initial Release
.LINK
    http://community.spiceworks.com/scripts/show/1872-get-user-group-memberships
#>
<#
Script will create a simple listing of a user's group memberships. 
Output is in object format so you can use other Powershell cmdlet's with the output, such as Export-CSV, Out-File, ConvertTo-HTML, etc. 
#>

Param (
    [Parameter(Mandatory=$true,ValueFromPipeLine=$true)]
    [Alias("ID","Users","Name")]
    [string[]]$User
)
Begin {
    Try { Import-Module ActiveDirectory -ErrorAction Stop }
    Catch { Write-Host "Unable to load Active Directory module, is RSAT installed?"; Break }
}

Process {
    ForEach ($U in $User)
    {   $UN = Get-ADUser $U -Properties MemberOf
        $Groups = ForEach ($Group in ($UN.MemberOf))
        {   (Get-ADGroup $Group).Name
        }
        $Groups = $Groups | Sort
        ForEach ($Group in $Groups)
        {   New-Object PSObject -Property @{
                Name = $UN.Name
                Group = $Group
            }
        }
    }
}
