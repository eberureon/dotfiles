i## GENERAL
alias ..='cd ..'
alias ...='cd ../..'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -v'
alias less='less -FSRXc'
alias ls='ls -lhF --color=auto'
alias ll='ls -lahF --color=auto'
alias delb='echo "🤯 Prune branches" && git remote prune origin && echo "⛔️ Delete branches" && git branch --merged | egrep -v "(^\*|master|develop)" | xargs git branch -d'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

## ARCH SPECIFIC
alias sysup='yay -Syu --devel --timeupdate' # Update system
alias stat='yay -Ps' # Print system statistics
alias clean='yay -Yc' # Clean unneeded dependencies

## DOCKER
alias dc='docker-compose'
alias dd='docker-compose down'
alias de='docker exec -it'
alias dup='docker-compose down && docker-compose pull && docker-compose up -d' # update Docker Image
alias dcp='docker container prune --filter "until=12h"' # remove all container older than 12 hours
alias dip='docker image prune -a --filter "until=12h"' # remove all images older than 12 hours
alias dnp='docker network prune --filter "until=12h"' # remove all network older than 12 hours
alias dvp='docker volume prune' # remove all volume older than 12 hours
alias dsp='docker system prune --volumes' # remove everything unused
