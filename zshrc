# source private zsh
source ~/.private.zsh

# autocomplete
autoload -U compinit
compinit
zstyle ':completion:*' special-dirs true

# prompt
autoload -U colors && colors
PROMPT="%{$fg[red]%}%~ %{$fg[green]%}\$\$\$ %{$reset_color%}"

# add to path
export PATH=$PATH:/Users/davejachimiak/github/redo
export PATH=$PATH:/Users/davejachimiak/Library/Haskell/bin
export PATH=$PATH:/Users/davejachimiak/bin

# go
export GOPATH=~/github

# aliases
## *nix
alias cp="cp -iv"
alias rm="rm -iv"
alias mv="mv -iv"
alias ls="ls -FGh"
alias less="less -R"
alias via="vi -c AsyncTests"

## Ruby
alias b="bundle"
alias be="b exec"
alias bake="b exec rake"
alias rspec="be rspec"
alias cucumber="be cucumber"

## Haskell
alias ch="ghc --make"

## Git
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status -sb
  fi
}
compdef g=git

alias gl="g l"
alias gd="g diff"
alias gbam="g fetch && git rebase origin/master"

# added by travis gem
source /Users/davejachimiak/.travis/travis.sh
