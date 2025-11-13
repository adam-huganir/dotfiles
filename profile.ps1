# Set Python IO encoding to utf-8
$env:PYTHONIOENCODING = "utf-8"

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Custom Functions
function Trace-Read
{
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$DocId,

        [Parameter(Position = 1)]
        [string]$Environment = "production"
    )

    $docIdLower = $DocId.ToLower()

    gcloud --project "redshred-$Environment" logging read --format "value(textPayload)" @"
     resource.labels.cluster_name=~"$Environment"
     resource.labels.container_name="read"
     resource.labels.pod_name=~"$docIdLower"
"@
}

function Which
{
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Command
    )

    $CommandObject = Get-Command $Command -ErrorAction SilentlyContinue
    if ($null -ne $CommandObject)
    {
        $CommandObject.Path
    }
}

#Invoke-Expression "$( thefuck --alias oops )"
$env:STARSHIP_CONFIG = "$HOME\dotfiles\starship.toml"
Invoke-Expression (&starship init powershell)