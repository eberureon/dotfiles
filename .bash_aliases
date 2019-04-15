## GENERAL
alias ..='cd ..'
alias ...='cd ../..'
alias ip='ip addr'
alias l='ls -l'
alias ll='ls -lah'

## DOCKER
alias d='docker-compose up'
alias dd='docker-compose down'
alias de='docker exec -it'
alias dup='docker-compose down & docker-compose pull & docker-compose up -d' # update Docker Image
alias dcp='docker container prune --filter "until=12h"' # remove all container older than 12 hours
alias dip='docker image prune -a --filter "until=12h"' # remove all images older than 12 hours
alias dvp='docker volume prune --filter "until=12h"' # remove all volume older than 12 hours
alias dvp='docker network prune --filter "until=12h"' # remove all network older than 12 hours
alias dsp='docker system prune --volumes' # remove everything unused
