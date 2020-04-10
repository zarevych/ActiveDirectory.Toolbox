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
   Author     : Andriy Zarevych

   Find me on :
   * My Blog  :	https://angry-admin.blogspot.com/
   * LinkedIn :	https://linkedin.com/in/zarevych/
   * Github   :	https://github.com/zarevych
#>

    Search-ADAccount -Lockedout |
    Select-Object Name, SamAccountName, UserPrincipalName, DistinguishedName | Sort-Object Name | Format-Table -AutoSize
    #Select-Object Name, SamAccountName, UserPrincipalName, DistinguishedName #| Sort-Object Name | Format-Table -AutoSize
} 