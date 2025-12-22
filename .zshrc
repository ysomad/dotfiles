export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
    git
    sudo
    web-search
    zsh-autosuggestions
    zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions autocompletion
bindkey "^I"   complete-word       # tab          | complete
bindkey "^[[Z" autosuggest-accept  # shift + tab  | autosuggest
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# nvim
export PATH=$PATH:$HOME/.local/share/nvim/mason/bin

# aliases
alias vi=nvim
alias vim=nvim

# eza (better ls)
alias ls="eza"
alias la="eza -la"

# zoxide (better cd)
eval "$(zoxide init zsh)"
alias cd=z

# go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOBIN

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# remap CapsLock to Ctrl
/usr/bin/hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}' > /dev/null 2>&1

. "$HOME/.local/bin/env"

source ~/.config/.secrets
