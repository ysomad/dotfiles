export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR=nvim

# plugins
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# starship
eval "$(starship init zsh)"

# zsh-autosuggestions autocompletion
bindkey "^I"   complete-word       # tab          | complete
bindkey "^[[Z" autosuggest-accept  # shift + tab  | autosuggest
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# aliases
alias v=nvim
alias vi=nvim
alias vim=nvim
alias g=git

# eza (better ls)
alias ls="eza"
alias la="eza -la"

# zoxide (better cd)
eval "$(zoxide init zsh)"
alias cd=z

# bat (better cat)
alias cat=bat

# atuin (shell history)
eval "$(atuin init zsh)"

# go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOBIN

# remap CapsLock to Ctrl
/usr/bin/hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x7000000E0}]}' > /dev/null 2>&1
