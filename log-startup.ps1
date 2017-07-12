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
    Version:     1.1
    Author:      Nimal Raj
    Revisions:   12/07/2017  Initial draft of v1.1
#>
