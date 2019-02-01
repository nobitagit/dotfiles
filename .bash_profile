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

# https://superuser.com/a/599156/325858
# name the current tab in iTerm 
# $ title tabName
function title {
    echo -ne "\033]0;"$*"\007"
}

# https://superuser.com/a/1023410/325858
# Set iTerm tab color via command line
function color {
    case $1 in
    green)
    echo -e "Done.\033]6;1;bg;red;brightness;57\a\033]6;1;bg;green;brightness;197\a\033]6;1;bg;blue;brightness;77\a"
    ;;
    red)
    echo -e "Done.\033]6;1;bg;red;brightness;270\a \033]6;1;bg;green;brightness;60\a \033]6;1;bg;blue;brightness;83\a"
    ;;
    orange)
    echo -e "Done.\033]6;1;bg;red;brightness;227\a\033]6;1;bg;green;brightness;143\a\033]6;1;bg;blue;brightness;10\a"
    ;;
    esac
}

# Autocompletion for git commands and branches.
# See: http://code-worrier.com/blog/autocomplete-git/
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Aliases
alias hack='cd ~/Coding'
alias work='cd ~/Coding/work'
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

# export NVM_DIR="/Users/Aurelio/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# make it possible to track dotfiles under git without getting insane
# https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Aurelio/Code/google-cloud-sdk/path.bash.inc' ]; then source '/Users/Aurelio/Code/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Aurelio/Code/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/Aurelio/Code/google-cloud-sdk/completion.bash.inc'; fi
