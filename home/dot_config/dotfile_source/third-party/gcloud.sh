_gcloud_sdk="${HOME}/installs/google-cloud-sdk"
[[ -f "${_gcloud_sdk}/path.zsh.inc" ]]       && source "${_gcloud_sdk}/path.zsh.inc"
[[ -f "${_gcloud_sdk}/completion.zsh.inc" ]] && source "${_gcloud_sdk}/completion.zsh.inc"
unset _gcloud_sdk
