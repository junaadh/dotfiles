if status is-interactive
    # Commands to run in interactive sessions can go here
end

# set env variables
set -x PATH /opt/homebrew/opt/binutils/bin $PATH
set -x PATH /opt/homebrew//bin $PATH
set -x PATH_TO_FX $HOME/.sdk/javafx-sdk-21.0.1/lib
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home

# misc 
alias ls="exa --icons"
alias refresh="source ~/.config/fish/config.fish"
alias cls="clear"
alias hxf="hx $HOME/.config/fish"

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
