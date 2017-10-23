Configuration xLAPS
{
    param
    (
        [string]
        $SourcePath = "",
        [string]
        $LocalPath = "",
        [string]
        $Arguments = ""
    )

    Package lapsPackage {
        Ensure = "Present"
        Path  = "$LocalPath\LAPS.x64.msi"
        Name = "Local Administrator Password Solution"
        ProductId = "EA8CB806-C109-4700-96B4-F1F268E5036C"
        Arguments = $Arguments
        DependsOn = "[File]lapsFiles"
    }

    File lapsFiles {
        DestinationPath = $LocalPath
        SourcePath = $SourcePath
        Recurse = $true
        Checksum = 'SHA-256'
        MatchSource = $true
        Force = $true
        Ensure = 'Present'
    }
}