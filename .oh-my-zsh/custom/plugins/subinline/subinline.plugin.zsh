inline-substitute() {
  local input=$BUFFER

  if [[ $input =~ "(\\$\([A-Za-z_0-9]+\))" ]]; then
    functionName=${match[1]:2:-1}
    functionExists=$(functions | grep "$functionName\\s\?()" | wc -l)

    if [ $functionExists -gt 0 ]; then
      BUFFER=${BUFFER/${match[1]}/$($functionName)}
    fi
  fi
}

zle -N inline-substitute

bindkey "^F" inline-substitute
