#
# Finds vim running under tmux and opens given files in tabs.
# Also, attempts to focus the OS window (e.g. xterm) that tmux is running,
# but this is only working for Linux xterms and if wmctrl is available.
#
# It finds the first vim as follows:
#
# - Use tmux list-panes to find ttys of all panes.
#
# - Find first of those ptys with a process with "vim" in it's name.
#
# Opens given files in new vim tabs in the first tmux panel with "vim" in it's
# name and selects that tmux pane and tmux window (thereby giving it focus).
# 


files=$*

realpath() {
    # find full path to file
    # default to "." if no file given
    # this will have the effect of opening up a file browser in the new tab
    f=${1-.}
    echo $(cd $(dirname $f); pwd)/$(basename $f)
}

get_parent_pid() {
    local pid=$1
    #echo $(ps -o ppid= -p $1)
    set -- $(ps -p $pid)
    echo $2
}

ps_tty_cmd() { # just TTY and COMMAND column for every process
    # ps -e on uname CYGWIN...
    #    PID    PPID    PGID     WINPID   TTY     UID    STIME COMMAND
    #   8248    8780    8248       8064  pty4    1001 15:34:35 /usr/bin/ps
    #   6224    6976    6224       7572  pty3    1001   Apr 28 /usr/bin/bash
    #   5112       1    5112       5112  ?       1001   Apr 28 /usr/bin/mintty
    #   3760     992    3760      11260  pty0    1001   Apr 28 /usr/bin/tmux
    if [[ `uname` =~ CYGWIN ]]
    then
        # no ps -o on cygwin
        ps -e | awk '{print $5, $NF}'
    else
        ps -e -o tty,cmd
    fi
}

get_vim_pane_id() {  # print id of first tmux pane with a vim tty
    format="#{session_name}:#{window_index}.#{pane_index} #{pane_tty}"
    # tmux gives output like this:
    #   3:1.0 /dev/pts/10
    #   4:1.0 /dev/pts/3
    #   4:1.1 /dev/pts/5
    #   4:2.0 /dev/pts/4

    # find ptys of all processes with "vim" in command name
    declare -A vim_pts_bag
    while read pts cmd
    do
        [[ ! ($cmd =~ "vim") ]] && continue
        vim_pts_bag["$pts"]="in_the_bag"
    done < <(ps_tty_cmd)

    # print id of first tmux pane with a vim tty
    while read id pts
    do
        pts=${pts#/dev/}
        if [[ ${vim_pts_bag[$pts]} == "in_the_bag" ]]
        then
            echo "$id"
            return
        fi
    done < <(tmux list-panes -a -F "$format")
}

#echo $(get_vim_pane_id)
## Select the first pane running vim.
#format='#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}'
#set -- $(tmux list-panes -a -F "$format" | grep vim)
#pane_id=$1

pane_id=$(get_vim_pane_id)
if [[ -z $pane_id ]]
then
    echo "ERROR: couldn't find a pane with vim cmd on it's tty"
    exit 1
fi
tmux select-pane -t $pane_id

# Send :tabedit commands to vim for each file.
Esc=$'\E'
CR=$'\r'
for file in $files
do
    file=`realpath $file`
    tmux send-keys -l -t $pane_id "${Esc}:tabedit ${file}${CR}"
done

# Focus the tmux window.
win_id=${pane_id%.*}        # e.g. "0:1.2" becomes "0:1"
tmux select-window -t $win_id

# Attempt to focus the X window (e.g. xterm).
# The X window is not the ancestor of vim.
# But it is the ancestor of the tmux session.
if [[ ! -x `which wmctrl 2>/dev/null` ]]
then
    echo "INFO: wmctrl not available, unable to focus X window"
    exit
fi
session_id=${win_id%:*}     # e.g. "0:1" becomes "0"
set -- $(tmux list-clients -F "#{client_session} #{client_tty}" |
         grep "^${session_id} ")
pts=$2
pts=${pts#/dev/}        # e.g. "/dev/pts/2" becomes "pts/2"

get_tmux_pts_pid() { # return pid of tmux session on given pts
    local pts=$1
    set -- $(ps -e -o pid,tty,cmd | grep tmux | grep $pts)
    return $1
}

pid=$(get_tmux_pts_pid $pts)    # pid of tmux session on that pts
pid=$(get_parent_pid $pid)      # parent of tmux is the shell
pid=$(get_parent_pid $pid)      # parent of shell should be the X window
set -- $(wmctrl -lp | grep $pid)
win_id=$1
wmctrl -i -a $win_id
