if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set env variables
set -gx PATH /opt/homebrew/opt/binutils/bin $PATH
set -gx PATH /opt/homebrew//bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/Library/Python/3.9/bin $PATH
set -gx PATH_TO_FX $HOME/.sdk/javafx-sdk-21.0.1/lib
# set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home
set -gx FDOTS $HOME/.config/fish
set -Ua fish_user_paths $HOME/.cargo/bin
set -gx BDT $HOME/Documents/Acadamics/sem3.5/BDT
set -gx CCDE $HOME/Documents/Acadamics/sem3.5/CCDE
set -gx clientid 1208484529510154260
set -gx DISCORD_APP_ID 996864734957670452
set -gx PYSPARK_PYTHON /opt/homebrew//bin/python3

set -g fish_follow_symlinks 1

# remove the annoying greeting msg
set fish_greeting

# misc 
alias ls="eza --icons"
alias refresh="source $FDOTS/config.fish"
alias cls="clear"
alias hxf="hx $FDOTS"

alias tree="eza --icons -la -T --level 3 --git-ignore"

# git
alias gs="git status"
alias gadd="git add"
alias gcomm="git commit -m"
alias gpush="git push"

#brew
alias install="brew install"
alias search="brew search"
alias uninstall="brew uninstall"
alias clean="brew autoremove && brew cleanup"
alias list="brew list"
alias update="brew update && brew upgrade"

alias awk="gawk"

starship init fish | source
~/.cargo/rise_code/launcher.sh

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

 source /Users/junaadh/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
