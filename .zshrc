
autoload -Uz promptinit

# zsh builtin config
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
HISTFILE=$HOME/.zhistory
HISTDUP=erase
SAVEHIST=100000
HISTSIZE=100000
CLICOLOR=1

# keybindings
bindkey -v # vim defaults
bindkey '^n' history-search-backward
bindkey '^p' history-search-forward

zstyle ':completion:*' menu no # disable default completion menu

# vim
export VISUAL=nvim
export EDITOR="$VISUAL"

# git
export GCM_CREDENTIAL_STORE=cache

# airflow-ish
export AIRFLOW_HOME=$HOME
export DAGSTER_HOME=$HOME/Cubiko/dagster

# gurobi
export GUROBI_HOME=/opt/gurobi951/linux64
export LD_LIBRARY_PATH=/opt/gurobi951/linux64/lib

# bun
export BUN_INSTALL=$HOME/.bun

# path
path+=("$HOME/.bun/bin")
path+=("/opt/gurobi951/linux64/bin")
path+=("/home/james/anaconda/bin")
path+=("/home/james/.poetry/bin")
path+=("/usr/local/go/bin")
path+=("$HOME/.local/share/pnpm")
path+=("/root/.local/bin")
path+=("$HOME/Git-Cubiko/data-pipeline/.venv/bin")
path+=("$HOME/Git-Cubiko/cubiko-manage/bin/format")
path+=("$HOME/.rye/shims")
path+=("$HOME/.cargo/bin")

# aliases
alias down="docker compose down --volumes"
alias up="docker compose up"

# alias nvim to vim for convenience
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# Config aliases
alias vc="vim $HOME/.vimrc"
alias zc="vim $HOME/.zshrc"
alias kc="vim $HOME/kitty.conf"
alias tc="vim $HOME/.tmux.conf"
alias szc="source $HOME/.zshrc"

# Temporal alias
alias tctl="docker exec temporal-admin-tools tctl"

# Uni aliases
alias uni="cd ~/OneDrive/Uni\ Year\ 3/"
alias moss="ssh s4641758@moss.labs.eait.uq.edu.au"

# Tmux aliases
alias T="tmux new -A -s clowntown"


# Git aliases
alias g="graphene"
alias gco="git checkout"
alias gpl="git fetch && git pull"
alias gps="git push"
alias tags="git push --tags"
gittags() {
  git tag -l "$1/*" --sort -v:refname | head -10
}
gitgrep() {
  git rev-list --all | GIT_PAGER=cat xargs git grep "$1"
}
gitfind() {
  git branch -a --contains "$1"
}
gitreset () {
  git reset HEAD~$1 --soft
}
alias gb='git branch --sort=-committerdate | head -20'

tslap () {
  sudo tailscale file cp "$@" james-seymour-laptop:
}

tshome () {
  sudo tailscale file cp "$@" james-seymour-home:
}

trecv () {
  sudo tailscale file get .
}
pareq() {
  seq $1 | parallel --max-args 0 --jobs $2 $3
}


alias newpush="git rev-parse --abbrev-ref HEAD | xargs git push -u origin"

alias uuid="python -c 'import uuid; print(uuid.uuid4())' | xclip -selection clipboard"

# Cubiko aliases!
alias doit="./doit"
alias login="aws sso login"

alias denv="uv sync --all-packages; source $HOME/Git-Cubiko/data-pipeline/env.sh; source $HOME/Git-Cubiko/data-pipeline/.venv/bin/activate"
alias cenv="source $HOME/Git-Cubiko/data-pipeline/env.sh; source $HOME/Git-Cubiko/cubiko-manage/db/.venv/bin/activate"
alias dbtp="vim ~/.dbt/profiles.yml"

alias drs="doit run:dbt:bp run --practice-id demo001"
alias dcs="doit run:dbt:bp compile --practice-id demo001"
alias dts="doit run:dbt:bp test --practice-id demo001"
alias dss="./doit run:dbt:bp seed --practice-id demo001"
alias drc="doit run:dbt:bp run --dialect clickhouse --practice-id demo001"
alias dcc="doit run:dbt:bp compile --dialect clickhouse --practice-id demo001"
alias dtc="doit run:dbt:bp test --dialect clickhouse --practice-id demo001"
alias dsc="./doit run:dbt:bp seed --dialect clickhouse --practice-id demo001"

alias apireload="curl localhost:3000/token-openapi.json | jq > ~/Git-Cubiko/data-pipeline/py/api_manage_client/src/cubiko/apis/manage/models/manage_api.json && doit codegen"

alias cc="clickhouse-client --password password"

# Calculate aliases
alias mock="echo '00000000-0000-0000-0000-0000000001a4' | xclip -selection clipboard"
alias scs="echo '695e7fc8-ff49-4b1a-b7e0-f8c411bbb7a1' | xclip -selection clipboard"

# Aviator aliases
alias gtco="av stack tree"
alias gtc="av stack branch-commit"
alias gtm="av commit amend"
alias gts="av stack submit"
alias gtsync="av stack sync"
alias gtmove="av stack reorder"
alias gtd="av stack prev"
alias gtu="av stack next"

# Kube config
kx() {
  kubectl config use-context "$1"
}
alias kxlocal="kx kind-kind"
alias kxcub="kx arn:aws:eks:ap-southeast-2:512832504782:cluster/k8s-cluster-prod-ap-southeast-2-eks"

# Alias ls for exa
alias ls='exa'

# ZInit plugins

export ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Enable fzf zsh integration - must happen before zinit fzf-tab
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload o-Uz compinit && compinit

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# eval "$(opam env --switch=default)"
