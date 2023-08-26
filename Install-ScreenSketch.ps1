$This Powershell script will install latest screensketch(Snipping tool) version

If(!(Get-Item C:\logs -ErrorAction SilentlyContinue))
{
New-Item -Path C:\ -Name "Logs" -ItemType Directory -Force -ErrorAction SilentlyContinue
$logfilelocation = 'c:\logs' 
}
else
{ 
$Logfilelocation='c:\logs'
}
Set-Location "C:\Logs"
$TodayDate= Get-Date -format "dd-MMM-yyyy HH:mm tt"
$AppName = 'Snipping_ScreenSketch'
$logfile="$logfilelocation\$appname.log"
"`n`nTimeStamp: $TodayDate"  | out-file $logfile -Append
Start-Transcript $Logfile

$AppName="Microsoft.Screensketch"

Function Install-Screensketch{
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "C:\Temp\ScreenSketch\Microsoft.UI.Xaml.2.4_2.42007.9001.0_x64__8wekyb3d8bbwe.Appx"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "C:\Temp\ScreenSketch\Microsoft.VCLibs.140.00_14.0.32530.0_x64__8wekyb3d8bbwe.Appx"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "C:\Temp\ScreenSketch\Microsoft.ScreenSketch_2020.814.2355.0_neutral_~_8wekyb3d8bbwe.AppxBundle"
Sleep 3
Get-AppxPackage $AppName  | FL

}

Function Uninstall-Screensketch
{
"Uninstalling $AppName"
Get-AppxPackage $AppName | Remove-AppxPackage -AllUsers
If(!(Get-AppxPackage $AppName))
{
"$TodayDate : Screensketch was uninstalled successfully."
Install-Screensketch
}
Else
{
"$TodayDate : Failed to uninstall theScreensketch"
}
}


If((Get-AppxPackage $AppName))
{
"$TodayDate : Found $APPName in  $ENV:Computername. Unistalling $AppName"
 Uninstall-Screensketch
}
Else
{
 "$TodayDate :$AppName was not found in $ENV:Computername. Installing $AppName"
 Install-Screensketch
}
Stop-Transcript
