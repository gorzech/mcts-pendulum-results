Set-Alias -Name inkscape -Value C:\Users\h2203\PortableApps\InkscapePortable\App\Inkscape\bin\inkscape.exe
# inkscape --export-type=pdf --export-latex .\mean_g_0.5_cp_0.svg

Get-ChildItem ".\docs\svg_fig\dp_U" -Filter *_1.0_*.svg |
Foreach-Object {
    $outfile = $_.FullName 
    Write-Output "Export $outfile"
    inkscape --export-type=pdf --export-latex $outfile | Out-Null
} 