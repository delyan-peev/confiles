function addal() {

  if [ "$#" -lt 1 ] || [ "$#" -gt 1 ]; then
    echo "Exactly 1 argument should be provided. It should be {alias-name}=\'{alias-action}\'"
    return
  fi

  arg=$1
  ALIAS_NAME_VALUE=("${(@s/=/)arg}")
  ALIAS_EXISTS=$(alias | grep "\b${ALIAS_NAME_VALUE[1]}=" | wc -l)

  if [ $ALIAS_EXISTS -ne 0 ]; then
    getopts ":f" opt
    if [ $opt -ne 'f' ]; then
      echo "Alias with that name already exists"
      return
    fi

    echo "Adding alias forcefully to the custom config file ($ZSH_CUSTOM_CFG) due to -f flag. This will override the existing alias."
  fi

  echo "alias ${ALIAS_NAME_VALUE[1]}=\"${ALIAS_NAME_VALUE[2]}\"" >> $ZSH_CUSTOM_CFG
}
