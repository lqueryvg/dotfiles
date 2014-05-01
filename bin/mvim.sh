#
# Opens given files in new vim tabs in the first tmux panel with "vim" in it's
# name and selects that tmux pane and tmux window (thereby giving it focus).
#
# Also, attempts to focus the OS window running tmux (e.g. xterm), but this
# only works for Linux xterms; if wmctrl is available.
#
# It finds the first tmux vim as follows:
#
# 1. Use tmux list-panes to find ptys of all panes.
# 2. Find first of those ptys with a process with "vim" in it's name.
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
    echo $(ps -o ppid= -p $1)
}

ps_tty_cmd() { # list just TTY and COMMAND column for every process
    # ps -e on cygwin:
    #    PID    PPID    PGID     WINPID   TTY     UID    STIME COMMAND
    #   8248    8780    8248       8064  pty4    1001 15:34:35 /usr/bin/ps
    #   6224    6976    6224       7572  pty3    1001   Apr 28 /usr/bin/bash
    if [[ `uname` =~ CYGWIN ]]
    then
        # no ps -o on cygwin
        ps -e | awk '{print $5, $NF}'
    else
        ps -e -o tty,cmd
    fi
}

get_tmux_pane_ttys() {
    local format="#{session_name}:#{window_index}.#{pane_index} #{pane_tty}"
    tmux list-panes -a -F "$format"

    # tmux gives output like this:
    #   3:1.0 /dev/pts/10
    #   4:1.0 /dev/pts/3
    #   4:1.1 /dev/pts/5
    #   4:2.0 /dev/pts/4
}

get_vim_pane_id() {  # print id of first tmux pane with a vim tty

    # find ptys of all processes with "vim" in command name
    # Put them in a "bag".
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
            echo "$id"; return
        fi
    done < <(get_tmux_pane_ttys)
}

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
#
([[ `uname` =~ CYGWIN ]] && 
    echo "INFO: unable to focus window on CYGWIN"; exit 0)

([[ ! -x `which wmctrl 2>/dev/null` ]] && \
    echo "INFO: wmctrl not available, unable to focus X window"; exit 0)

session_id=${win_id%:*}     # e.g. "0:1" becomes "0"
set -- $(tmux list-clients -F "#{client_session} #{client_tty}" |
         grep "^${session_id} ")
pts=$2
pts=${pts#/dev/}        # e.g. "/dev/pts/2" becomes "pts/2"

get_tmux_pts_pid() { # return pid of tmux session on given pts
    local pts=$1
    set -- $(ps -e -o pid,tty,cmd | grep tmux | grep $pts)
    echo $1
}

pid=$(get_tmux_pts_pid $pts)    # pid of tmux session on that pts
pid=$(get_parent_pid $pid)      # parent of tmux is the shell
pid=$(get_parent_pid $pid)      # parent of shell should be the X window
set -- $(wmctrl -lp | grep $pid)
win_id=$1
wmctrl -i -a $win_id
