[[ -d $HOME/gopath ]] && export GOPATH=$HOME/gopath
prepend_path_if_exists $HOME/gopath/bin


# TODO - the following conflicts with the above...


# Download go lang and install it to /usr/local (just untar)
# then symlink this file in homedir

# Add GO lang configuration if it is installed
if [ -d /usr/local/go ];then
  export PATH=/usr/local/go/bin:$PATH
fi
which go >/dev/null
if [[ $? -eq 0 ]];then
  export GOPATH=$HOME/workspace/johnb/gogo
  if [[ ! -d $GOPATH ]];then
    mkdir -p $GOPATH/{src/github.com/isindir,bin,pkg}
  fi
  export PATH=$PATH:$GOPATH/bin
fi

