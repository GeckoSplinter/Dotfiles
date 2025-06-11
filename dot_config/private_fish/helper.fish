# Writing a fish shell function to setup a local git config for username email and signingkey

function git_setup_local
    git config --local user.name "Gecko Splinter"
    git config --local user.email "gecko.splinter@gmail.com"
    git config --local user.signingkey C99015B62BBEB6FE
    git config --local commit.gpgsign true
end
