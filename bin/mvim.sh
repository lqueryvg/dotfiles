#
# Opens given files in new tabs in the first tmux panel with "vim" in it's name
# and selects that tmux pane and tmux window (thereby giving it focus).
# Also, attempts to focus the xterm tmux is running in with wmctrl if available.
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
    echo $(ps -o ppid= -p $1)
}

# Select the first pane running vim.
format='#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}'
set -- $(tmux list-panes -a -F "$format" | grep vim)
pane_id=$1
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
if [[ ! -x `which wmctrl` ]]
then
    echo "INFO: wmctrl not available, unable to focus X window"
    exit
fi
session_id=${win_id%:*}     # e.g. "0:1" becomes "0"
set -- $(tmux list-clients -F "#{client_session} #{client_tty}" |
         grep "^${session_id} ")
pts=$2
pts=${pts#/dev/}        # e.g. "/dev/pts/2" becomes "pts/2"
set -- $(ps -e -o pid,tty,cmd | grep tmux | grep $pts)
pid=$1       # pid of tmux session
pid=$(get_parent_pid $pid)  # parent of tmux is the shell
pid=$(get_parent_pid $pid)  # parent of shell should be the X window
set -- $(wmctrl -lp | grep $pid)
win_id=$1
wmctrl -i -a $win_id
