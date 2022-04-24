#!/bin/bash

increaseWatchers() {
  sudo sysctl fs.inotify.max_user_watches=65536
  sudo sysctl -p
}

restartSCD() {
  sudo systemctl restart pcscd
}

addToPath() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$PATH:$1
    fi
}

addToPathFront() {
    if [[ "$PATH" != *"$1"* ]]; then
        export PATH=$1:$PATH
    fi
}

sshAgent() {
  eval $(ssh-agent)
}

sshAgentKeys() {
    #keys=$(find "$HOME/.ssh/" -type f -name "id_*" ! -name "*.pub")
    keys=( "$HOME/.ssh/id_esp" "$HOME/.ssh/id_ecdsa" )
    for key in ${keys[@]}; do
        ssh-add $key
    done
}

fromhex(){
    hex=${1#"#"}
    r=$(printf '0x%0.2s' "$hex")
    g=$(printf '0x%0.2s' ${hex#??})
    b=$(printf '0x%0.2s' ${hex#????})
    printf '%03d' "$(( (r<75?0:(r-35)/40)*6*6 + 
                       (g<75?0:(g-35)/40)*6   +
                       (b<75?0:(b-35)/40)     + 16 ))"
}

