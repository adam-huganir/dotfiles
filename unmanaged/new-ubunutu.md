## as `root`
```bash
sudo su -
```

```bash
sed -i 's/^Types: deb$/Types: deb deb-src/' /etc/apt/sources.list.d/ubuntu.sources
apt update && apt -y upgrade
apt install -y zsh
```

## as `user`
```bash
chsh -s /usr/bin/zsh
curl -sSLf "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  | sh -s -- --unattended
```