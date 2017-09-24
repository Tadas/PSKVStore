﻿$ErrorActionPreference = "Stop"

$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

foreach($Import in @($Public + $Private)){
	Write-Verbose "Loading $($Import.FullName)"
	try {
		. $Import.FullName
	} catch {
		Write-Error -Message "Failed to import function $($Import.FullName): $_"
	}
}

Set-KVStoreRoot ( [System.IO.Path]::Combine($PSScriptRoot, "KVStore") )

Export-ModuleMember -Function $Public.Basename