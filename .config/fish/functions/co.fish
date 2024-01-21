function __get_window
    set -l path $argv[1]
    set -l tmux_session "config"
    for session in (seq 1 (tmux list-windows -t $tmux_session | wc -l))
        set session_path (tmux display-message -t $tmux_session:$session -p "#{pane_current_path}")
        if test $session_path = $path
            echo $session
            return
        end
    end
    echo -1
end

function co
    set program $argv[1]
    set path "$HOME/.config"
    set -l dirs (find "$path" -type d -name "$program*")
    set tmux_session "config"
    set session_exist (tmux has-session -t $tmux_session; echo $status)
    set session_max (tmux list-windows -t $tmux_session | wc -l)
    set -l window
    
    if test $session_exist -ne 0
        tmux new-session -d -s $tmux_session
    end

    if test -n "$program"
        if test (count "$dirs") -gt 0
            set window (__get_window $dirs[1])
            if test $window -ne -1
                tmux attach-session -t $tmux_session:$window 
            else
                set window_max (math $session_max + 1)
                tmux new-window -t $tmux_session:$window_max
                tmux send-keys -t $tmux_session:$window_max "cd $dirs[1]; clear; hx .; or echo \"ERROR: unable to cd to $dirs[1]\n\"" C-m
                tmux attach-session -t $tmux_session:$window_max
            end
        end
    else
        set window (__get_window $path)
        if test $window -ne -1
            tmux attach-session -t $tmux_session:$window 
        else
            set window_max (math $session_max + 1)
            tmux new-window -t $tmux_session:$window_max
            tmux send-keys -t $tmux_session:$window_max "cd $path; clear; hx .; or echo \"ERROR: unable to cd to $dirs[1]\n\"" C-m
            tmux attach-session -t $tmux_session:$window_max
        end
    end
end
