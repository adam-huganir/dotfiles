# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYTHON_CONFIGURE_OPTS="--enable-shared"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
