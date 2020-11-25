#Requires -Modules ActiveDirectory
#Requires -Version 2.0

Function Get-ADUserPrimaryGroup {
<#
.SYNOPSIS
 Get AD user primary group

.DESCRIPTION
 Get AD user primary group

 Requirement:
 - Active Directory PowerShell Module  

.NOTES
 File Name  : Get-ADUserPrimaryGroup
 Author     : Andriy Zarevych
#>

    [CmdletBinding()]

    param(
        [Parameter(ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        Mandatory = $true,
        Position=0)]
        [ValidateNotNullOrEmpty()]     
        [Alias('UserName','Name')]
        [String]$User = $env:USERNAME,

        [Parameter(Mandatory=$False)]
        [switch]$Info
    )  

    If ($Info.IsPresent) {
        $Group = Get-ADUser $User -Properties PrimaryGroup, PrimaryGroupID | Select-Object PrimaryGroup, PrimaryGroupID
        $GroupID = $Group.PrimaryGroupID
        #$GroupDN = $Group.PrimaryGroup
        $Group = Get-ADObject $Group.PrimaryGroup
        #$Group
        New-Object PSObject -Property @{
            Name = $Group.Name
            DistinguishedName = $Group.DistinguishedName
            ObjectClass = $Group.ObjectClass
            ObjectGUID = $Group.ObjectGUID
            PrimaryGroupID = $GroupID
        }
    }
    else {
        $Group = Get-ADUser $User -Properties PrimaryGroup, PrimaryGroupID | Select-Object PrimaryGroup
        $Group = Get-ADObject $Group.PrimaryGroup | Select-Object Name
        $Group.Name       
    }
}
