param (
    $pandoc = 'pandoc',

    $OutputDirectory = "$PSScriptRoot/output"
)

if (-not (Test-Path $OutputDirectory -Type Container)) {
    New-Item $OutputDirectory -Type Directory
}

Get-ChildItem solutions/*.tex | ForEach-Object {
    $name = [IO.Path]::GetFileNameWithoutExtension($_.Name)
    & $pandoc `
        --bibliography=solutions/bibliography.bib `
        --csl=solutions/gost-r-7-0-5-2008-numeric.csl `
        $_ -o "$OutputDirectory/$name.odt"
}
