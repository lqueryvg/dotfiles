dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

logAndRun() {
    cmd=$*
    echo $cmd
    $cmd
}

logAndRun mkdir -p $olddir
logAndRun cd $dir

while read file
do
    if [[ ! -L $file ]]
    then
        logAndRun mv ~/$file $olddir
        logAndRun ln -s $dir/$file ~/$file
    else
        echo "$file is already a link"
    fi
done < $dir/dotfiles_list
