# Import our modules and export public functions
"$PSScriptRoot\Private\" |
    Resolve-Path |
    Get-ChildItem -Filter *.ps1 -Recurse |
    ForEach-Object {
      . $_.FullName
    }

"$PSScriptRoot\Public\" |
    Resolve-Path |
    Get-ChildItem -Filter *.ps1 -Recurse |
    ForEach-Object {
      . $_.FullName
      Export-ModuleMember -Function $_.BaseName
    }
