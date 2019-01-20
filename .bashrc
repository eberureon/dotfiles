# Start up ssh session with tmux open
if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi

# Colored Shell Prompt
export PS1='[\[\e[32m\]\u\[\e[m\]@\[\e[1;31m\]\h\[\e[m\] \e[1;30m\]\W\[\e[m\]]$ '
