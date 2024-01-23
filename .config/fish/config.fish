if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set env variables
set -gx PATH /opt/homebrew/opt/binutils/bin $PATH
set -gx PATH /opt/homebrew//bin $PATH
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH_TO_FX $HOME/.sdk/javafx-sdk-21.0.1/lib
set -gx JAVA_HOME /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home
set -gx FDOTS $HOME/.config/fish

# remove the annoying greeting msg
set fish_greeting

# misc 
alias ls="exa --icons"
alias refresh="source $FDOTS/config.fish"
alias cls="clear"
alias hxf="hx $FDOTS"

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

starship init fish | source
