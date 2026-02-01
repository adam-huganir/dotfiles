# Functions used by .profile

# Usage: add_to_path <dir> [-p|--prepend|-a|--append]
# Default is prepend if no flag is provided
add_to_path() {
  local _dir _mode=prepend _opt
  _mode=prepend

  # Parse options with getopt
  _opt=$(getopt -o 'pa' -l 'prepend,append' -n 'add_to_path' -- "$@")
  [ $? -ne 0 ] && return 1
  eval set -- "$_opt"

  while true; do
    case "$1" in
    -p | --prepend)
      _mode=prepend
      shift
      ;;
    -a | --append)
      _mode=append
      shift
      ;;
    --)
      shift
      break
      ;;
    *) return 1 ;;
    esac
  done

  _dir="$1"
  [ -n "$_dir" ] || return 0
  [ -d "$_dir" ] || return 0

  case ":$PATH:" in
  *":$_dir:"*) ;;
  *)
    if [ "$_mode" = "append" ]; then
      PATH="$PATH:$_dir"
    else
      PATH="$_dir:$PATH"
    fi
    ;;
  esac
}
