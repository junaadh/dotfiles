if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias refresh="source ~/.config/fish/config.fish"
alias cls="clear"

starship init fish | source
