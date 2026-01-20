# Powerlevel10k instant prompt (must stay near the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh
typeset -U path
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

if [[ -d /opt/homebrew/share/zsh-completions ]]; then
  fpath=(/opt/homebrew/share/zsh-completions $fpath)
fi

plugins=(gitfast web-search zsh-autosuggestions zsh-syntax-highlighting)

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

autoload -Uz compinit
compinit

# Basic Setup
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim

autoload -Uz colors
colors
autoload -Uz select-word-style
select-word-style default
bindkey -e

# History
HISTFILE=$HOME/.zsh_history
HISTSIZE=500000
SAVEHIST=500000
setopt \
  extended_history\
  inc_append_history\
  hist_ignore_all_dups\
  hist_ignore_space\
  hist_reduce_blanks\
  hist_find_no_dups\
  hist_save_no_dups

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' ignore-parents parent pwd ..
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# Key Bindings
bindkey '^R' history-incremental-pattern-search-backward

# Alias
alias vi='nvim'
alias vim='nvim'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -lAF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias -g L='| less'
alias -g G='| grep'

# Git
alias glg='git log --oneline --graph --decorate'
alias gst='git status'
alias gss='git stash'
alias gco='git checkout'
alias gbr='git branch'
alias gft='git fetch origin'
alias gpl='git pull'
alias gad='git add'
alias gcm='git commit'
alias gps='git push'
alias gmg='git merge'
alias gdf='git diff'

# Docker
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'

# PHPStan
alias phpstan='vendor/bin/phpstan analyse'

# OS Settings
case ${OSTYPE} in
  darwin*)
    export CLICOLOR=1
    alias ls='ls -G -F'
    ;;
  linux*)
    alias ls='ls -F --color=auto'
    ;;
esac

# fzf
if type fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
  if [[ "$(uname)" == "Darwin" ]]; then
    FZF_FILES=(
      $HOME/.fzf.zsh
    )
  else
    FZF_FILES=(
      /usr/share/doc/fzf/examples/key-bindings.zsh
      /usr/share/doc/fzf/examples/completion.zsh
    )
  fi
  for f in "${FZF_FILES[@]}"; do
    [[ -f $f ]] && source $f
  done
fi

# Neovim
PATH_DIRS=(
  /opt/homebrew/bin
  /opt/nvim-linux-x86_64/bin
)
for dir in "${PATH_DIRS[@]}"; do
  [[ -d $dir ]] && path=($dir $path)
done

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
