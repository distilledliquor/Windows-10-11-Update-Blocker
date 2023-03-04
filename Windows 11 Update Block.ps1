<# Setting registry values to stop windows update #>
$keyUX = 'Registry::HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings'
$keyAU = 'Registry::HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU'
$dateStart = '0000-01-01T00:00:00Z'
$dateEnd = '3000-12-31T11:59:59Z'
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseFeatureUpdatesStartTime' -Value $dateStart
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseQualityUpdatesStartTime' -Value $dateStart
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseUpdatesStartTime' -Value $dateStart
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseFeatureUpdatesEndTime' -Value $dateEnd
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseQualityUpdatesEndTime' -Value $dateEnd
New-ItemProperty -Force -Path $keyUX -PropertyType String -Name 'PauseUpdatesExpiryTime' -Value $dateEnd
New-Item -Force -Path $keyAU
New-ItemProperty -Force -Path $keyAU -PropertyType DWORD -Name 'NoAutoUpdate' -Value 1