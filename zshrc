### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

export EDITOR="nvim"
export SUDO_EDITOR="vim"
export PATH="$PATH:/home/aiden/.local/bin:/home/aiden/.oh-my-posh:/home/aiden/.nvim/bin:$HOME/.local/bin/gems/bin"
export GEM_HOME="$HOME/.local/bin/gems"
export SSH_AUTH_SOCK="~/.1password/agent.sock"
export NVM_DIR="$HOME/.nvm"
export ZSH_COLORIZE_STYLE="dracula"
export PATH=$PATH:/home/aiden/.spicetify


# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab

# Snippets 
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found 
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::extract 
zinit snippet OMZP::rsync 
zinit snippet OMZP::colorize
zinit snippet OMZP::docker-compose

# Load completions
autoload -U compinit  && compinit
zinit cdreplay -q

# Keybinds
bindkey -e
bindkey '^p' history-search-backward 
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=5000
HISTDUPE=erase 
setopt appendhistory
setopt sharehistory 
setopt hist_ignore_space 
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

eval "$(oh-my-posh init zsh -c ~/.oh-my-posh/themes/custom.omp.toml)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# external files

aliasFile="$HOME/.zsh_aliases.sh"
[[ -e $aliasFile ]] && source "$aliasFile"