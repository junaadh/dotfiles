fpath=("$ZDOTDIR/completions" $fpath)

eval "$(starship init zsh)"
eval "$(fzf --zsh)"

if type brew &>/dev/null
then
	fpath=("$(brew --prefix)/share/zsh-completions" $fpath)
fi

autoload -Uz compinit
compinit



dev() {
  local search_term="$1"
  local open="$2"
  local hx="h"
  local code="c"
  local dev="$HOME/Developer"
  local dirs=($(find $dev -type d -maxdepth 2 -mindepth 2 -iname "$search_term*"))

  if [ -n "$search_term" ]; then
    if [ ${#dirs[@]} -gt 0 ]; then
      cd "$dirs[1]" || echo "Error: Unable to change to directory '$dir[1]'"

      if [ -n "$open" ]; then
        if [ "$open" = "$hx" ]; then
          hx .
        elif [ "$open" = "$code" ]; then
          code .
        else
          echo "Error: Unknown value for 'open': $open\nAccepted values are - h: Helix, c: VSCode"
        fi
      elif [ ! -t 1 ]; then
        echo "$dirs[1]"
      fi
    else
      echo "Error: Project with name starting with '$search_term' not found in '$dev'"
    fi
  else
    echo "Error: Search term not provided"
  fi
}

_dev_completion() {
  local -a dev_commands
  dev_commands=(
    "h:Open in Helix"
    "c:Open with VS Code"
  )

  _arguments \
    "1: :->search_term" \
    "2: :->open" \
    && return

  case "$state" in
    (search_term)
      _values "search_terms" $(find "$HOME/Developer" -maxdepth 2 -mindepth 2 -type d -exec basename {} \;) && return
      ;;
    (open)
      _describe "dev command" dev_commands && return
      ;;
  esac
}

compdef _dev_completion dev

alias refresh="source $ZDOTDIR/.zshrc"
alias cls="clear"
alias ls="eza --icons"

alias tree="eza --icons -la -T --level 3 --git-ignore"

# git
alias gs="git status"
alias gadd="git add"
alias gcomm="git commit -m"
alias gpush="git push"

#brew
alias install="brew install"
alias search="brew search"
alias uninstall="brew uninstall"
alias clean="brew autoremove && brew cleanup"
alias list="brew list"
alias update="brew update && brew upgrade"


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

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Zinit plugins
zinit ice wait lucid
zinit load Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting

# Zstyle
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza $realpath -1 --color=always --icons=always --group-directories-first'
zstyle ':fzf-tab:*' switch-group '<' '>'
# apply to all command
zstyle ':fzf-tab:*' popup-min-size 50 8
zstyle ':fzf-tab:complete:diff:*' popup-min-size 80 12

eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
