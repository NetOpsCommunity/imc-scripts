# Script to generate alarms if devices are down in IMC for more than 5 minutes.

# You must ensure C:\Temp exists
# Set the variables for $Password, $Hostname, $emailFrom, $emailTo, $smtpServer.
# Use pwdmgr.bat if you need to find out the password for imc_monitor, or just use another username that
# has access to the imc_monitor DB.

`
#Load SQL cmdlets
Add-PSSnapin -Name SqlServerCmdletSnapin100 -ErrorAction SilentlyContinue
Add-PSSnapin -Name SqlServerProviderSnapin100 -ErrorAction SilentlyContinue

#Set up DB variables. Needs testing with remote DB. Could also specify instance?

$Database="monitor_db"
$Username="imc_monitor"
$Password="CHANGEME"	
$Hostname="127.0.0.1"
$AlarmsFile="C:\Temp\notifiedAlarms.csv"
$currentTime=Get-Date -UFormat %s
# Script should be run more frequently than this - so if window is set to 5 minutes, run script at least every 4 minutes. Recommend running every minute
# Means we won't miss any alarms due to timing variations. Recording previously notified alarms deals with potential duplicates
# Must be given in seconds
$notificationDelay=300
$alarmWindow=$currentTime - $notificationDelay

$emailFrom = "imc@EXAMPLE.co.nz"
$emailTo = "ME@EXAMPLE.co.nz"
$smtpServer = "smtp.EXAMPLE.co.nz"


$previouslyNotifiedAlarms = Import-CSV -Path $AlarmsFile -ErrorAction SilentlyContinue

# Set up array of Serials we've seen before. This is so we only alert once on each alarm. Ensures we capture all alarms, rather than trying to restrict time window too tightly
$previouslyNotifiedSerials = @()

if ($previouslyNotifiedAlarms) {
	$previouslyNotifiedAlarms | ForEach-Object { $previouslyNotifiedSerials += $_.serial_no }
}

Function Get-LocalTime($UTCTime)
{
	$strCurrentTimeZone = (Get-WmiObject win32_timezone).StandardName
	$TZ = [System.TimeZoneInfo]::FindSystemTimeZoneById($strCurrentTimeZone)
	$LocalTime = [System.TimeZoneInfo]::ConvertTimeFromUtc($UTCTime, $TZ)
	Return $LocalTime
}
Function doNotify ($serial_no, $dev_name, $fault_time)
{
	$timeInMinutes = $notificationDelay / 60
	# Find out when the device was first marked offline
	$readableFaultTime = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
	$readableFaultTime = $readableFaultTime.AddSeconds($fault_time)
	$readableFaultTime = Get-LocalTime $readableFaultTime
	$readableFaultTimeString = $readableFaultTime | Get-Date -Format F	
	#Write-Host "Alarm number $serial_no - Device $dev_name offline for more than $timeInMinutes minutes"
	$subject = "IMC Alarm: $dev_name offline for more than $timeInMinutes minutes"
	# Should add code here to find out device sysLocation, Custom Views. Could then have code to work out when to notify? (e.g. Business Hours)
	$body = "Node $dev_name has been offline since $readableFaultTimeString"
	$smtp = new-object Net.Mail.SmtpClient($smtpServer)
	$smtp.Send($emailFrom, $emailTo, $subject, $body)
}

$openAlarms=Invoke-sqlcmd -Database $Database -Username $Username -Password $Password -Hostname $Hostname -Query "Select * from tbl_trap_data_critical WHERE fault_time > $alarmWindow AND ack_type = 0 AND fault_oid LIKE '1.3.6.1.4.1.25506.4.1.1.2.6.1';"

if ($openAlarms) {
	$openAlarms | ForEach-Object {
		# Just quickly check to see if we've maybe already seen this one and notified on it
		if ($previouslyNotifiedSerials -Contains $_.serial_no) {
			#Write-Host "Not doing notification for this serial"
		} else {
			doNotify $_.serial_no $_.dev_name $_.fault_time
		}
	}
}


#Export the list of alarms we notified on - note that ErrorAction will write empty file without complaining
$openAlarms|Export-CSV -Path $AlarmsFile -NoTypeInformation -ErrorAction SilentlyContinue