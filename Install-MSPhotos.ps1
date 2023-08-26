#Install Microsoft photos via powershell script

If(!(Get-Item C:\logs -ErrorAction SilentlyContinue))
{
New-Item -Path C:\ -Name "Logs" -ItemType Directory -Force -ErrorAction SilentlyContinue
$logfilelocation = 'c:\logs' 
}
Else
{ 
$logfilelocation='c:\logs'
}
Set-Location "C:\Logs"
$TodayDate= Get-Date -format "dd-MMM-yyyy HH:mm tt"
$AppName = 'WindowsPhotos'
$logfile="$logfilelocation\$appname.log"
"`n`nTimeStamp: $TodayDate"  | out-file $logfile -Append
Start-Transcript $Logfile

$AppName="Microsoft.Windows.Photos"

Function Install-WindowsPhotos{
"$TodayDate : installing $AppName"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "C:\Temp\Photos\Microsoft.NET.Native.Framework.2.2_2.2.29512.0_x64__8wekyb3d8bbwe.Appx"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "C:\Temp\Photos\Microsoft.NET.Native.Runtime.2.2_2.2.28604.0_x64__8wekyb3d8bbwe.Appx"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "C:\Temp\Photos\Microsoft.UI.Xaml.2.7_7.2208.15002.0_x64__8wekyb3d8bbwe.Appx"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "C:\Temp\Photos\Microsoft.VCLibs.140.00_14.0.32530.0_x64__8wekyb3d8bbwe.Appx"
Add-AppxProvisionedPackage -Online -SkipLicense -PackagePath "C:\Temp\Photos\Microsoft.Windows.Photos_2023.10030.27002.0_neutral_~_8wekyb3d8bbwe.AppxBundle"
Sleep 3
Get-AppxPackage $AppName  | FL

}

Function Uninstall-WindowsPhotos
{
"$TodayDate : Uninstalling $AppName"
Get-AppxPackage $AppName | Remove-AppxPackage -AllUsers
If(!(Get-AppxPackage $AppName))
{
"$TodayDate : WindowsPhotos was uninstalled successfully."
Install-Screensketch
}
Else
{
"$TodayDate : Failed to uninstall the WindowsPhotos"
}
}

If((Get-AppxPackage $AppName))
{
"$TodayDate : Found $APPName in  $ENV:Computername. Unistalling $AppName"
 Uninstall-WindowsPhotos
}
Else
{
 "$TodayDate :$AppName was not found in $ENV:Computername. Installing $AppName"
 Install-WindowsPhotos
}
Stop-Transcript
