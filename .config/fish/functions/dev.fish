function dev
    set search_term $argv[1]
    set path "$HOME/Developer"
    set -l dirs (find "$path" -type d -mindepth 2 -maxdepth 2 -name "$search_term*")

    if test -n "$search_term"
        if test (count $dirs) -gt 0
            cd $dirs[1]
        else
            cd $path
        end
    else
        echo "ERROR: Search term not provided"
    end
end
