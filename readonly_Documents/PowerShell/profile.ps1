# envs
$env:PYTHONIOENCODING = 'utf-8'

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineOption -HistorySearchCursorMovesToEnd

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward


function ExistsInPath($name) {
  $cmdPath = (Get-Command $name -ErrorAction SilentlyContinue)
  return $null -ne $cmdPath
}

if (ExistsInPath "starship") {
  Invoke-Expression (&starship init powershell)
}

# TheFuck alias
if (ExistsInPath "thefuck") {
  Invoke-Expression (&thefuck --alias oops)
}

if (ExistsInPath "chezmoi") {
  Invoke-Expression (&chezmoi completion powershell)
}

if (ExistsInPath "task") {
  Invoke-Expression (&task --completion powershell)
}
function Which($name) {
  Get-Command -ErrorAction SilentlyContinue $name | %{ $_.Path; break; }
}
