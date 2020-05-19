## Or .bash_profile for MacOS

## GENERAL
alias ..='cd ..'
alias ...='cd ../..'
alias ip='ip addr'
alias rm='rm -rf'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -v'
alias less='less -FSRXc'
alias ls='ls -lhF --color=auto'
alias ll='ls -lahF --color=auto'
alias up='yay -Syu --devel --timeupdate' # Update system
alias stat='yay -Ps' # Print system statistics
alias clean='yay -Yc' # Clean unneeded dependencies

## DOCKER
alias d='docker-compose up'
alias dc='docker-compose'
alias dd='docker-compose down'
alias de='docker exec -it'
alias dup='docker-compose down && docker-compose pull && docker-compose up -d' # update Docker Image
alias dcp='docker container prune --filter "until=12h"' # remove all container older than 12 hours
alias dip='docker image prune -a --filter "until=12h"' # remove all images older than 12 hours
alias dnp='docker network prune --filter "until=12h"' # remove all network older than 12 hours
alias dvp='docker volume prune' # remove all volume older than 12 hours
alias dsp='docker system prune --volumes' # remove everything unused

# Start up SSH session with tmux open
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo "(${BRANCH}${STAT}) "
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    modified=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${modified}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

# Colored Shell Prompt with git status
export PS1="[\[\e[1;32m\]\u\[\e[m\]@\[\e[1;31m\]\h\[\e[m\] \[\e[1;30m\]\W\[\e[m\]]\\$ \[\e[1;36m\]\`parse_git_branch\`\[\e[m\]"

# Enable Colored ls for MacOS
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
