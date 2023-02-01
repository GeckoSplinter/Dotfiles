# Config
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR nvim
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
alias vim 'nvim'

# PATH
set -x PATH "/usr/local/sbin" $PATH
set -x PATH "$HOME/ops-bin" $PATH

# Golang config
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
set -x PATH $HOME/.krew/bin $PATH

# Rust config
set -x PATH "$HOME/.cargo/bin" $PATH

# GCLOUD
#set -g -x "CLOUDSDK_PYTHON" "/usr/local/opt/python@3.8/libexec/bin/python"
#source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

# Theme
set -g theme_nerd_fonts yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes

# Work stuff
# # TODO migrate to omf plugin
source $HOME/.config/fish/work.fish


abbr -a glola "git log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
abbr -a glol "git log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"

# Kubernetes
abbr -a k "kubectl"
abbr -a kp "kubectl get pods"
abbr -a ka "kubectl get all,cm,secret,sa"


if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (keychain --quiet --eval --agents ssh,gpg t.perronin.id_ed25519 67B539D168A141B3)
    starship init fish | source
end
