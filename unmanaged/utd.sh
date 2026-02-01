# many of these will be brittle since there is some light web scraping here, lemme know if anything isn't working

function utd-wezterm () {
  # Update to the newest version of wezterm for ubuntu using the .debs
  RELEASE_VERSION=$(lsb_release -r | cut   -f2)
  if ! [[ "$(lsb_release -i | cut -f2)" = "Ubuntu" ]]
  then
    echo Only ubuntu supported
    exit 1
  fi

  LINK="$(curl -s https://github.com/wez/wezterm/releases/ | \
    grep -m1 -oi '/wez/.*wezterm.*ubuntu'$RELEASE_VERSION'.deb' | \
    xargs -I % echo https://github.com%)"
  FILE=$(basename $LINK)
  curl -sL "$LINK" -o wezterm.deb
  sudo dpkg -i wezterm.deb
  rm wezterm.deb
}


function utd-github () {
  LINK="$(curl -s https://github.com/cli/cli/releases/ | \
    grep -m1 -oi '/cli/.*/gh_.*_linux_amd64.deb' | \
    xargs -I % echo https://github.com%)"
  curl -sL "$LINK" -o github.deb
  sudo dpkg -i github.deb
  rm github.deb
}


function utd-skaffold () {
  curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
  sudo install skaffold /usr/local/bin/
  rm skaffold
}

function utd-helm () {
  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
  sudo bash ./get_helm.sh
  rm get_helm.sh
}

function utd-kubectl () {
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm kubectl
}

function utd-minikube () {
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install -o root -g root -m 0755 minikube-linux-amd64 /usr/local/bin/minikube
  rm minikube-linux-amd64
}
