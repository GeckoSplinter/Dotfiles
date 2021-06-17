# Config
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR vim
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -x TERM xterm-256color
set -x TZ 'Europe/Paris'

# PATH
set -x PATH "/usr/local/sbin" $PATH
set -x PATH "$HOME/ops-bin" $PATH
set -x PATH "$HOME/.istioctl/bin" $PATH

# Zoxide CD fuzy replacement
zoxide init fish | source

# Golang config
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH

# Theme
set -g theme_nerd_fonts yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes

# Work stuff
source $HOME/.config/fish/work.fish
source $HOME/.config/fish/cloud.fish

# Linux ssh-agent
fish_ssh_agent

# Fixup ssh from alacritty
alias ssh "env TERM=xterm-256color ssh"

# K8s
abbr -a k "kubectl"
abbr -a kpdbfail "kubectl get pdb -A -o json  | jq -r '.items[] | select(.status.disruptionsAllowed == 0) | .metadata.namespace + \"/\" + .metadata.name'"

# GIT
abbr -a glola "git log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
abbr -a gbrrm "git branch --merged | ag -v \"(^\*|master)\" | xargs git branch -d"
abbr -a gbrls 'git branch --sort="-committerdate" --format="%(color:green)%(committerdate:relative)%(color:reset) %(refname:short)"'

# K8s Krew
set -gx PATH $PATH $HOME/.krew/bin

# Keychain
eval (keychain --eval --agents ssh -Q --quiet t.perronin.id_ed25519 --nogui)
