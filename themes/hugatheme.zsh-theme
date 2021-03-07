# Put your custom themes in this folder.
# Example:

right_triangle() {
   echo $'\ue0b0'
}

left_triangle() {
   echo $'\ue0b2'
}

prompt_indicator() {
   echo $'%B\u276f%b'
}

arrow_start() {
   echo "%{$FG[$ARROW_FG]%}%{$BG[$ARROW_BG]%}%B"
}

arrow_end() {
   echo "%b%{$reset_color%}%{$FG[$NEXT_ARROW_FG]%}%{$BG[$NEXT_ARROW_BG]%}$(right_triangle)%{$reset_color%}"
}

arrow_end_l() {
   echo "%b%{$reset_color%}"
}

arrow_start_l() {
   echo "%{$reset_color%}%{$FG[$PREV_ARROW_FG]%}%{$BG[$PREV_ARROW_BG]%}$(left_triangle)%{$reset_color%}%{$FG[$ARROW_FG]%}%{$BG[$ARROW_BG]%}%B"
}

machine_name() {
   BG_NUM=$PROMPT_MACHINE_BACKGROUND_COLOR
   ARROW_FG="016"
   ARROW_BG="$BG_NUM"
   NEXT_ARROW_BG="009"
   NEXT_ARROW_FG="$BG_NUM"
   echo "$(arrow_start) %m $(arrow_end)"
}

dir_path() {
   ARROW_FG="016"
   ARROW_BG="009"
   NEXT_ARROW_BG="011"
   NEXT_ARROW_FG="009"
   echo "$(arrow_start) %~ $(arrow_end)"
}

git_prompt() {
   ARROW_FG="016"
   ARROW_BG="011"
   NEXT_ARROW_BG=""
   NEXT_ARROW_FG="011"
   echo "$(arrow_start) \${\"\$(git_prompt_info)\":0:30} $(arrow_end)"
}

pyenv_name () {
    echo $(pyenv version-name)
}

kubectl_context_abbr() {
   ARROW_FG="016"
   ARROW_BG="003"
   PREV_ARROW_BG="009"
   PREV_ARROW_FG="003"
   CONTEXT=$(kubectl config current-context 2> /dev/null)
   echo "$(arrow_start_l) \${\"\$(kubectl config current-context 2> /dev/null)\"} $(arrow_end_l)"
}

virtualenv_format() {
   ARROW_FG="016"
   ARROW_BG="009"
   PREV_ARROW_BG=""
   PREV_ARROW_FG="009"
   echo "$(arrow_start_l) (\$(pyenv_name)) $(arrow_end_l)"

}

return_code() {
    echo "%(?.%{$fg[green]%}%f.%{$fg[red]%}✘%f) "
}

PROMPT="$(machine_name)$(dir_path)$(git_prompt) "
RPROMPT="$(return_code)$(virtualenv_format)$(kubectl_context_abbr)"
