<#
.SYNOPSIS
    Log startup event information to $logfile

.DESCRIPTION
    When run (preferably via Group Policy at startup) the script will create/update $logfile with the startup event information from the machine. The script can even identify if the last boot was a cleanboot (orderly shutdown or restart) or crashboot (unexpected shutdown or reset) which can be useful even if you don't have the need to maintain a logfile. You can use this logic to update/silence your monitoring system or even send an e-mail alert (upon detecting a crashboot) etc.

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

# Grab the last Event 6009 entry (InstanceId 2147489657)
$cleanboot = Get-EventLog -LogName System -Source EventLog -InstanceId 2147489657 -Newest 1

# Look for Event 6008 (InstanceId 2147489656) immediately above/below
$crashboot = Get-EventLog -LogName System -Source EventLog -InstanceId 2147489656 -After $cleanboot.TimeGenerated.AddSeconds(-3) -Before $cleanboot.TimeGenerated.AddSeconds(3) -ErrorAction SilentlyContinue

# If $crashboot is empty then assume it is a cleanboot
If (!($crashboot))
	{
    $Time = $cleanboot.TimeGenerated.ToString()
    $UserName = $cleanboot.UserName
    $EventType = "cleanboot"
    $Process = $cleanboot.Source
    $ReasonCode = ""
    $Comment = ""
    $Message = $cleanboot.Message
    
    # Perform any other actions you want for a cleanboot

    }
    else
	{
    $Time = $crashboot.TimeGenerated.ToString()
    $UserName = $crashboot.UserName
    $EventType = "crashboot"
    $Process = $crashboot.Source
    $ReasonCode = ""
    $Comment = ""
    $Message = $crashboot.Message
    
    # Perform any other actions you want for a crashboot
    
    }

#Add event contents to logfile
Add-content -Path $logfile "$Time,$UserName,$EventType,$Process,$ReasonCode,$Comment,$Message"

# Add any actions you want performed at every startup below this line
# E.g. You can update the monitoring system, send an e-mail or do something else
# You can also re-use the startup event variables in your code