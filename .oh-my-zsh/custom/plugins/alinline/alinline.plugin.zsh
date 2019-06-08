# aliases without space at the end
typeset -a noTrailingSpaceAliases
noTrailingSpaceAliases=()

balias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  noTrailingSpaceAliases+=(${args##* })
}

# aliases that will not be expanded
typeset -a ignoredAliases
ignoredAliases=()

ialias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  ignoredAliases+=(${args##* })
}

inline-expand-alias() {
  input=$LBUFFER

  if [[ ! $input =~ "(${ignoredAliases/ /|})\$" ]]; then 
    zle _expand_alias
  fi

  zle self-insert
  
  if [[ $input =~ "(${noTrailingSpaceAliases/ /|})\$" ]]; then
    zle backward-delete-char
  fi
}

zle -N inline-expand-alias

bindkey " " inline-expand-alias
bindkey -M isearch " " magic-space
