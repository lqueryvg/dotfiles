
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

echo $(get_vim_pane_id)
