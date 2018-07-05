$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.ps1', '.psd1'
Import-Module "$here\..\$sut" -Force

Describe "PSKVStore" {
	BeforeAll {
		Set-KVStoreRoot "TestDrive:\"
	}

	It "Non-existant returns null" {
		Get-KVStoreItem "DoesNotExist" | Should Be $null
	}

	It "Non-existant mandatory throws an exception" {
		{ Get-KVStoreItem "DoesNotExistButShould" -Mandatory } | Should -Throw "Couldn't retrieve key: DoesNotExistButShould"
	}

	It "Sets an item" {
		$TestSetting = "Setting-$(Get-Random -Minimum 1 -Maximum ([int]::MaxValue))"
		$TestValue = Get-Random -Minimum 1 -Maximum ([int]::MaxValue)

		Set-KVStoreItem -Key $TestSetting -Value $TestValue
		Get-KVStoreItem $TestSetting | Should Be $TestValue
	}

	It "Removes an item" {
		$TestSetting = "Setting-$(Get-Random -Minimum 1 -Maximum ([int]::MaxValue))"
		$TestValue = Get-Random -Minimum 1 -Maximum ([int]::MaxValue)

		Set-KVStoreItem -Key $TestSetting -Value $TestValue
		Get-KVStoreItem $TestSetting | Should Be $TestValue
		Remove-KVStoreItem $TestSetting
		Get-KVStoreItem $TestSetting | Should Be $null
	}
}
