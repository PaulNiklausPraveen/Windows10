#This PowerShell script will install latest MS Paint 3D application

if(!(Get-Item C:\logs -ErrorAction SilentlyContinue))
{
New-Item -Path C:\ -Name "Logs" -ItemType Directory -Force -ErrorAction SilentlyContinue
$logfilelocation = 'c:\logs' 
}
else
{ 
$logfilelocation='c:\logs'
}
Set-Location "C:\Logs"
$TodayDate= Get-Date -format "dd-MMM-yyyy HH:mm tt"
$AppName = 'MS_Paint3d'
$logfile="$logfilelocation\$appname.log"
"`n`nTimeStamp:$TodayDate"  | out-file $logfile -Append
Start-Transcript $logfile

$AppName="Microsoft.MSPaint"

Function Install-MSPaint{
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "$PSScriptroot\Microsoft.VCLibs.140.00_14.0.32530.0_x64__8wekyb3d8bbwe.Appx"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "$PSScriptroot\Microsoft.UI.Xaml.2.0_2.1810.18004.0_x64__8wekyb3d8bbwe.Appx"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "$PSScriptroot\Microsoft.MSPaint_2023.2305.16087.0_neutral_~_8wekyb3d8bbwe.AppxBundle"
Sleep 3
Get-AppxPackage $AppName  | FL

}

Function Uninstall-MSPaint
{
"Uninstalling $AppName"
Get-AppxPackage $AppName | Remove-AppxPackage -AllUsers
If(!(Get-AppxPackage $AppName))
{
"$TodayDate : MS Paint was uninstalled successfully."
Install-MSPaint
}
Else
{
"$TodayDate : Failed to uninstall the MS Paint"
}
}




If((Get-AppxPackage $AppName))
{
"$TodayDate : Found $APPName in  $ENV:Computername. Unistalling $AppName"
 Uninstall-MSPaint
}
Else
{
 "$TodayDate :$AppName was not found in $ENV:Computername. Installing $AppName"
 Install-MSPaint
}
Stop-Transcript
