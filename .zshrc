# Exports
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
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# pyenv
eval "$(pyenv init -)"

# Aliases
alias vi=nvim
alias vim=nvim

# fix brew doctor pyenv warning
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

# Golang exports for Gopls LSP server
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
