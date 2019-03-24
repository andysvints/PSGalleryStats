# PSGalleryStats
Get Powershell Gallery Statistics for the specified Date.

## Install Module
Copy and Paste the following command to install this package using PowerShellGet
```powershell
Install-Module -Name PSGalleryStats
```

## Cmdlets
```powershell
Get-PSGalleryStatistics
```

## Dependencies
This module has no dependencies.

## Example
Getting List of modules published on 3/21/2019
```powershell
    PS C:\>Get-PSGalleryStatistics -Date "3/21/2019" -ov Stats

    Summary                                       Details
    -------                                       -------
    There were 23 modules published on 3/21/2019. {@{Author=Aaron Parker; ModuleName=VcRedist; Version=1.5.2.100; Publis...

    PS C:\>$Stats.summary
    There were 23 modules published on 3/21/2019.
```
