Configuration xSysmon
{
    param
    (
        [string]
        $SourcePath = "",
        [string]
        $LocalPath = "",
        [string]
        $ConfigFileName = ""
    )

    Service sysmonService
    {
        Name = "Sysmon"
        State = "Running"
        DependsOn = "[Script]sysmonScriptInstall"
    }

    Script sysmonScriptUpgrade {
        GetScript = { Get-FileHash "C:\Windows\sysmon.exe", "$($Using:LocalPath)\current-$($Using:ConfigFileName)" }
        TestScript = {
            # check if there is a newer version of sysmon
            $hash = Get-FileHash "C:\Windows\sysmon.exe", "$($Using:LocalPath)\sysmon64.exe"
            if ($hash[0].hash -eq $hash[1].hash) {

                # check if there is a newer version of the configuration
                if( Test-Path "$($Using:LocalPath)\current-$($Using:ConfigFileName)" ) {
                    $hash = Get-FileHash "$($Using:LocalPath)\current-$($Using:ConfigFileName)", "$($Using:LocalPath)\$($Using:ConfigFileName)"
                    if ($hash[0].hash -eq $hash[1].hash) {
                        return $true
                    }
                }
            }
            return $false
        }
        SetScript = {
            try { & "$($Using:LocalPath)\sysmon64.exe" -u } catch { }
            & "$($Using:LocalPath)\sysmon64.exe" -i "$($Using:LocalPath)\$($Using:ConfigFileName)" -accepteula
            Copy-Item "$($Using:LocalPath)\$($Using:ConfigFileName)" "$($Using:LocalPath)\current-$($Using:ConfigFileName)" -Force
        }
        DependsOn = "[Script]sysmonScriptInstall"
    }

    Script sysmonScriptInstall {
        GetScript = { (Get-Service Sysmon -ErrorAction SilentlyContinue) }
        TestScript = {
            return ( (Get-Service Sysmon -ErrorAction SilentlyContinue) -ne $null )
        }
        SetScript = {
            & "$($Using:LocalPath)\sysmon64.exe" -i "$($Using:LocalPath)\$($Using:ConfigFileName)" -accepteula
            Copy-Item "$($Using:LocalPath)\$($Using:ConfigFileName)" "$($Using:LocalPath)\current-$($Using:ConfigFileName)" -Force
        }
        DependsOn = "[File]sysmonFiles"
    }

    File sysmonFiles {
        DestinationPath = $LocalPath
        SourcePath = $SourcePath
        Recurse = $true
        Checksum = 'SHA-256'
        MatchSource = $true
        Force = $true
        Ensure = 'Present'
    }

}