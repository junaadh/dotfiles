function dev
    set search_term $argv[1]
    set open $argv[2]
    set hx "h"
    set code "c"
    set path "$HOME/Developer"
    set -l dirs (find "$path" -type d -mindepth 2 -maxdepth 2 -name "$search_term*")

    if test -n "$search_term"
        if test (count $dirs) -gt 0
            # zellij a $search_term || zellij -s $search_term # zellij doesnt support advanced scripting so for now switching to tmux
            set session_exist (tmux list-sessions | grep -q -w $search_term; echo $status)

            if test $session_exist -ne 0
                tmux new-session -d -s $search_term
            
                tmux send-keys -t "$search_term" "cd $dirs[1]; clear; or echo \"ERROR: Unable to change directory to $dirs[1]\"" C-m
            end

            if test -n "$open"
                if test "$open" = "$hx"
                    tmux send-keys -t "$search_term" "hx ." C-m
                else if test "$open" = "$code"
                    tmux send-keys -t "$search_term" "code ." C-m
                else
					tmux send-keys -t "$search_term" "clear; echo \"ERROR: Unknown value for 'open': $open\nAccepted values are h: Helix, c: VSCode\n\"" C-m
                end
            end
            tmux attach-session -t $search_term
        else
			echo "ERROR: Project with name startin with $search_term not found in $path"
        end
    else
		echo "ERROR: Search term not provided"
    end
end
