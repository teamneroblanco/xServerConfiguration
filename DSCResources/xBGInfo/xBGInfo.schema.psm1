Configuration xBGInfo
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
    $ShortcutDestinationPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"

    Script bginfoScriptInstall {
        GetScript = { Get-Item "$($Using:ShortcutDestinationPath)\BGInfo.lnk" }
        TestScript = {
            return ( ( ( Test-Path "$($Using:ShortcutDestinationPath)\BGInfo.lnk" ) -eq $True ) -and ( ( Test-Path "$($Using:LocalPath)\RNIB-Server.bgi" ) -eq $False  ) )
        }
        SetScript = {
            if( Test-Path "$($Using:ShortcutDestinationPath)\BGInfo.lnk" ) {
                Remove-Item "$($Using:ShortcutDestinationPath)\BGInfo.lnk" -Force -Confirm:$False
            }
            $WshShell = New-Object -ComObject WScript.Shell
            $Shortcut = $WshShell.CreateShortcut("$($Using:ShortcutDestinationPath)\BGInfo.lnk")
            $Shortcut.TargetPath = "$($Using:LocalPath)\BGInfo.exe"
            $Shortcut.Arguments = """$($Using:LocalPath)\$($Using:ConfigFileName)"" -accepteula -timer:0"
            $Shortcut.Save()
            if( Test-Path "$($Using:LocalPath)\RNIB-Server.bgi" ) {
                Remove-Item "$($Using:LocalPath)\RNIB-Server.bgi" -Force -Confirm:$False
            }

        }
        DependsOn = "[File]bginfoFiles"
    }

    Script bginfoScriptFix {
        GetScript = { Get-Item "$($Using:ShortcutDestinationPath)\BGInfo.lnk" }
        TestScript = {
            return $False
        }
        SetScript = {
            if( Test-Path "$($Using:ShortcutDestinationPath)\BGInfo.lnk" ) {
                Remove-Item "$($Using:ShortcutDestinationPath)\BGInfo.lnk" -Force -Confirm:$False
            }
            $WshShell = New-Object -ComObject WScript.Shell
            $Shortcut = $WshShell.CreateShortcut("$($Using:ShortcutDestinationPath)\BGInfo.lnk")
            $Shortcut.TargetPath = "$($Using:LocalPath)\BGInfo.exe"
            $Shortcut.Arguments = """$($Using:LocalPath)\$($Using:ConfigFileName)"" -accepteula -timer:0"
            $Shortcut.Save()
            if( Test-Path "$($Using:LocalPath)\RNIB-Server.bgi" ) {
                Remove-Item "$($Using:LocalPath)\RNIB-Server.bgi" -Force -Confirm:$False
            }

        }
        DependsOn = "[File]bginfoFiles"
    }

    File bginfoFiles {
        DestinationPath = $LocalPath
        SourcePath = $SourcePath
        Recurse = $true
        Checksum = 'SHA-256'
        MatchSource = $true
        Force = $true
        Ensure = 'Present'
    }

}