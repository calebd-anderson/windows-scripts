Write-Host "ipinfo.io`n"
$id = 0
while($ipAddr -ne 'q') {
	$ipAddr = Read-Host -Prompt "Enter an ip address ('q' to quit)"
	if($ipAddr -ne 'q') {
		$id++
		Invoke-RestMethod -Uri ('http://ipinfo.io/'+("$ipAddr"))
		Write-Host "-------------------$id--------------------`n"
	}
}
