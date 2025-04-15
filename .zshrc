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

# FZF configuration
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

_fzf_comprun() {
    local cmd=$1 
    shift 

    case "$cmd" in 
        cd)
            fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
        export|unset)
            fzf --preview "eval 'echo ${}'" "$@" ;;
        ssh)
            fzf --preview 'dig {}' "$@" ;;
        *)
            fzf --preview "$show_file_or_dir_preview" "$@" ;;
    esac
}

# variables
export EDITOR="nvim"
export SUDO_EDITOR="$HOME/.local/share/bob/nvim-bin/nvim"
export PATH="$PATH:$HOME/.local/bin"
export BAT_THEME='gruvbox-dark'


# Plugins
zinit light zsh-users/zsh-completions
zinit light felipec/git-completion
zinit light Aloxaf/fzf-tab
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light akash329d/zsh-alias-finder
zinit light zsh-users/zsh-autosuggestions

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::systemd
zinit snippet OMZP::command-not-found
zinit snippet OMZP::colored-man-pages

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --color $realpath'

# Load completions
autoload -Uz compinit && compinit
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

# Source other files 
eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias tf)"
eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.zsh_alias
