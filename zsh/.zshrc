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

IGNOREEOF=10 # Only exit shell on 10 presses of Ctrl-D

export VIMRUNTIME=$HOME/Downloads/nvim-linux64/share/nvim/runtime
export GCM_CREDENTIAL_STORE=cache

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
alias gpl="git pull"
alias gps="git push"

# Cubiko aliases!
alias up="cd $HOME/Git-Cubiko/cubiko-manage; sudo /etc/init.d/redis-server stop; bin/up.sh"
alias dev="cd $HOME/Git-Cubiko/cubiko-manage; bin/dev-server-mocked.sh"
alias cube="cd $HOME/Git-Cubiko/cube-snowflake-poc; npm run dev"

alias Vman="cd $HOME/Git-Cubiko/cubiko-manage; vim"
alias Vcube="cd $HOME/Git-Cubiko/cube-snowflake-poc; vim"
alias Vdata="cd $HOME/Git-Cubiko/data-pipeline; vim"

# Alias ls for exa
alias ls='exa'

export CLICOLOR=1

# Plugins for zsh for behave a little like fish
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ZSH completions
autoload -Uz compinit && compinit

eval "$(starship init zsh)"

