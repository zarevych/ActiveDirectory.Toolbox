#Test-ADUser/Check-ADUser v.0.2002

#Requires -Modules ActiveDirectory
#Requires -Version 2.0

Function Test-ADUser {

    [CmdletBinding()]
    [OutputType([bool])]

    param(
        [Parameter(ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        Mandatory = $true,
        Position=0)]
        [ValidateNotNullOrEmpty()]     
        [Alias('UserName','Name')]
        [String]$User = $env:USERNAME
    )  

    Write-Verbose "Check AD User: $User"
    try {
        if (Get-ADUser $User) {
            Write-Verbose "Find object: $user"
            Return $true
        }
    }
    catch {
        Write-Verbose $_.Exception.Message
        Return $false
    }
}
