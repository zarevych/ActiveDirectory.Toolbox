# ActiveDirectory.Toolbox

Functions for Active Directory Management for performing Sysadmin tasks

## Installtion
```bash
PS> Install-Module -Name ActiveDirectory.Toolbox
```

## Usage
```bash
PS> Import-Module ActiveDirectory.Toolbox
```

## Commands / Functions

### Get-ADComputerBitLockerInfo
Get Computer BitLocker Recovery Information from Active Directory
```bash
Get-ADComputerBitLockerInfo [[-ComputerName] <string[]>]
```
### Get-ADComputerLAPSInfo
Get Computer LAPS Passwords information from Active Directory
```bash
Get-ADComputerBitLockerInfo [[-ComputerName] <string[]>]
```
### Get-ADUserMemberOf
Get a list of groups for Active Directory user
```bash
Get-ADUserMemberOf [-User] <Object>
```
### Get-LockedADUsers
Get locked Active Directory user accounts
```bash
Get-LockedADUsers
```
### Unlock-ADUsers
Unlock all Active Directory user accounts
```bash
Unlock-ADUsers
```
