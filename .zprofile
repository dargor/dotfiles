export LANG="en_US.UTF-8"
export LC_COLLATE="C"

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export HOMEBREW_NO_ENV_HINTS=1
fi
export CLICOLOR=1

export PATH="${HOME}/Library/Application Support/Coursier/bin:${PATH}"
export PATH="${HOME}/.cargo/bin:${PATH}"
export PATH="${HOME}/go/bin:${PATH}"
export PATH="${HOME}/bin:${PATH}"

export EDITOR="vim"
export VISUAL="${EDITOR}"

export PAGER="most"
