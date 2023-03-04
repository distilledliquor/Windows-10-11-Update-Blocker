<# Setting registry values to stop windows update #>
$keyUX = 'Registry::HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings'
$keyAU = 'Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
$dateStart = '0000-01-01T00:00:00Z'
$dateEnd = '3000-12-31T11:59:59Z'
$getWinver = (Get-WmiObject -class Win32_OperatingSystem).Caption
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseFeatureUpdatesStartTime' -Value $dateStart
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseQualityUpdatesStartTime' -Value $dateStart
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseUpdatesStartTime' -Value $dateStart
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseFeatureUpdatesEndTime' -Value $dateEnd
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseQualityUpdatesEndTime' -Value $dateEnd
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseUpdatesExpiryTime' -Value $dateEnd
if ($getWinver.Contains("Windows 11")) {
New-Item -Force -Path $keyAU
New-ItemProperty -Force -Path $keyAU -PropertyType DWORD -Name 'NoAutoUpdate' -Value 1
}

<# Completion message #>
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > $null
[string] $L1 = 'Windows ������Ʈ�� 3000�� 12�� 31�Ͽ� �ٽ� ���۵˴ϴ�.'
[string] $L2 = '��'
[string] $L3 = 'Windows ������Ʈ â�� ������Ʈ ����ϱ� ��ư�� Ŭ���Ͽ� Windows ������Ʈ ����� �����Ͻ� �� �ֽ��ϴ�.'
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
