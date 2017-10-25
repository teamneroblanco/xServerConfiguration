Configuration xMMAgent
{
    param
    (
        [string]
        $SourcePath = "",
        [string]
        $LocalPath = "",
	[string]
	$OPSINSIGHTS_WS_ID = "",
	[string]
	$OPSINSIGHTS_WS_KEY = ""
    )

    Service mmagentService
    {
        Name = "HealthService"
        State = "Running"
        DependsOn = "[Package]mmagentPackage"
    }

    Package mmagentPackage {
        Ensure = "Present"
        Path  = "$LocalPath\MMASetup-AMD64.exe"
        Name = "Microsoft Monitoring Agent"
        ProductId = "6D765BA4-C090-4C41-99AD-9DAF927E53A5"
        Arguments = "/C:""setup.exe /qn ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_ID=$OPSINSIGHTS_WS_ID OPINSIGHTS_WORKSPACE_KEY=$OPSINSIGHTS_WS_KEY AcceptEndUserLicenseAgreement=1"""
        DependsOn = "[File]mmagentFiles"
    }

    File mmagentFiles {
        DestinationPath = $LocalPath
        SourcePath = $SourcePath
        Recurse = $true
        Checksum = 'SHA-256'
        MatchSource = $true
        Force = $true
        Ensure = 'Present'
    }
}