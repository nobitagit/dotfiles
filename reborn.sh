echo "Starting"

echo "Getting Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Show dotfiles by default 
defaults write com.apple.finder AppleShowAllFiles -bool true
killall Finder

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
brew cask install google-chrome
brew tap homebrew/cask-versions && brew cask install google-chrome-canary
brew cask install firefox

echo "Installing Visual Studio Code"
brew cask install visual-studio-code
cho "/n"
echo "Enabling key repeat for VSCode Vim mode"
# enable key repeating for VS Codes VIM mode
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider

brew cask install iterm2

echo "Sync Dotfiles"
curl https://raw.githubusercontent.com/nobitagit/dotfiles/master/.gitconfig > ~/.gitconfig
curl https://raw.githubusercontent.com/nobitagit/dotfiles/master/.vimrc > ~/.vimrc
curl https://raw.githubusercontent.com/nobitagit/dotfiles/master/.bash_profile > ~/.bash_profile
curl https://raw.githubusercontent.com/nobitagit/dotfiles/master/.git-completion.bash > ~/.git-completion.bash

echo "/n"
echo "Setting up git config for Dotfiles"
echo "see: https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/"
git init --bare $HOME/.cfg
# This is commented out as it's already part of the downloaded bash_profile, but you should uncomment in case 
# you skip that part
# echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bash_profile
source ~/.bash_profile
config config --local status.showUntrackedFiles no

# This is where I store all my code
mkdir -p ~/Coding/Work
mkdir -p ~/Coding/Personal

brew install nvm
mkdir ~/.nvm
brew install yarn

brew cask install spectacle
