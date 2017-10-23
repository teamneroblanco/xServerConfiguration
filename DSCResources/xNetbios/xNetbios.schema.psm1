Configuration xNetbios
{
    param
    (
        [int]
        $NetbiosSetting = 2
    )

    Script netbiosScriptConfigure {
        GetScript = { Get-WMIObject win32_networkadapterconfiguration | ? { $_.IpEnabled -eq $true } }
        TestScript = {
            return (Get-WMIObject win32_networkadapterconfiguration | ? { $_.IpEnabled -eq $true -and $_.TcpipNetbiosOptions -ne $($Using:NetbiosSetting) }) -eq $null
        }
        SetScript = {
            Get-WMIObject win32_networkadapterconfiguration | ? { $_.IpEnabled -eq $true } | % { $_.settcpipnetbios($($Using:NetbiosSetting)) }
        }
    }


}