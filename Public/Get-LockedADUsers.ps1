#Requires -Modules ActiveDirectory
#Requires -Version 3.0

function Get-LockedADUsers () {
<#
.SYNOPSIS
 Get Locked AD Users Accounts

.DESCRIPTION
 Get Locked AD Users Accounts
 
 Requirement:
    - Active Directory PowerShell Module

.NOTES
   File Name  : Get-LockedADUsers.ps1
   Version    : 1.2005
   Author     : Andriy Zarevych

   Find me on :
   * My Blog  :	https://angry-admin.blogspot.com/
   * LinkedIn :	https://linkedin.com/in/zarevych/
   * Github   :	https://github.com/zarevych

   Change Log:
   V1.2004    : Initial version
   V1.2005    : Add Get-ADUser Properties badpwdcount, lockoutTime, LockedOut, EmailAddress, Enabled
#>

    Search-ADAccount -Lockedout | 
     Get-ADUser -Properties badPwdCount, lockoutTime, LockedOut, EmailAddress, Enabled |
     Select-Object Name, SamAccountName, UserPrincipalName, DistinguishedName, badPwdCount, LockedOut, EmailAddress, @{ Name = "LockoutTime"; Expression = { ([datetime]::FromFileTime($_.lockoutTime).ToLocalTime()) } }, Enabled |
     Sort-Object Name
} 