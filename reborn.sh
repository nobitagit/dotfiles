echo "Starting"

echo "Getting Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Show dotfiles by default 
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder

# Use a more recent version of vim than the system one
brew install vim
exec -l $SHELL

# Get Python (you will need to put it yourself in your PATH)
# If you're not sure check https://stackoverflow.com/a/49631080/1446845
brew install python
# Pipenv https://docs.python-guide.org/dev/virtualenvs/#installing-pipenv
# Like pip, bit more high level, so simpler to use and most of the times just enough
brew install pipenv

# get Vundle
echo "Getting Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing Powerline prepatched fonts..."
# https://stackoverflow.com/a/19137142/1446845
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
echo "Clean up font installation artifacts"
cd ..
rm -rf fonts

echo "For More iTerm Powerline config see https://coderwall.com/p/yiot4q/setup-vim-powerline-and-iterm2-on-mac-os-x"

echo "Installing some browsers: Google Chrome, Google Chrome Canary and Firefox"
brew install --cask google-chrome
brew tap homebrew/cask-versions && brew install --cask google-chrome-canary
brew install --cask firefox

echo "Installing Visual Studio Code"
brew install --cask visual-studio-code
echo "/n"
echo "Enabling key repeat for VSCode Vim mode"
# enable key repeating for VS Codes VIM mode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider

brew install --cask iterm2

echo "Sync Dotfiles"
curl https://raw.githubusercontent.com/nobitagit/dotfiles/master/.gitconfig > ~/.gitconfig
curl https://raw.githubusercontent.com/nobitagit/dotfiles/master/.vimrc > ~/.vimrc

# Commenting out next line. This might not be needed anymore since everything should be in the zsh config
# curl https://raw.githubusercontent.com/nobitagit/dotfiles/master/.bash_profile > ~/.bash_profile
curl https://raw.githubusercontent.com/nobitagit/dotfiles/master/.git-completion.bash > ~/.git-completion.bash

# Run vundle to install vim plugins
vim +PluginInstall +qall

echo "/n"
echo "Setting up git config for Dotfiles"
echo "see: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/"
git init --bare $HOME/.cfg
# This is commented out as it's already part of the downloaded bash_profile, but you should uncomment in case 
# you skip that part
# echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bash_profile
source ~/.bash_profile
config config --local status.showUntrackedFiles no

brew install nvm
mkdir ~/.nvm
brew install yarn

# This will not symlink the docker command, for that you'll need to run the app via spotlight or finder once
brew install --cask docker
echo "Docker binaries have been installed, check https://stackoverflow.com/a/43365425/1446845 to complete installation"

# Other utilities
brew install --cask postman
brew install --cask spectacle
brew install --cask skype
# Quickly remind me the wifi password, https://github.com/rauchg/wifi-password
brew install wifi-password
# Capture screen in various formats, https://getkap.co/
brew install --cask kap

# Remove outdated versions from the cellar.
brew cleanup

## PERSONAL PREFS
# This is where I store all my code
mkdir -p ~/Coding/Work
mkdir ~/Coding/Personal

# get oh my zsh
echo "installing oh my zsh..."
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh
