# envs
$env:PYTHONIOENCODING='utf-8'

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward


function ExistsInPath($name)
{
    $cmdPath = (Get-Command $name -ErrorAction SilentlyContinue)
    return $null -ne $cmdPath
}

if (ExistsInPath "starship")
{
    Invoke-Expression (&starship init powershell)
}

# TheFuck alias
if (ExistsInPath "thefuck")
{
    Set-Alias tf thefuck
}


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile))
{
    Import-Module "$ChocolateyProfile"
}
