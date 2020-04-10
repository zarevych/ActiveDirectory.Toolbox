#Requires -Modules ActiveDirectory

function Unlock-ADUsers {

<#
.SYNOPSIS
 Unlock all Active Directory user accounts 

.DESCRIPTION 
 Unlock all Active Directory user accounts 
 
 Requirement:
 - Active Directory PowerShell Module  

   File Name  : Unlock-ADUsers.ps1
   Author     : Andriy Zarevych

   Find me on :
   * My Blog  :	https://angry-admin.blogspot.com/
   * LinkedIn :	https://linkedin.com/in/zarevych/
   * Github   :	https://github.com/zarevych
#>

    [CmdletBinding()]
    Param (
    )

    Search-ADAccount -lockedout | Unlock-ADAccount
}
