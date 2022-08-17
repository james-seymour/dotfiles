# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# Source Prezto.
#if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
#  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
#fi

HISTSIZE=2000
SAVEHIST=20000 

# Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
#     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
#         eval "$("$BASE16_SHELL/profile_helper.sh")"

# Customize to your needs...

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
autoload -Uz promptinit
#promptinit
#prompt powerlevel10k

export VISUAL=nvim
export EDITOR="$VISUAL"

precmd () {print -Pn "\e]0;%~\a"} # Rename the window to location

IGNOREEOF=10 # Only exit shell on 10 presses of Ctrl-D

export VIMRUNTIME=$HOME/Downloads/nvim-linux64/share/nvim/runtime
export GCM_CREDENTIAL_STORE=cache

export GUROBI_HOME=/opt/gurobi951/linux64
export LD_LIBRARY_PATH=/opt/gurobi951/linux64/lib
path+=('/opt/gurobi951/linux64/bin')
path+=('/home/jamesseymour/anaconda/bin')

# Alias nvim to vim for convenience
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# Uni aliases
alias uni="cd ~/OneDrive/Uni\ Year\ 3/"

# Tmux aliases
alias Tcub="tmux new -A -s Cubiko"
alias Tcubdev="tmux new -A -s CubikoDev"
alias Tuni="tmux new -A -s Uni"

# Config aliases
alias vc="vim $HOME/.vimrc"
alias zc="vim $HOME/.zshrc"
alias kc="vim $HOME/kitty.conf"
alias tc="vim $HOME/.tmux.conf"

# Git aliases
alias gcm="git commit"
alias gco="git checkout"
alias gpl="git fetch && git pull"
alias gps="git push"
gittags() {
  git tag -l "$1/*" --sort -v:refname | head -10
}

alias newpush="git rev-parse --abbrev-ref HEAD | xargs git push -u origin"

# Cubiko aliases!
alias cdman="cd $HOME/Git-Cubiko/cubiko-manage"
alias cdcube="cd $HOME/Git-Cubiko/cube-snowflake-poc"
alias cddata="cd $HOME/Git-Cubiko/data-pipeline"

alias up="cd $HOME/Git-Cubiko/cubiko-manage; sudo /etc/init.d/redis-server stop; bin/up.sh"
alias dev="cd $HOME/Git-Cubiko/cubiko-manage; bin/dev-server-mocked.sh"
alias cube="cd $HOME/Git-Cubiko/cube-snowflake-poc; npm run dev"

alias Vman="cd $HOME/Git-Cubiko/cubiko-manage; vim"
alias Vcube="cd $HOME/Git-Cubiko/cube-snowflake-poc; vim"
alias Vdata="cd $HOME/Git-Cubiko/data-pipeline; vim"

alias cenv="source $HOME/Git-Cubiko/data-pipeline/env.sh; source $HOME/Git-Cubiko/cubiko-manage/.venv/bin/activate"
alias denv="source $HOME/Git-Cubiko/data-pipeline/env.sh; source $HOME/.venv/bin/activate"
alias dbtp="vim ~/.dbt/profiles.yml"

alias login="aws sso login"

export DAGSTER_HOME="/home/jamesseymour/Cubiko/dagster"

# Kube config
[[ $commands[kubectl] ]] && source <(kubectl completion zsh) # Enables autocomplete for kubectl
kx() {
  kubectl config use-context "$1"
}
alias kxlocal="kx kind-kind"
alias kxcub="kx arn:aws:eks:ap-southeast-2:512832504782:cluster/k8s-cluster-prod-ap-southeast-2-eks"

# Alias ls for exa
alias ls='exa'

export CLICOLOR=1

# Plugins for zsh for behave a little like fish
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH completions
autoload -Uz compinit && compinit

eval "$(starship init zsh)"
