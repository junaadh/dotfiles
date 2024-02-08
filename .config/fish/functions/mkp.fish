function mkp
    set -l name $argv[1]
    set -l dirs (find "$HOME/Developer" -type d -maxdepth 2 -mindepth 2 -exec basename {} \;)

    for proj in dirs
        if test "$proj" = "$name"
            echo "project already exists"
            exit(1)
        end
    end
    echo "input language: "
    read -P "language: " language
    echo $language
end
