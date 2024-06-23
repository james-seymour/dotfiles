# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jamesseymour/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/jamesseymour/.fzf/bin"
fi

source <(fzf --zsh)
