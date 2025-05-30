source ~/.bashrc

# misc
alias ll="eza -l --header --color=always"
alias la="eza -la --header --color=always"
alias wcopy="wl-copy"
alias wpaste="wl-paste"

# vim alias
alias vi="vim"

# git alias
alias g="git"
git config --global alias.a add
git config --global alias.br branch
git config --global alias.cd switch
git config --global alias.ch checkout
git config --global alias.cm commit
git config --global alias.st status
git config --global alias.s "status -s"
git config --global alias.ll status
git config --global alias.ls "status -s"
git config --global alias.unstage 'reset HEAD --'
