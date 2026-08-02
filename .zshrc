# --- INTERACTIVE CHECK ---
# Zsh usually only sources .zshrc for interactive shells, but we'll keep the logic
# [[ $- != *i* ]] && return

# --- HISTORY CONFIGURATION ---
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
# Zsh equivalents to HISTCONTROL=ignoreboth and histappend
setopt SHARE_HISTORY          # Share history between all sessions
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded
setopt HIST_IGNORE_SPACE      # Don't record lines starting with a space
setopt APPEND_HISTORY         # Append to history file rather than overwrite

# Load color support
autoload -U colors && colors

# --- ZSH COMPLETION SYSTEM ---
# This replaces the bash-completion block
autoload -Uz compinit
compinit

export EDITOR=nvim
export VISUAL=nvim

# --- ENVIRONMENT VARIABLES & PATH ---
export PATH="/home/ikhovind/.local/bin:$PATH"
export PATH="$PATH:/home/ikhovind/Programs"
export PATH="$PATH:/usr/local/texlive/2024/bin/x86_64-linux"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:/home/ikhovind/Programs/WebStorm-243.22562.222/bin"
export PATH="/home/ikhovind/Programs/bochs-2.8/:$PATH"
export PATH="/home/ikhovind/Programs/bochs-2.8-i/:$PATH"
export PATH="/home/ikhovind/Programs/cursor/:$PATH"
export PATH="/sbin/:$PATH"

# --- LESS & CHROOT ---
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# --- PROMPT SETTINGS ---
# Enable parameter expansion in prompts (required for git function)
setopt PROMPT_SUBST

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (%F{yellow}\1%f)/'
}

# Zsh prompt syntax: %n=user, %m=host, %~=cwd (with ~ for home), %f=reset color
# %F{green}...%f is the Zsh way to colorize text
#PROMPT='${debian_chroot:+($debian_chroot)}%F{green}%n@%m%f:%F{blue}%~%f$(parse_git_branch)%# '
PROMPT='%B%F{green}%n@%m%b%f:%B%F{blue}%~%b%f$(parse_git_branch)%# '
#PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "
#PROMPT='%B%F{32}%n@%m%b%f:%B%F{34}%~%b%f$(parse_git_branch) %# '

# Set terminal title
case "$TERM" in
    xterm*|rxvt*)
        precmd() { print -Pn "\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a" }
        ;;
esac

# --- ALIASES ---
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vim="nvim"
alias acc="source activate.sh"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cnum="bindechexascii"
alias gcane="git commit --amend --no-edit"
alias grc="git rebase --continue"
alias gpfwl="git push --force-with-lease"
alias zshrc="nvim ~/.zshrc" # Updated from bashrc
alias open="/mnt/c/Program\ Files\ \(x86\)/Microsoft/Edge/Application/msedge.exe /usr/bin/edge"
alias sudop='sudo env PATH=$PATH'
alias rgf="rg --files"
alias pbcopy="clip.exe"
alias pbpaste="powershell.exe -command 'Get-Clipboard' | head -n -1"

# The "alert" alias needs a slight tweak for Zsh history output
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1 | sed -e '\''s/^\s*//;s/[;&|]\s*alert$//'\'')"'

# Source separate aliases if they exist
[ -f ~/.zsh_aliases ] && . ~/.zsh_aliases

# --- FUNCTIONS ---
clip() {
    cat "$1" | clip.exe
}

cg() {
    if [ $# -lt 2 ]; then
        echo "Usage: cg <build_type> <output_dir>"
        return 1
    fi
    local build_type="$1"
    local output_dir="$2"
    # Zsh capitalization logic
    build_type="${(C)build_type}"
    cmake -B "$output_dir" -DCMAKE_BUILD_TYPE="$build_type" "${@:3}"
}

cb() {
    if [ $# -lt 1 ]; then
        echo "Usage: cb <build_dir> [additional args]"
        return 1
    fi
    cmake --build "$1" -j 6 "${@:2}"
}

# --- EXTERNAL TOOLS ---
# NVM (Note: Bash completion removed as Zsh uses its own)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Rust/Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# SSH Agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
    ssh-add ~/.ssh/github 2>/dev/null
    ssh-add ~/.ssh/uio_github 2>/dev/null
fi

# Homebrew & Zoxide
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh --cmd cd)" # Updated to zsh init

# 1. Initialize zplug
source ~/.zplug/init.zsh

# 2. Define Plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# zplug "zsh-users/zsh-history-substring-search", defer:3
zplug "plugins/git", from:oh-my-zsh  # (Optional) Borrow the git plugin from OMZ

# 3. Install plugins if they aren't installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# 4. Load the plugins
zplug load

# Register the widgets
zle -N zle-line-init

# Load completion system
autoload -Uz compinit && compinit

# Basic styling for the completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive matching

# Smart Tab: accept suggestion if one is shown, else normal completion
_accept_or_complete() {
    if [[ -n "$POSTDISPLAY" ]]; then
        zle autosuggest-accept
    else
        zle expand-or-complete
    fi
}
zle -N _accept_or_complete
bindkey '^I' _accept_or_complete

# Ctrl+A: clear the suggestion so Tab will do normal completion
reject-suggestion() {
    POSTDISPLAY=""
}
zle -N reject-suggestion
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(reject-suggestion)
bindkey '^A' reject-suggestion

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^H" backward-kill-word
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
eval "$(zellij setup --generate-auto-start zsh)"  # or zsh
