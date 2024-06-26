# Installs for setup


## Terminal

[Kitty](https://sw.kovidgoyal.net/kitty/binary/)
Install with: `sudo apt install kitty`

### Terminal Tools

[Exa](https://the.exa.website/)
Install with: `sudo apt install exa`

[Zoxide](https://github.com/ajeetdsouza/zoxide)
Install with: `curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash`

[Starship](https://starship.rs/)
Install with: `curl -sS https://starship.rs/install.sh | zsh`

[Tmux](https://github.com/tmux/tmux)
Install with `sudo apt install tmux`

[FZF](https://github.com/junegunn/fzf)
Install with: 
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### Terminal Appearance

[Cousine Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Cousine.zip)
Install with: `wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Cousine.zip && unzip Cousine.zip -d ~/.fonts && fc-cache -fv && rm Cousine.zip`

## Neovim

Note: telescope-fzf-native.nvim requires `make` to be installed with `sudo apt install make`

[Vim Plug](https://github.com/junegunn/vim-plug)
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Then `:source` the `plug_snapshot.vim` file

## COC

