# PSKVStore
Very basic file system backed key-value store. Intended to be used with Distributed File System (DFS) - store the settings in a replicated fileshare for increased resilience.


```Powershell
Import-Module PSKVStore
Set-KVStoreRoot "\\blah.com\A_DFS_share"
Set-KVStoreItem -Key "MySetting" -Value "127.0.0.1"
Get-KVStoreItem -Key "MySetting"
```