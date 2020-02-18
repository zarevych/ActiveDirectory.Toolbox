#Requires -Modules ActiveDirectory
#Requires -Version 3.0


Function Get-ADComputerLAPSInfo () {

<#
.SYNOPSIS
 Get Computer LAPS Passwords information from Active Directory.

.DESCRIPTION
 Get LAPS Passwords information from Active Directory.
 ComputerName;Password;PasswordExpTime

 Requirement of the script:
    - Active Directory PowerShell Module
    - Needed rights to view AD LAPS Attributes: ms-Mcs-AdmPwd, ms-Mcs-AdmPwdExpirationTime
   

 Usage:
    Get-ADComputerLAPSInfo -ComputerName COMPUTER1
    Get-ADComputerLAPSInfo COMPUTER1, COMPUTER2
 

.PARAMETER ComputerName   
    Optional parameter to view computer LAPS info
 

.EXAMPLE
   Get-ADComputerLAPSInfo -ComputerName COMPUTER1

   Description
   -----------
   Get LAPS Info for computer
   
.EXAMPLE
   Get-ADComputerLAPSInfo COMPUTER1, COMPUTER2

   Description
   -----------
   Get LAPS Info for computers


.NOTES
   File Name  : Get-ADComputerLAPSInfo.ps1
   Version    : 2.1912
   Author     : Andriy Zarevych

   Find me on :
   * My Blog  :	https://angry-admin.blogspot.com/
   * LinkedIn :	https://linkedin.com/in/zarevych/
   * Github   :	https://github.com/zarevych

   Change Log:
   V2.1912    : Initial version

#>

    [CmdletBinding()]
    [OutputType([pscustomobject])]
    [Alias("Get-ADComputerLAPS")]
    
    param(
        [Parameter(ValueFromPipeline=$true
        ,ValueFromPipelineByPropertyName=$true,
        Position=0)]
        [ValidateNotNullOrEmpty()]
        [Alias('Computer','Name')]
        [String[]]$ComputerName = $env:ComputerName
    )

    Process {

        $Computers = $ComputerName

        ForEach ($Computer in $Computers) {

            try {
                $Computer = Get-ADComputer $Computer -Property * -ErrorAction Stop
            }
            catch {
                #Write-Error $_.Exception.Message
                Write-Host $_.Exception.Message`n -ForegroundColor Red
                #Break
                Continue
            }

            # Get LAPS Info

            if ($Computer.'ms-Mcs-AdmPwd'){
   
                #$strComputerPassword=$Computer.'ms-Mcs-AdmPwd'
        
                $strComputerExpTime = $Computer.'ms-MCS-AdmPwdExpirationTime'

                if ($strComputerExpTime -ge 0) {$strComputerExpTime = $([datetime]::FromFileTime([convert]::ToInt64($strComputerExpTime)))}
        
                $strComputerExpTime = "{0:yyyy-MM-dd HH:mm:ss}" -f [datetime]$strComputerExpTime

            }          
            
            # Return LAPS data

            [PSCustomObject]@{
                Name = $Computer.Name
                ComputerPassword = $Computer.'ms-Mcs-AdmPwd'
                PasswordExpTime = $strComputerExpTime
            }
            
        }

    }
}