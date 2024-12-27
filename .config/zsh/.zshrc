# add custom completions path
fpath=("$ZDOTDIR/completions" $fpath)

# ghostty-integration
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration"
fi

# add hombrew completions
if type brew &>/dev/null; then
  fpath=("$(brew --prefix)/share/zsh-completions" $fpath)
fi


# Zinit Installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# init zsh completions
autoload -Uz compinit
compinit

# Load Zinit and set up annexes and plugins
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit ice wait lucid
zinit load Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload_history_substring_search_config

# fish style history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Zstyle Configuration
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza $realpath -1 --color=always --icons=always --group-directories-first'
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' popup-min-size 50 8
zstyle ':fzf-tab:complete:diff:*' popup-min-size 80 12

# Additional completions
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# ghcup-env
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" 

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
# END opam configuration

# aliases
alias refresh="source $ZDOTDIR/.zshrc"
alias cls="clear"
alias ls="eza --icons"
alias tree="eza --icons -la -T --git-ignore"
alias ..="cd .."

# brew aliases
alias install="brew install"
alias search="brew search"
alias uninstall="brew uninstall"
alias clean="brew autoremove && brew cleanup"
alias list="brew list"
alias update="brew update && brew upgrade"

# custom functions

# developer functions to make opening project easier
dev() {
  local search_term="$1"
  local dev_dir="$HOME/Developer"
  local dirs=($(find "$dev_dir" -type d -maxdepth 2 -mindepth 2 -iname "$search_term*"))

  if [ -n "$search_term" ]; then
    if [ "${#dirs[@]}" -gt 0 ]; then
      builtin cd "${dirs[1]}"
    else
      echo "Error: $search_term not found in $dev_dir"
    fi
  else
    echo "$dev_dir"
  fi
}

# completion for dev function
_dev() {

  _values "search_term" $(find "$HOME/Developer" -maxdepth 2 -mindepth 2 -type d -exec basename {} \;) && return
}

# enable completions
compdef _dev dev
