function Set-KVStoreRoot {
	Param(
		[Parameter(Mandatory = $true, Position = 1)]
		[string]$Path
	)

	$script:KVStore_Root_Path = $Path
}