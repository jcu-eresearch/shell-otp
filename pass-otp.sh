#!/bin/bash
completions=(
  /usr/share/bash-completion/pass
  /usr/share/bash-completion/completions/pass
)

for path in "${completions[@]}"; do
    if [ -f "$path" ]; then
        source "$path"
        break
    fi
done

otp() {
  local content="$(pass show "$1")"
  local status=$?
  if [ "$status" -ne 0 ]; then
    echo "$content"
    exit 1
  fi
  oathtool --totp -b -d 6 "$content"
}

_otp()
{
  COMPREPLY=()
  local cur="${COMP_WORDS[COMP_CWORD]}"
  COMPREPLY+=($(compgen -W "${commands}" -- ${cur}))
  _pass_complete_entries 1
}

export -f otp
complete -o filenames -o nospace -F _otp otp
