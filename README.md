#################################################
My .*rc files and other common configurations
#################################################

Want to change how I work and confuse me? Submit a PR!

# Install
clone, make sure vars in .zshrc are right

link various files (obviously make sure you don't have files that you don't want to overwrite first)

```zsh
DOTFILES="$HOME/dotfiles"
ln -s "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/starship.toml" "$HOME/.config/starship.toml"
```

similarly for pwsh
```zsh
$DOTFILES = "$HOME/dotfiles"
New-Item -Type SymbolicLink -Target "$DOTFILES/starship.toml" -Path "$HOME/.config/starship.toml"
New-Item -Type SymbolicLink -Target "$DOTFILES/profile.ps1" -Path "$HOME/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
```

# Install dependencies
## OMZ
```shell
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone https://github.com/johanhaleby/kubetail.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/kubetail
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions \
  ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
```
