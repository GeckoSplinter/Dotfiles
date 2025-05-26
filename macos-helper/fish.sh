curl -L https://get.oh-my.fish | fish
sudo bash -c 'echo $(which fish) >> /etc/shells'
chsh -s $(which fish)
