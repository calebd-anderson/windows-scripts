$myIp = (Invoke-WebRequest ifconfig.me/ip).Content.Trim()
Write-Host "ifconfig.me/ip:" $myIp
Write-Host "ipinfo.io:"
$id = 0
while($ipAddr -ne 'q') {
	$ipAddr = Read-Host -Prompt "Enter an ip address ('q' to quit, 'myip' to return public ip info)"
	if($ipAddr -ne 'q') {
		$id++
		Invoke-RestMethod -Uri ('http://ipinfo.io/'+("$ipAddr"))
		Write-Host "-------------------$id--------------------`n"
	} elseif ($ipAddr -eq 'myip') {
		$id++
		Invoke-RestMethod -Uri ('https://ipinfo.io/what-is-my-ip')
		Write-Host "-------------------$id--------------------`n"
	}
}
