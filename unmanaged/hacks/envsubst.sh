#!/usr/bin/env zsh

# stupid openwrt doesn't have a proper shell except install zsh and then oly kinda

file="${1:-/dev/stdin}"
envs=($( echo "${2}"))

if [ "${1}" = "--help" ]; then
  echo "Usage: $0 file \"env1 [env2]\" ..." > /dev/stderr
  exit 0
fi

printenv() {
  local to_print env_line
  to_print="$1"
  env_line="$(env | grep -E "^${to_print}=")"
  echo "${env_line#*=}"
}

while IFS= read -r line; do
  filled="$line"
  for env_name in "${envs[@]}"; do
    value="$(printenv "$env_name")"
    if [[ -n "$value" ]]; then
      filled="$(echo "$filled" | sed -r "s(\\$\{${env_name}\}|\\\$$env_name)$valueg")"
    fi
  done
  echo "$filled"
done < "$file"
