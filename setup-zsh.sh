#!;/bin/sh

SOURCE_DIR=`pwd`

mkdir -p ~/.oh-my-zsh-install
pushd ~/.oh-my-zsh-install

brew update
brew install fontconfig

$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9khttps://github.com/gabrielelana/awesome-terminal-fonts.git
git clone https://github.com/gabrielelana/awesome-terminal-fonts.git awesome-fonts
sh ./awesome-fonts/install.sh

cp ./.zshrc ~/.zshrc

