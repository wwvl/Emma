$newFiles = git status --porcelain | Where-Object { $_ -match '^\?\? .*\.json$' } | ForEach-Object { $_.Substring(3) }
foreach ($file in $newFiles) {
    $version = jaq -r '.version' $file
    $fileWithoutPathAndExtension = $file -replace '^bucket/', '' -replace '\.json$', ''
    $commitMessage = "{0}: Add version {1}" -f $fileWithoutPathAndExtension, $version
    git add $file
    git commit -m $commitMessage
}
