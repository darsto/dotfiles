#/bin/bash

set -ex

: ${BUILD_CCLS:=true}
: ${BUILD_FZF:=true}
: ${BUILD_NVIM:=true}

# workspace
PROJ="$HOME/proj"
mkdir -p "$PROJ"
cd "$PROJ"
sudo apt-get install -y git tmux python-pip

# setup
git clone https://github.com/darsto/dotfiles.git "$PROJ/dotfiles"

# ccls
if $BUILD_CCLS; then
	git clone --depth=1 --recursive https://github.com/MaskRay/ccls "$PROJ/ccls"
	cd "$PROJ/ccls"
	wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
	tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
	cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04
	cmake --build Release
	sudo cmake --build Release --target install
fi

f $BUILD_FZF; then
	git clone --depth=1 --recursive https://github.com/junegunn/fzf.git "$PROJ/fzf"
	sudo "$PROJ/fzf/install" --all --64
fi

# neovim
if $BUILD_NVIM; then
    sudo apt-get install -y git cmake libtool-bin
    # XXX: just get the master for now
    git clone --depth=1 --recursive https://github.com/neovim/neovim.git "$PROJ/neovim"
    cd "$PROJ/neovim"
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install

    # neovim configs
    mkdir -p "$HOME/.config/nvim"
    cp "$PROJ/dotfiles/init.vim" "$HOME/.config/nvim/"
    cp "$PROJ/dotfiles/coc-settings.json" "$HOME/.config/nvim/"
    mkdir -p "$HOME/.config/nvim/colors"
    cp "$PROJ/dotfiles/genericdc.vim" "$HOME/.config/nvim/colors/"
    mkdir -p "$HOME/.config/nvim/bundle"

    # vundle
    git clone --depth=1 --recursive https://github.com/VundleVim/Vundle.vim.git "$HOME/.config/nvim/bundle/Vundle.vim"
    vim +PluginInstall +qall
fi

# nvr --remote command
sudo pip3 install neovim-remote

# tmux
cp "$PROJ/dotfiles/tmux.conf" "$HOME/.tmux.conf"

# compile_commands.json generator
sudo apt-get install -y bear
