set-executionpolicy remotesigned -scope currentuser
[environment]::setEnvironmentVariable("SCOOP", "C:\Applications\Scoop", "Machine")
$env:SCOOP='C:\Applications\Scoop' # with this we don't need to close and reopen the console
Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://get.scoop.sh")
