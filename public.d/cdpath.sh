mkdir -p ~/cdpath
export CDPATH=~/cdpath

if [[ -d /Volumes/Keybase ]]
then
  ln -sf /Volumes/Keybase ~/cdpath/keybase
fi
