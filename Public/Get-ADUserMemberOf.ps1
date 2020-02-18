#Requires -Modules ActiveDirectory
#Requires -Version 3.0

Function Get-ADUserMemberOf () {

<#
.SYNOPSIS
 Get a list of groups for Active Directory user
 
.DESCRIPTION
 Get a list of groups for Active Directory user

 Requirement:
    - ActiveDirectory PowerShell Module
 
 Usage:  
    Get-ADUserMemberOf <UserName>
    Get-ADUser <UserName> | Get-ADUserMemberOf


.PARAMETER User


.EXAMPLE
   Get-ADUserMemberOf -User <UserName>


.NOTES
   File Name  : Get-ADUserMemberOf.ps1
   Version    : 0.1912
   Author     : Andriy Zarevych

   Find me on :
   * My Blog  :	https://angry-admin.blogspot.com/
   * LinkedIn :	https://linkedin.com/in/zarevych/
   * Github   :	https://github.com/zarevych

   Change Log:
   V0.1912    : Initial version
#>



    [CmdletBinding()]
    [OutputType([pscustomobject])]
    param(
        [Parameter(ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        Mandatory = $true,
        Position=0)]
        [ValidateNotNullOrEmpty()]
        #[String]$User = $env:UserName
        $User
    )  

    Process {

        $IsMemberOf = @()
        
        $UserDN = $User.DistinguishedName

        if (-NOT($User.DistinguishedName)) {
            try {
                $User = Get-ADUser $User -ErrorAction Stop
            }
            catch {
                Write-Host $_.Exception.Message`n -ForegroundColor Red
                Exit
            }
        }

        $UserDN = $User.DistinguishedName

        Get-ADGroup -LDAPFilter "(member=$UserDN)" | foreach-object { 
           #$GroupName = $_.Name
           #$IsMemberOf += New-Object -TypeName pscustomobject -Property @{GroupName=$GroupName; GroupType = $_.GroupCategory; DistinguishedName=$_.DistinguishedName}
           $IsMemberOf += New-Object -TypeName pscustomobject -Property @{GroupName=$_.Name; GroupType = $_.GroupCategory; DistinguishedName=$_.DistinguishedName}          
        }

        return $IsMemberOf
    }
}
