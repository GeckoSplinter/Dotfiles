# Config
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR nvim
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
alias vim 'nvim'
set -x SPACEFISH_KUBECONTEXT_SYMBOL "⎈ "

# PATH
set -x PATH "/usr/local/sbin" $PATH
set -x PATH "$HOME/ops-bin" $PATH
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.composer/vendor/bin
fish_add_path /opt/homebrew/opt/openvpn/sbin
fish_add_path $HOME/.rd/bin
fish_add_path $HOME/.local/bin

# Golang config
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
set -x PATH $HOME/.krew/bin $PATH

# Yabai disable mouse for fusion
function yabai_disable_mouse
    yabai -m config mouse_follows_focus off
    yabai -m config focus_follows_mouse off
end
function yabai_enable_mouse
    yabai -m config mouse_follows_focus on
    yabai -m config focus_follows_mouse autofocus
end

# Rust config
set -x PATH "$HOME/.cargo/bin" $PATH


# SOPS
set -x SOPS_AGE_KEY_FILE "$HOME/.config/sops/age/keys.txt"

# Kubernetes
set -gx PATH $PATH $HOME/.krew/bin

# Theme
set -g theme_nerd_fonts yes
set -g theme_display_k8s_context yes
set -g theme_display_k8s_namespace yes

# Work stuff
# # TODO migrate to omf plugin
# source $HOME/.config/fish/work.fish
source $HOME/.config/fish/helper.fish

# Defaut browser
alias dbc='osascript $HOME/Perso/Dotfiles/macos-helper/setDefaultBrowser.scpt chrome'
alias dbb='osascript $HOME/Perso/Dotfiles/macos-helper/setDefaultBrowser.scpt browser'


abbr -a glola "git log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
abbr -a glol "git log --graph --pretty=format:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"

# Kubernetes
abbr -a k "kubectl"
abbr -a kp "kubectl get pods"
abbr -a ka "kubectl get all,cm,secret,sa"

abbr -a s "kitten ssh"

starship init fish | source
zoxide init --cmd cd fish | source
