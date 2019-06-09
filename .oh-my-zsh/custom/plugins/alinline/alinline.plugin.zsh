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

# aliases that will be expanded even if there is text before them
typeset -a globalAliases
globalAliases=()

galias() {
  alias $@
  args="$@"
  args=${args%%\=*}
  globalAliases+=(${args##* })
}

inline-expand-alias() {
  lWord=${BUFFER##* }
  words=($BUFFER)
  
  # Insert the space
  zle self-insert

  # if word is within ignored aliases
  if [[ $lWord =~ "(${ignoredAliases/ /|})" ]]; then
    return
  fi

  # If buffer contains only one word or the last word is within global aliases
  if [[ ${#words[@]} = 1 || $lWord =~ "(${globalAliases/ /|})" ]]; then
    # Search for an alias for that word
    aliasString=$(alias | grep "^$lWord=")

    # If an alias exists
    if [ ${#aliasString} -gt 0 ]; then
      # Split by =
      aliasValue=${aliasString#*=}

      # Replace in buffer
      BUFFER=${BUFFER/$lWord/${aliasValue:1:-1}}
      CURSOR=$#BUFFER

      if [[ $lWord =~ "(${noTrailingSpaceAliases/ /|})\$" ]]; then
        zle backward-delete-char
      fi 
    fi
  fi
}

zle -N inline-expand-alias

# Bind normal space to expand aliases
bindkey " " inline-expand-alias

# Control-space to make a normal space
bindkey -M emacs "^ " magic-space
bindkey -M viins "^ " magic-space

# Normal space during searches
bindkey -M isearch " " magic-space
