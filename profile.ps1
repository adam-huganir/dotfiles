Invoke-Expression (&starship init powershell)

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Set Python IO encoding to utf-8
$env:PYTHONIOENCODING="utf-8"

iex "$(thefuck --alias oops)"