#Requires -Modules ActiveDirectory
#Requires -Version 3.0


Function Get-ADComputerBitLockerInfo () {   

<#
.SYNOPSIS
 Get Computer BitLocker Recovery Information from Active Directory.
 
.DESCRIPTION
 Get BitLocker Recovery Information from Active Directory.
 ComputerName;PasswordID;RecoveryPassword;Date and Time

 Requirement:
    - ActiveDirectory PowerShell Module
    - Needed rights to view AD BitLocker Recovery Info
 
 Usage:
    
    Get-ADComputerBitLockerInfo -ComputerName Computer1
    Get-ADComputerBitLockerInfo Computer1, Computer2


.PARAMETER ComputerName   
    Optional parameter to view computer Bitlocker info


.EXAMPLE
   Get-ADComputerBitLockerInfo -ComputerName Computer1

   Description
   -----------
   Get BitLocker Recovery Info for computer

   
.EXAMPLE
   Get-ADComputerBitLockerInfo Computer1, Computer2

   Description
   -----------
   Get BitLocker Recovery Info for computers


.NOTES
   File Name  : Get-ADComputerBitLockerInfo.ps1
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
    [Alias('Get-ADComputerBitLocker')]
    
    param(

        [Parameter(ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0)]
        [ValidateNotNullOrEmpty()]
        [Alias('Computer','Name')]
        [String[]]$ComputerName = $env:ComputerName

    )
  

    Process {
        
        $Computers = $ComputerName

        ForEach ($Computer in $Computers) {

            $BitLockerInfo = @()

            try {
                $Computer = Get-ADComputer $Computer -Property * -ErrorAction Stop
            }
            catch {
                #Write-Error $_.Exception.Message
                Write-Host $_.Exception.Message`n -ForegroundColor Red
                #Break
                Continue
            }


            # Get BitLocker Info
            $BitLockerObjects=(Get-ADObject -Filter {objectclass -eq 'msFVE-RecoveryInformation'} -SearchBase $Computer.DistinguishedName -Properties whenCreated, msFVE-RecoveryPassword | Sort whenCreated -Descending)
            
            foreach ($BitLockerObject in $BitLockerObjects) {
            #The name of the BitLocker recovery object incorporates a globally unique identifier (GUID) and date and time information, 
            #for a fixed length of 63 characters. The form is: <Object Creation Date and Time><Recovery GUID>
            #For example:
            #2005-09-30T17:08:23-08:00{063EA4E1-220C-4293-BA01-4754620A96E7}
            #$BitLockerObject.Name
                
                $strComputerDate = $BitLockerObject.Name.Substring(0,10)
                $strComputerTime = $BitLockerObject.Name.Substring(11,8)
                $strComputerGMT = $BitLockerObject.Name.Substring(19,6)
                $strComputerPasswordID = $BitLockerObject.Name.Substring(26,36)
                $strComputerRecoveryPassword = $BitLockerObject.'msFVE-RecoveryPassword'
                
                #$strComputerDate = $BitLockerObject.Name.Substring(0,10) + ' ' + $BitLockerObject.Name.Substring(11,8) + ' ' + $BitLockerObject.Name.Substring(19,6)
                
                $BitLockerInfo += [PSCustomObject]@{
                    Name = $Computer.Name
                    PasswordID = $BitLockerObject.Name.Substring(26,36)
                    RecoveryPassword = $BitLockerObject.'msFVE-RecoveryPassword'
                    Date = $BitLockerObject.Name.Substring(0,10) + ' ' + $BitLockerObject.Name.Substring(11,8) + ' ' + $BitLockerObject.Name.Substring(19,6)
                }

            }

            # Return BitLocker data
            $BitLockerInfo
        }
               
    }

}
