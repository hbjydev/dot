#!/bin/bash

alias corebuild="docker compose build --build-arg=github_token=$ESP_GITHUB_TOKEN --build-arg=gitlab_token=$ESP_GITLAB_TOKEN"

alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcl="docker compose logs"
alias dclf="docker compose logs -f"
alias dcc="docker compose cp"
alias dci="docker compose inspect"
alias dce="docker compose exec"
alias dcr="docker compose restart"

# mainly for core dev
alias dcewd="docker compose exec -u www-data"

alias k="kubectl"
alias kw="kubectl -o wide"

alias airplay="gst-launch-1.0 airplaysrc ! queue ! h264parse ! avdec_h264 max-threads=1 ! autovideosink"

alias mk='minikube'
alias tf='terraform'

alias vi='nvim'
alias vim='nvim'
alias e='nvim'

# cheatsheet
function cht() {
  curl cht.sh/$@
}

# go to repository
function gtr() {
  cd $HOME/Repos/$1/$2
}

