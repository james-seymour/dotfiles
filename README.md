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

### Terminal Appearance

[Cousine Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Cousine.zip)
Install with: `wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Cousine.zip && unzip Cousine.zip -d ~/.fonts && fc-cache -fv && rm Cousine.zip`

[ZSH Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
Install with:
```
echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-syntax-highlighting/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/shells:zsh-users:zsh-syntax-highlighting.list
curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:zsh-syntax-highlighting/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_zsh-users_zsh-syntax-highlighting.gpg > /dev/null
sudo apt update
sudo apt install zsh-syntax-highlighting
```

[ZSH Autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
Install with:
```
echo 'deb http://download.opensuse.org/repositories/shells:/zsh-users:/zsh-autosuggestions/xUbuntu_22.04/ /' | sudo tee /etc/apt/sources.list.d/shells:zsh-users:zsh-autosuggestions.list
curl -fsSL https://download.opensuse.org/repositories/shells:zsh-users:zsh-autosuggestions/xUbuntu_22.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_zsh-users_zsh-autosuggestions.gpg > /dev/null
sudo apt update
sudo apt install zsh-autosuggestions
```

Look in to potentially installing [zsh history substring search](https://github.com/zsh-users/zsh-history-substring-search)

## Neovim

Note: telescope-fzf-native.nvim requires `make` and `fzf` to be installed with `sudo apt install make fzf`

[Vim Plug](https://github.com/junegunn/vim-plug)
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Then `:source` the `plug_snapshot.vim` file

## COC

