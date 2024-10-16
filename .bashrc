# profile for: bobillibo@arch
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
XDG_CONFIG_HOME="~/.config"
source ~/.venv/bin/activate

# misc
alias ll="eza -la --header --color=always"
alias wcopy="wl-copy"
alias wpaste="wl-paste"

# nvim alias
alias vi="nvim"
alias vidiff="nvim -d"

# git alias
alias g="git"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

kurisu="\e[1m\e[38;5;88m"

git_branch()
{
    # sed script from thucnc.medium.com: How to show current git branch with colors in bash prompt
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

alias gs="g s 2> /dev/null" # alias in .profile
modified()
{
    cnt=$(gs | grep " M " | wc -l)
    if (( $cnt > 0 )) 2> /dev/null; then
        echo -e " \e[31m!${cnt}";
    fi
}
staged()
{
    cnt=$(( $(gs | grep "M  " | wc -l) + $(gs | grep "A  " | wc -l) ))
    if (( $cnt > 0 )) 2> /dev/null; then
        echo -e " \e[32m+${cnt}";
    fi
}
untrack()
{
    cnt=$(gs | grep "??" | wc -l)
    if (( $cnt > 0 )) 2> /dev/null; then
        echo -e " \e[90m?${cnt}";
    fi
}
outgoing()
{
    cnt=$(g st | grep "ahead" | sed -E "s/^[^0-9]+([0-9]+).*/\1/g")
    if (( $cnt > 0 )) 2> /dev/null; then
        echo -e " \e[93m\u21e1${cnt}";
    fi
}
incoming()
{
    cnt=$(g st | grep "behind" | sed -E "s/^[^0-9]+([0-9]+).*/\1/g")
    if (( $cnt > 0 )) 2> /dev/null; then
        echo -e " \e[92m\u21e3${cnt}";
    fi
}

git_prompt()
{
    # inspired by robbyrussell zsh theme
    br=$(git_branch)
    if [[ -z ${br} ]]; then
        echo "";
    else 
        echo -e " \e[1;34mgit(\e[35m${br}$(untrack)$(modified)$(staged)$(incoming)$(outgoing)\e[34m) ";
    fi
}

export PS1="\e[0m${kurisu}kurigohan\e[0m@\e[1;36m\W\$(git_prompt)\e[1;0m$\e[0m "
