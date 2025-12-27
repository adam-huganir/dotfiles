#################################################
My .*rc files and other common configurations
#################################################

Want to change how I work and confuse me? Submit a PR!

# Install

1. Get `chezmoi` if you don't have it already:
2. `chezmoi edit-config` and make sure it looks like  (windows example with home at C:\Users\adam):
   ```toml
   sourceDir = "/Users/adam/dotfiles"
3. ```

```zsh
chezmoi init --apply
```

similarly for pwsh
```zsh

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
