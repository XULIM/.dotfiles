# profile for: bobillibo@arch
[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
XDG_CONFIG_HOME="~/.config"
export TERM="xterm-256color"

# misc
alias ll="eza -l --header --color=always"
alias la="eza -la --header --color=always"
alias wcopy="wl-copy"
alias wpaste="wl-paste"

# vim alias
alias v="vim"
alias vi="vim"

# nvim alias
alias nvidiff="nvim -d"

# git alias
alias g="git"
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# tmux alias
alias tm="tmux"
alias ta="tmux a -t"
alias tk="tmux kill-session -t"

# PS1 CUSTOMIZATIONS ===

bold="\[\e[1m\]"
# PS1 colors ---
nm="\[\e[0m\]" # normal (resets the colors)
red="\[\e[31m\]" # modified
blue="\[\e[34m\]"
cyan="\[\e[36m\]"
green="\[\e[32m\]" # added/staged
magenta="\[\e[35m\]"
dark_gray="\[\e[90m\]" # untracked
light_green="\[\e[92m\]" # incoming pulls
light_yellow="\[\e[93m\]" # outgoing commits
kurisu="\[\e[1m\]\[\e[38;5;88m\]" # kurigohan
# ! NOTE: your terminal needs to be compatible with 256 colors to use the kurisu color.
# ---

alias gs="g s 2> /dev/null" # alias in .profile
git_branch()
{
    # sed script from thucnc.medium.com: How to show current git branch with colors in bash prompt
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# git status ---
untrack()
{
    local cnt=$(gs | grep "??" | wc -l)
    if (( $cnt > 0 )) 2> /dev/null; then
        echo " ?${cnt}";
    fi
}
modified()
{
    local cnt=$(gs | grep " M " | wc -l)
    if (( $cnt > 0 )) 2> /dev/null; then
        echo " !${cnt}";
    fi
}
staged()
{
    local cnt=$(( $(gs | grep "M  " | wc -l) + $(gs | grep "A  " | wc -l) ))
    if (( $cnt > 0 )) 2> /dev/null; then
        echo " +${cnt}";
    fi
}
outgoing()
{
    local cnt=$(g st 2>/dev/null | grep "ahead" | sed -E "s/^[^0-9]+([0-9]+).*/\1/g")
    if (( $cnt > 0 )) 2> /dev/null; then
        echo -e " \u21e1${cnt}";
    fi
}
incoming()
{
    local cnt=$(g st 2>/dev/null | grep "behind" | sed -E "s/^[^0-9]+([0-9]+).*/\1/g")
    if (( $cnt > 0 )) 2> /dev/null; then
        echo -e " \u21e3${cnt}";
    fi
}
# ---

# inspired by robbyrussell zsh theme
prompt_pre()
{
    [ ! -z "$(git_branch)" ] && echo " git("
}
prompt_branch()
{
    [ ! -z "$(git_branch)" ] && echo "$(git_branch)"
}
prompt_suf()
{
    [ ! -z "$(git_branch)" ] && echo ")"
}

export PS1="${nm}${kurisu}kurigohan${nm}@${cyan}\W${bold}${blue}\$(prompt_pre)${magenta}\$(prompt_branch)${dark_gray}\$(untrack)${red}\$(modified)${green}\$(staged)${light_green}\$(incoming)${light_yellow}\$(outgoing)${blue}\$(prompt_suf)${bold}${nm} $ \[\e[0m\]"
# ===
