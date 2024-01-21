function __co_programs
    for program in (find "$HOME/.config" -type d -mindepth 1 -maxdepth 1 -exec basename {} \;)
        echo $program
    end
end

complete -c co -f -n "__fish_use_subcommand" -a "(__co_programs)"
