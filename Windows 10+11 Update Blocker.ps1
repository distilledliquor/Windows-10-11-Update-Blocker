<# Setting registry values to stop windows update #>
$keyUX = 'Registry::HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings'
$keyAU = 'Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
$dateStart = '0000-01-01T00:00:00Z'
$dateEnd = '3000-12-31T11:59:59Z'
$getWinver = (Get-WmiObject -class Win32_OperatingSystem).Caption
Set-ItemProperty -Path $keyUX -Name 'PauseFeatureUpdatesStartTime' -Value $dateStart
Set-ItemProperty -Path $keyUX -Name 'PauseQualityUpdatesStartTime' -Value $dateStart
Set-ItemProperty -Path $keyUX -Name 'PauseUpdatesStartTime' -Value $dateStart -EA SilentlyContinue
Set-ItemProperty -Path $keyUX -Name 'PauseFeatureUpdatesEndTime' -Value $dateEnd
Set-ItemProperty -Path $keyUX -Name 'PauseQualityUpdatesEndTime' -Value $dateEnd
Set-ItemProperty -Path $keyUX -Name 'PauseUpdatesExpiryTime' -Value $dateEnd
if ($getWinver.Contains("Windows 11")) {
New-Item -Force -Path $keyAU > $null
New-ItemProperty -Force -Path $keyAU -PropertyType DWORD -Name 'NoAutoUpdate' -Value 1 > $null
}

<# Completion message #>
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > $null
[string] $L1 = 'Windows 업데이트가 3000년 12월 31일에 다시 시작됩니다.'
[string] $L2 = '　'
[string] $L3 = 'Windows 업데이트 창의 업데이트 계속하기 버튼을 클릭하여 Windows 업데이트 기능을 복구하실 수 있습니다.'
$toastDetail = @"
<toast> 
    <visual>
        <binding template = "ToastImageAndText04">
            <text id = "1">$($L1)</text>
            <text id = "2">$($L2)</text>
            <text id = "3">$($L3)</text>
        </binding>
    </visual> 
</toast>
"@
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($toastDetail)
$toastNotification = [Windows.UI.Notifications.ToastNotification]::new($xml)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier(' ').Show($toastNotification)
