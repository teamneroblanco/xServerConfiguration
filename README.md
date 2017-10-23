# xServerConfiguration
The xServerConfiguration module is a Windows PowerShell Desired State Configuration (DSC) Module. It is a collection of DSC Resources produced by the PowerShell Team. This module contains the xBGInfo, xLAPS, xMMAgent, xNetbios and xSysmon resources. 
All of the resources in this module are provided AS IS, and are not supported through any standard support program or service. The "x" prefix in the module name stands for "experimental," which means that these resources will be fix-forward and monitored by the module owner(s).
## Installation
To install xServerConfiguration PowerShell DSC module:
Unzip the content under the $env:ProgramFiles\WindowsPowerShell\Modules folder
OR Upload the zip files to Azure as a Module
To confirm installation:
Run Get-DSCResource -Module xServerConfiguration to see that xBGInfo, xLAPS, xMMAgent, xNetbios and xSysmon are among the DSC Resources listed
Run the Get-Module -ListAvailable -Name xServerConfiguration command to verify that the xServerConfiguration DSC module is listed
## Requirements
This module requires the latest version of PowerShell (v4.0, which ships in Windows 8.1 or Windows Server 2012R2). To easily use PowerShell 4.0 on older operating systems, install WMF 4.0. Please read the installation instructions that are present on both the download page and the release notes for WMF 4.0.
## Description
The xServerConfiguration module contains the xBGInfo, xLAPS, xMMAgent, xNetbios and xSysmon resources.
## Details
The xBGInfo DSC Resource, is used to install and configure Sysinternals BGInfo, and  has following optional properties:
SourcePath: The UNC path to get the current bginfo.exe and config file from.
LocalPath: The local location on the machine where the downloadeded installation files will be placed.
ConfigFileName: The name of the BGInfo configuration file that needs to be applied

The xLAPS DSC Resource, is used to install Microsoft's Local Administrator Password Solution, and  has following optional properties:
SourcePath: The UNC path to get the current msi from.
LocalPath: The local location on the machine where the downloadeded installation files will be placed.
Arguments: The ADDLOCAL and other cmdline parameters to be passed to the msi

The xMMAgnet DSC Resource, is used to install and configure Microsoft's OMS Agent, and  has following optional properties:
SourcePath: The UNC path to get the current OMS agent from.
LocalPath: The local location on the machine where the downloadeded installation files will be placed.
OPSINSIGHTS_WS_ID: The OMS Workspace ID.
OPSINSIGHTS_WS_KEY: The OMS Workspace Key.

The xNetbios DSC Resource, is used to Enable or Disable Netbios, and  has following optional properties:
NetbiosSetting: The Netbios setting that will be applied (2=disable, 0=enable)

The xSysmon DSC Resource, is used to install and configure Sysinternals sysmon, and  has following optional properties:
SourcePath: The UNC path to get the current sysmon64.exe and config file from.
LocalPath: The local location on the machine where the downloadeded installation files will be placed.
ConfigFileName: The name of the sysmon configuration file that needs to be applied
