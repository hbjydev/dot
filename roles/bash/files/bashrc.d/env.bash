# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment

export EDITOR="nvim"

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export PATH="$HOME/.local/share/dotfiles/bin:$PATH"

[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d $HOME/.krew ]] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
[[ -d $HOME/.pulumi ]] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

[[ -x "$(command -v direnv)" ]] && eval "$(direnv hook bash)"
[[ -x "$(command -v scw)" ]] && eval "$(scw autocomplete script shell=bash)"
[[ -x "$(command -v k3d)" ]] && eval "$(k3d completion bash)"

