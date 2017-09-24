function Remove-KVStoreItem {
	[OutputType([String])]
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, Position = 1)]
		[ValidatePattern('^[a-zA-Z0-9_\-\\.]+$')]
		[string]$Key
	)

	$FullPath = [System.IO.Path]::Combine($KVStore_Root_Path, $Key)
	Write-Verbose "Item Path = $FullPath"

	if (Test-Path -Type Leaf -LiteralPath $FullPath) {
		Write-Verbose "Removing"
		Remove-Item -LiteralPath $FullPath | Out-Null
	} else {
		Write-Verbose "Does not exist"
	}
}