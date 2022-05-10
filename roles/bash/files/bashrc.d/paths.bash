#!/usr/bin/env bash

addToPath /usr/local/go/bin
addToPath $GOPATH/bin
addToPath $HOME/.config/composer/vendor/bin

[[ -d $HOME/.local/bin ]] && addToPath "$HOME/.local/bin"
[[ -d $HOME/.krew ]] && addToPath "${KREW_ROOT:-$HOME/.krew}/bin"
[[ -d $HOME/.pulumi ]] && addToPath "$HOME/.pulumi/bin"

