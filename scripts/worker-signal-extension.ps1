[System.Environment]::SetEnvironmentVariable('Hangfire_BackgroundJobServerOptions_WorkerCount','10',[System.EnvironmentVariableTarget]::Machine)
[System.Environment]::SetEnvironmentVariable('Hangfire_BackgroundJobServerOptions_Queues','scheduledsignals',[System.EnvironmentVariableTarget]::Machine)
Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools
