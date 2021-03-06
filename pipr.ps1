function run_pip 
{ 
	$url = 'https://pypi.python.org/'; $proxy = [System.Net.WebRequest]::GetSystemWebProxy();
	$proxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials;  
	$proxy_4_url=$proxy.GetProxy($url).AbsoluteUri;

	if ($proxy_4_url.StartsWith($url))
	{
		echo 'no proxy needed, skipping to pip';
	}
	else
	{
		Write-Host  "setting https proxy to: $env:HTTPS_PROXY";
		$env:HTTPS_PROXY = $proxy_4_url;
		Write-Host  "setting http proxy to: $env:HTTP_PROXY";
		$env:HTTP_PROXY = $proxy_4_url;
	}

	$pip_path = (Get-Command pip).Path;
	if ($env:PIP_ARGS -eq $null -Or [string]::IsNullOrEmpty($env:PIP_ARGS.Trim())) 
	{
		& $pip_path;
	}
	else {
		Write-Host "calling $pip_path with $env:PIP_ARGS`n";
		& $pip_path $env:PIP_ARGS.Split(' ');
	}
}

echo "setting up";
$script = $function:run_pip -replace "`n","" -replace "`r","";	
$formatted = '@echo off'+"`r`n"+'SET PIP_ARGS=%*'+"`r`n"+'PowerShell.exe -Command "{0}"' -f $script;
[System.IO.File]::WriteAllText("D:\\pipr.bat", $formatted.Trim())
echo "done";
exit;
