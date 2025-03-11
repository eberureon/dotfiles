## GENERAL
alias ..='cd ..'
alias ...='cd ../..'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -v'
alias free='free -h'
alias du='du -h'
alias less='less -FSRXc'
alias ls='ls -lhF --color=auto'
alias ll='ls -lahF --color=auto'
alias wget="wget -c --user-agent 'noleak'"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

## ARCH
alias sysup='yay -Syu --devel --timeupdate' # Update system
alias keyringupdate='yay -Sy archlinux-keyring'
alias stat='yay -Ps' # Print system statistics
alias clean='yay -Yc' # Clean unneeded dependencies

# GIT
alias delb='echo "🤯 Prune branches" && git remote prune origin && echo "⛔️ Delete branches" && git branch --merged | egrep -v "(^\*|master|develop)" | xargs git branch -d'

## DOCKER
alias dc='docker-compose'
alias dcd='docker-compose down'
alias dce='docker exec -it'
alias dcup='docker-compose down && docker-compose pull && docker-compose up -d' # update Docker Image
alias dccp='docker container prune --filter "until=12h"' # remove all container older than 12 hours
alias dcip='docker image prune -a --filter "until=12h"' # remove all images older than 12 hours
alias dcnp='docker network prune --filter "until=12h"' # remove all network older than 12 hours
alias dcvp='docker volume prune' # remove all volume older than 12 hours
alias dcsp='docker system prune --volumes' # remove everything unused
alias dcbp='docker builder prune' # remove build cache

## WEZTERM
alias wz-tab-title='wezterm set-tab-title'
