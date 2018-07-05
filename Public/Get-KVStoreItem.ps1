function Get-KVStoreItem {
	[OutputType([String])]
	[CmdletBinding()]
	Param(
		[Parameter(Mandatory = $true, Position = 1)]
		[ValidatePattern('^[a-zA-Z0-9_\-\\.]+$')]
		[string]$Key,

		[switch]$Mandatory
	)

	$FullPath = [System.IO.Path]::Combine($KVStore_Root_Path, $Key)
	Write-Verbose "Item Path = $FullPath"

	if (Test-Path -Type Leaf -LiteralPath $FullPath) {
		Write-Verbose "Item exists, returning content"
		return (Get-Content -Raw -LiteralPath $FullPath)
	} else {
		Write-Verbose "Item does not exist"

		if ($Mandatory) {
			throw "Couldn't retrieve key: $Key"
		} else {
			return $null
		}
	}
}