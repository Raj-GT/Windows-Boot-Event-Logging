# Windows-Boot-Event-Logging
*PowerShell scripts to log startup (cleanboot/crashboot) and shutdown (restart) events*

When run (preferably via Group Policy as startup and shutdown scripts) the scripts will create/update a simple CSV logfile with the startup/shutdown event information from the machine.

The startup script can even identify if the last boot was a **cleanboot** (orderly shutdown or restart) or **crashboot** (unexpected shutdown or reset) which can be useful even if you don't have the need to maintain a logfile. You can use this logic to update/silence your monitoring system or send an e-mail alert (upon detecting a crashboot) etc.

An article I wrote on an earlier version of these scripts is available at https://www.experts-exchange.com/articles/25559/Windows-boot-event-logging-and-monitoring-with-PowerShell.html
