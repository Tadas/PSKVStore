function Set-KVStoreRoot {
	Param(
		[Parameter(Mandatory = $true, Position = 1)]
		[string]$Path
	)

	# Test read access
	try {
		Get-ChildItem $Path -ErrorAction Stop
	} catch {
		throw "Unable to read from KVStore root: $Path"
	}

	# Test write access
	try {
		$TestFile = [System.IO.Path]::Combine($Path, "TestWriteAccess.txt")
		[System.IO.File]::OpenWrite($TestFile).close()
	} catch {
		throw "Unable to write to KVStore root: $Path"
	}

	$script:KVStore_Root_Path = $Path
}