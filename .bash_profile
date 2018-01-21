PINK=$'\e[35;40m'
GREEN=$'\e[32;40m'
YELLOW=$'\e[33;40m'
RED=$'\e[0;31m'

export PS1="\e[0;32m[\t]\e[0m${YELLOW}\$(parse_git_branch) \e[0m\$(parse_git_color) \e[1;35m\w\e[0m \n-> "

export CLICOLOR=1
export LSCOLORS=dxFxCxDxBxegedabagacad

# Show current branch name
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}

parse_git_color() {
	if [ "$(parse_git_branch)" != ""  ] ; then
	  if [ "$(parse_git_dirty)" == "*" ] ; then
	    echo "${RED}●" # dirty state
	  else
	    echo "${GREEN}●"
	  fi
	else
		echo "${YELLOW}=>"
	fi
}

# Autocompletion for git commands and branches.
# See: http://code-worrier.com/blog/autocomplete-git/
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Aliases
alias code='cd ~/Code'
alias codl='cd ~/Code ; ls -la'
alias work='cd ~/Code/work'
alias cpath='pwd|pbcopy'
alias mvim='open -a "macvim"'
# open in Sublime (followed by the directory or file path, or just the .)
alias subl='open -a "Sublime Text"'
alias ll='ls -la'
alias ws='open -a "webstorm"' 
# copy current branch name to clipboard
alias cpbr='git name-rev --name-only HEAD | pbcopy'
alias vsc='open -a Visual\ Studio\ Code'

export PATH="$PATH:$HOME/.yarn/bin"

export NVM_DIR="/Users/Aurelio/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# make it possible to track dotfiles under git without getting insane
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Aurelio/Code/google-cloud-sdk/path.bash.inc' ]; then source '/Users/Aurelio/Code/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Aurelio/Code/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/Aurelio/Code/google-cloud-sdk/completion.bash.inc'; fi
