# source private zsh
source ~/.private.zsh

# autocomplete
autoload -U compinit
compinit
zstyle ':completion:*' special-dirs true

# prompt
autoload -U colors && colors
PROMPT="%{$fg[grey]%}[%n] %{$fg[red]%}%~ %{$fg[green]%}\$\$\$ %{$reset_color%}"

# add to path
export PATH=/Users/davejachimiak/bin:$PATH
export PATH=./bin:$PATH

# aliases
## *nix
alias cp="cp -iv"
alias rm="rm -iv"
alias mv="mv -iv"
alias ls="ls -FGh"
alias less="less -R"
alias via="vi -c AsyncTests"
alias tf="terraform"

## Ruby
alias b="bundle"
alias be="b exec"
alias bake="b exec rake"
alias rspec="be rspec"

## Haskell
alias ch="ghc --make"
alias cb="cabal build"

## Git
function g {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status -sb
  fi
}
compdef g=git
export GIT_EDITOR=vi

alias gl="g l"
alias gd="g diff"
alias gbam="g fetch && git rebase origin/master"
