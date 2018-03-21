# my-Vim

Vim usage and plug-ins.

[Vim tutorial](https://github.com/ysfscream/ysfscream.github.io/issues/11)

## Usage

```shell

git clone git@github.com:ysfscream/my-Vim.git

mkdir ./vim

cd my-Vim

cp vimrc ~/.vim

cd ~/.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim vimrc

:PlugInstall

brew install fzf

brew install the_silver_searcher

cd YouCompleteMe

./install.py --clang-completer --system-libclang --js-completer

vim

```
