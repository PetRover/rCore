# Custom bash prompt via kirsle.net/wizards/ps1.html
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\u\[$(tput setaf 4)\]@\[$(tput setaf 2)\]\h \[$(tput setaf 1)\]\W\[$(tput setaf 2)\]\\$ \[$(tput sgr0)\]"

export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh --color=auto'
