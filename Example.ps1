Configuration Example
{

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration' 
    Import-DscResource -ModuleName 'xServerConfiguration'

    $SourcePath = "\\MYFileServer\DSCResources$"
    $SourceOMSPath = "$SourcePath\OMS"
    $SourceLAPSPath = "$SourcePath\LAPS"
    $SourceSysinternalsPath = "$SourcePath\Sysinternals"

    $LocalDSCPath = "C:\DSCSource"
    $LocalOMSPath = "$LocalDSCPath\OMS"
    $LocalLAPSPath = "$LocalDSCPath\LAPS"
    $LocalSysinternalsPath = "c:\Program Files\Sysinternals"
    # Turn off Netbios on the NICs (2 disable, 0 enable)
    $NetbiosSetting = 2

    $OPSINSIGHTS_WS_ID = Get-AutomationVariable -Name "OPSINSIGHTS_WS_ID"
    $OPSINSIGHTS_WS_KEY = Get-AutomationVariable -Name "OPSINSIGHTS_WS_KEY"

    Node myServer
    {
        xMMAgent rnibMMAgent
        {
            SourcePath = $SourceOMSPath
            LocalPath = $LocalOMSPath
            OPSINSIGHTS_WS_ID = $OPSINSIGHTS_WS_ID
            OPSINSIGHTS_WS_KEY = $OPSINSIGHTS_WS_KEY
        }

        xSysmon rnibSysmon
        {
            SourcePath = $SourceSysinternalsPath
            LocalPath = $LocalSysinternalsPath
            ConfigFileName = "sysmon-config.xml"
        }

        xBGInfo rnibBGInfo
        {
            SourcePath = $SourceSysinternalsPath
            LocalPath = $LocalSysinternalsPath
            ConfigFileName = "Server.bgi"
        }

        xLAPS rnibLAPS
        {
            SourcePath = $SourceLAPSPath
            LocalPath = $LocalLAPSPath
            Arguments = ""
        }

        xNetbios rnibNetbios
        {
            NetbiosSetting = $NetbiosSetting
        }

    }
}
