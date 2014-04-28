#
# Opens given files in new vim tabs in the first tmux panel with "vim" in it's
# name and selects that tmux pane and tmux window (thereby giving it focus).
# Also, attempts to focus the xterm tmux is running in with wmctrl if
# available.
#
# Not working on Cygwin because the title of the first vim pane is "bash" which
# is the name of the first process started when the pane is created.  The
# pane's title isn't seen (at least not in my config) except with the tmux
# list-panes command which the script uses.  The only way to change the pane
# title is via control sequences, e.g.
#
#   $ printf '\033]2;My Title\033\\'
#
# But on Cygwin (at least) this has the side effect of also changing the mintty
# title. I wonder if this is a bug in tmux ?  Need a better way of finding the
# first vim.
#
# New approach should be to find the first pane with a tty attached to a vim
# process in ps.  Another script would be handy which lists panes along with
# processes on the same tty.
#
# 1. tmux list-panes     # get pane ids and tty (forget the other info)
#
# 2. Find first vim process in ps on that tty
# DONE - need to test on cygwin
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

get_vim_pane_id() {
    format="#{session_name}:#{window_index}.#{pane_index} #{pane_tty}"
    # get output like this
    #   3:1.0 /dev/pts/10
    #   4:1.0 /dev/pts/3
    #   4:1.1 /dev/pts/5
    #   4:2.0 /dev/pts/4

    declare -A vim_pts_bag
    while read pts cmd rest
    do
        [[ $cmd != "vim" ]] && continue
        vim_pts_bag["$pts"]="in_the_bag"
    done < <(ps -e -o tty,cmd)

    while read id pts
    do
        pts=${pts#/dev/}
        if [[ ${vim_pts_bag[$pts]} == "in_the_bag" ]]
        then
            #echo "$id $pts vim"
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
    echo "ERROR: couldn't find vim pane"
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
