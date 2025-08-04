# -------------------------------------------------------------- Prompt
RESET='\[\033[0m\]'
GREEN='\[\033[38;5;78m\]'
BLUE='\[\033[38;5;32m\]'
LIGHT_BLUE='\[\033[38;5;75m\]'
MAGENTA='\[\033[38;5;105m\]'
ORANGE='\[\033[38;5;214m\]'

function prompt_path() {
  local dir="$PWD"
  if [[ "$dir" == "$HOME" ]]; then
    echo "~"
  elif [[ "$dir" == "$HOME/"* ]]; then
    echo "~${dir#$HOME}"
  else
    echo "$dir"
  fi
}

function git_branch() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)

    # If we are not on a branch, get the short commit SHA
    if [[ -z "$branch" ]]; then
      branch=$(git rev-parse --short HEAD 2>/dev/null)
    fi

    # Determine if the repository is dirty
    local modified=""
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      modified="${ORANGE}*"
    fi

    # Construct the prompt
    echo "${LIGHT_BLUE}(${GREEN}$branch${modified}${LIGHT_BLUE})${RESET} "
  else
    echo ""
  fi
}

set_prompt() {
  local path="$(prompt_path)"
  local gitinfo="$(git_branch)"
  PS1="${LIGHT_BLUE}[\u]${RESET} ${BLUE}${path}${RESET} ${gitinfo}${MAGENTA}≫${RESET} "
}

PROMPT_COMMAND=set_prompt

# -------------------------------------------------------------- Aliases
alias ls='ls --color'
alias ll='ls -alF'
alias repos='cd ~/Documents/repos'
alias k='kubectl'

# -------------------------------------------------------------- Other
export HISTSIZE=10000
export HISTFILESIZE=20000
