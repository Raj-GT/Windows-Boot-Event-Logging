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
    Version:     1.1
    Author:      Nimal Raj
    Revisions:   12/07/2017      Initial draft of v1.1
#>