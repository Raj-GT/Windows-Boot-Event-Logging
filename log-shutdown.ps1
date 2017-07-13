<#
.SYNOPSIS
    Log shutdown event information to $logfile

.DESCRIPTION
    When run (preferably via Group Policy at shutdown) the script will create/update $logfile with the shutdown event information from the machine. Even if you don't have the need to maintain a logfile, you can use the script to update/silence your monitoring system or even send an e-mail alert etc.

.INPUTS
    None

.OUTPUTS
    None

.LINK
    https://github.com/Raj-GT/Windows-Boot-Event-Logging

.LINK
    https://www.experts-exchange.com/articles/25559/Windows-boot-event-logging-and-monitoring-with-PowerShell.html

.NOTES
    Version:    1.1
    Author:     Nimal Raj
    Revisions:  13/07/2017      Initial draft of v1.1
#>

#Requires -Version 3.0

#--------------------------------------------------------[Variables]--------------------------------------------------------
$logfile = "C:\Logs\bootlog.csv"

#--------------------------------------------------------[Functions]--------------------------------------------------------

#--------------------------------------------------------[Execution]--------------------------------------------------------
# If logfile doesn't exist, create it and add the CSV headers
If (!(Test-Path $logfile))
	{
	    New-Item -Path $logfile -ItemType File -Force
	    Add-Content -Path $logfile "Time,UserName,EventType,Process,ReasonCode,Comment,Message"
    }

# Phrase the last Event 1074 (InstanceId 2147484722) entry into variables
$event = Get-EventLog -LogName System -Source User32 -InstanceId 2147484722 -Newest 1
$Time = $event.TimeGenerated.ToString()
$UserName = $event.ReplacementStrings[6]
$EventType = $event.ReplacementStrings[4]
$Process = $event.ReplacementStrings[0]
$ReasonCode = $event.ReplacementStrings[3]
$Comment = $event.ReplacementStrings[5]
$Message = $event.Message.Split("`r`n")[0]

# Add event contents to logfile
Add-content -Path $logfile "$Time,$UserName,$EventType,$Process,$ReasonCode,$Comment,$Message"
    
# Add any actions you want performed at every shutdown/restart below this line
# E.g. You can update the monitoring system, send an e-mail or do something else
# You can also re-use the shutdown event variables in your code