
autoload -Uz promptinit

# zsh builtin config
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
HISTFILE=$HOME/.zhistory
SAVEHIST=100000
HISTSIZE=100000
CLICOLOR=1

# vim
export VISUAL=nvim
export EDITOR="$VISUAL"
export VIMRUNTIME=/snap/bin/nvim

# git
export GCM_CREDENTIAL_STORE=cache

# airflow-ish
export AIRFLOW_HOME="/home/jamesseymour/"
export DAGSTER_HOME="/home/jamesseymour/Cubiko/dagster"

# gurobi
export GUROBI_HOME=/opt/gurobi951/linux64
export LD_LIBRARY_PATH=/opt/gurobi951/linux64/lib

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# path
path+=('/opt/gurobi951/linux64/bin')
path+=('/home/jamesseymour/anaconda/bin')
path+=('/home/jamesseymour/.poetry/bin')
path+=('/usr/local/go/bin')
path+=('/home/jamesseymour/.local/share/pnpm')
path+=('/root/.local/bin')

# aliases

# alias nvim to vim for convenience
if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

# Temporal alias
alias tctl="docker exec temporal-admin-tools tctl"

# Uni aliases
alias uni="cd ~/OneDrive/Uni\ Year\ 3/"
alias moss="ssh s4641758@moss.labs.eait.uq.edu.au"

# Tmux aliases
alias Tcub="tmux new -A -s Cubiko"
alias Tcubdev="tmux new -A -s CubikoDev"
alias Tuni="tmux new -A -s Uni"
alias T="tmux new -A -s clowntown"


# Config aliases
alias vc="vim $HOME/.vimrc"
alias zc="vim $HOME/.zshrc"
alias kc="vim $HOME/kitty.conf"
alias tc="vim $HOME/.tmux.conf"
alias szc="source $HOME/.zshrc"

# Git aliases
alias gcm="git commit"
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

alias newpush="git rev-parse --abbrev-ref HEAD | xargs git push -u origin"

# Cubiko aliases!
alias cdman="cd $HOME/Git-Cubiko/cubiko-manage"
alias cdcube="cd $HOME/Git-Cubiko/cubiko-manage/cube/"
alias cddata="cd $HOME/Git-Cubiko/data-pipeline"

alias up="cd $HOME/Git-Cubiko/cubiko-manage; sudo /etc/init.d/redis-server stop; bin/up.sh"
alias dev="cd $HOME/Git-Cubiko/cubiko-manage; bin/dev-server-mocked.sh"
alias cube="cd $HOME/Git-Cubiko/cubiko-manage/cube; npm run dev"

alias Vman="cd $HOME/Git-Cubiko/cubiko-manage; vim"
alias Vcube="cd $HOME/Git-Cubiko/cube-snowflake-poc; vim"
alias Vdata="cd $HOME/Git-Cubiko/data-pipeline; vim"

alias cenv="source $HOME/Git-Cubiko/data-pipeline/env.sh; source $HOME/Git-Cubiko/cubiko-manage/db/.venv/bin/activate"
alias denv="source $HOME/Git-Cubiko/data-pipeline/env.sh; source $HOME/Git-Cubiko/data-pipeline/.venv/bin/activate"
alias dbtp="vim ~/.dbt/profiles.yml"
alias proj="vim ~/Git-Cubiko/data-pipeline/dbt/bp/dbt_project.yml"

alias drs="doit run:dbt:bp run --practice-id demo001"
alias dcs="doit run:dbt:bp compile --practice-id demo001"
alias dts="doit run:dbt:bp test --practice-id demo001"
alias dss="./doit run:dbt:bp seed --practice-id demo001"
alias drc="doit run:dbt:bp run --dialect clickhouse --practice-id demo001"
alias dcc="doit run:dbt:bp compile --dialect clickhouse --practice-id demo001"
alias dtc="doit run:dbt:bp test --dialect clickhouse --practice-id demo001"
alias dsc="./doit run:dbt:bp seed --dialect clickhouse --practice-id demo001"

alias cing="python -m data_pipeline.cmd.ingest_clickhouse_practice best_practice chc001 --data-source raw"
alias rcrc="python -m data_pipeline.cmd.reconcile_clickhouse_rowcounts james.seymour@cubiko.com.au --practice-id dok001 --environment dev"
alias rct="python -m data_pipeline.cmd.reconcile_clickhouse_tables james.seymour@cubiko.com.au --practice-id demo001"

alias doit="./doit"
alias dags="python -m data_pipeline.dags.data_pipeline_dags"

alias login="aws sso login"
alias filecount="find . -type f | cut -d"/" -f2 | uniq -c"

alias startch="sudo systemctl start clickhouse-server"
alias stopch="sudo systemctl stop clickhouse-server"
alias cc="clickhouse-client --password password"


# Kube config
kx() {
  kubectl config use-context "$1"
}
alias kxlocal="kx kind-kind"
alias kxcub="kx arn:aws:eks:ap-southeast-2:512832504782:cluster/k8s-cluster-prod-ap-southeast-2-eks"

# Alias ls for exa
alias ls='exa'

# Plugins for zsh for behave a little like fish
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH completions
fpath=(~/.zsh/tabcompletion $fpath)
autoload o-Uz compinit && compinit

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

autoload -U +X bashcompinit && bashcompinit
