#Requires -Modules ActiveDirectory
#Requires -Version 3.0


Function Test-ADGroup {

<#

.SYNOPSIS
 Test if exist AD group

.DESCRIPTION 
 Test if exist AD group

 Requirement:
 - Active Directory PowerShell Module  

.NOTES
 File Name  : Test-ADGroup.ps1
 Author     : Andriy Zarevych

#>


    [CmdletBinding()]
    [OutputType([bool])]

    param(
        [Parameter(ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        Mandatory = $true,
        Position=0)]
        [ValidateNotNullOrEmpty()]     
        [String]$Group
    )  

    try {
        if (Get-ADGroup -Identity $Group) {
            Write-Verbose "AD Group $Group exists "
            Return $true
        }
    }
    catch {
        Write-Verbose $_.Exception.Message
        Return $false
    }
}
