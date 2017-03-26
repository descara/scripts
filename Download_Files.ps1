Import-Module BitsTransfer
$urls = Get-Content url.txt


foreach ($url in $urls) {
	$filename =  $url.Substring($url.LastIndexOf("/") + 1)
	Start-BitsTransfer -Source $url -Destination $filename
	Start-Sleep -s 3
}