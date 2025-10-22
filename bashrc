# -------------------------------------------------------------- Prompt
if [ -n "$ZSH_VERSION" ]; then
  RESET='%f'
  GREEN='%F{078}'
  BLUE='%F{032}'
  LIGHT_BLUE='%F{075}'
  MAGENTA='%F{105}'
  ORANGE='%F{214}'
elif [ -n "$BASH_VERSION" ]; then
  RESET='\[\033[0m\]'
  GREEN='\[\033[38;5;78m\]'
  BLUE='\[\033[38;5;32m\]'
  LIGHT_BLUE='\[\033[38;5;75m\]'
  MAGENTA='\[\033[38;5;105m\]'
  ORANGE='\[\033[38;5;214m\]'
fi

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

if [ -n "$BASH_VERSION" ]; then
  update_ps1() {
    local branch=$(git_branch)
    PS1="${LIGHT_BLUE}[\u@\h]${RESET} ${BLUE}\w${RESET} ${branch}${MAGENTA}≫${RESET} "
  }
  PROMPT_COMMAND=update_ps1
elif [ -n "$ZSH_VERSION" ]; then
  setopt prompt_subst
  PROMPT='${LIGHT_BLUE}[%n@%m]${RESET} ${BLUE}%~${RESET} $(git_branch)${MAGENTA}≫${RESET} '
fi


# -------------------------------------------------------------- fzf integration if installed
# TBD
#
# -------------------------------------------------------------- Other
export HISTSIZE=10000
export HISTFILESIZE=20000

# -------------------------------------------------------------- Aliases
alias ls='ls --color'
alias ll='ls -alF'
alias repos='cd ~/Documents/repos'
alias k='kubectl'

