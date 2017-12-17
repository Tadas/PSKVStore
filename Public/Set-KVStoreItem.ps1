function Set-KVStoreItem {
	[OutputType([String])]
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, Position = 1)]
		[ValidatePattern('^[a-zA-Z0-9_\-\\.]+$')]
		[string]$Key,

		[Parameter(Mandatory = $true)]
		[string]$Value
	)

	$FullPath = [System.IO.Path]::Combine($KVStore_Root_Path, $Key)
	Write-Verbose "Item Path = $FullPath"

	if (! (Test-Path -Type Leaf -LiteralPath $FullPath)) {
		Write-Verbose "Item does not exist - creating"
		New-Item -Path $FullPath -ItemType File -Force | Out-Null
	}

	Write-Verbose "Setting content to '$Value'"
	Set-Content -LiteralPath $FullPath -Value $Value -Encoding UTF8 -NoNewline
}