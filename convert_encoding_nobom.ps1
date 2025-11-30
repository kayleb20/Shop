$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
$files = Get-ChildItem -Path "frontend" -Recurse -Include *.vue,*.js,*.ts,*.css,*.html,*.json -Exclude node_modules,dist,.git
foreach ($file in $files) {
    try {
        $content = [System.IO.File]::ReadAllText($file.FullName)
        [System.IO.File]::WriteAllText($file.FullName, $content, $Utf8NoBomEncoding)
        Write-Host "Converted: $($file.Name)"
    } catch {
        Write-Host "Error processing $($file.Name): $_"
    }
}
