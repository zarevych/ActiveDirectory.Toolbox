#Requires -Modules ActiveDirectory
#Requires -Version 3.0

Function Get-ADGroupMemberCount () {
<#
.SYNOPSIS
 Get AD Group Memberships Count

.DESCRIPTION
 Get AD Group Memberships Count
 
 Requirement:
    - Active Directory PowerShell Module

.PARAMETER Group
    Set AD group name

.NOTES
   File Name  : Get-ADGroupMemberCount.ps1
   Author     : Andriy Zarevych

   Find me on :
   * My Blog  :	https://angry-admin.blogspot.com/
   * LinkedIn :	https://linkedin.com/in/zarevych/
   * Github   :	https://github.com/zarevych
#>

    [CmdletBinding()]
    [Alias("Get-Get-ADGroupMembershipCount")]

    param(
        [Parameter(Mandatory = $true,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0)]
        [ValidateNotNullOrEmpty()]
        [Alias('ADGroup','GroupName')]
        [string] $Group
    )

#    $ADGroup = Get-ADGroupMember $ADGroup -recursive
#    $ADGroup.Count
    (Get-ADGroupMember $ADGroup -recursive).Count
}
