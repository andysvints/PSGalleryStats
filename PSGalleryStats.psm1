<#
.Synopsis
   Get Powershell Gallery Statistics for the specified Date.
.DESCRIPTION
   Get List of published modules on the specified date.
.EXAMPLE
    PS C:\> Get-PSGalleryStatistics -Date "3/21/2019" -ov Stats
    Summary                                       Details
    -------                                       -------
    There were 23 modules published on 3/21/2019. {@{Author=Aaron Parker; ModuleName=VcRedist; Version=1.5.2.100; Publis...
    
    PS C:\>$Stats.summary
There were 23 modules published on 3/21/2019.
#>
function Get-PSGalleryStatistics
{
    [CmdletBinding(SupportsShouldProcess=$true, 
                  PositionalBinding=$false,
                  ConfirmImpact='Medium')]
    [Alias('psgs')]
    Param
    (
        # Date for which you want to get stats
        [Parameter(ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true, 
                   Position=0)]
        [ValidateNotNullOrEmpty()]
        [datetime]$Date=(Get-Date).AddDays(-1)
    )

    Begin
    {
    }
    Process
    {
        if ($pscmdlet.ShouldProcess("date $Date"))
        {
            $PublishedToday=0
            $ModuleArrayList=New-Object System.Collections.ArrayList
            $AvailableModules=find-module -Name *
             foreach($m in $AvailableModules){
     
                 if($m.PublishedDate.Date -eq $Date.Date ){
                  $PublishedToday++
                  $prop=@{
                    Author=$($m.Author)
                    ModuleName=$($m.Name)
                    Version=$($m.Version)
                    PublishedDate=$($m.PublishedDate)
                  }
                  $ModuleObj=New-Object -TypeName psobject -Property $prop | Select-Object Author,ModuleName,Version,PublishedDate
                  $ModuleArrayList.Add($ModuleObj) | Out-Null
      
                 }

             }
        }
        $ResultObjProps=@{
            Summary="There were $PublishedToday modules published on $($Date.GetDateTimeFormats()[0])."
            Details=$ModuleArrayList
        }
        $ResultObj=New-Object -TypeName psobject -Property $ResultObjProps
        $ResultObj
    }
    End
    {
    }
}