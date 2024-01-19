function __dev_search_terms
    for dir in (find "$HOME/Developer" -type d -maxdepth 2 -mindepth 2 -exec basename {} \;)
        echo $dir
    end
end

function __dev_commands
    echo "h: Open with helix"
    echo "c: Open with VSCode"
end

complete -c dev -f -n "__fish_use_subcommand" -a "(__dev_search_terms)"
complete -c dev -f -n "__fish_seen_subcommand_from dev_commads" -a "(__dev_commands)"
