#!/bin/bash

set -e

BREW_PYTHON=0

ANSIBLE_CONFIGURATION_DIRECTORY="$HOME/.ansible.d"

# Download and install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
    echo "Info   | Install   | xcode"
    xcode-select --install
fi

# Download and install Homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
    echo "Info   | Install   | homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# OPTIONAL: install my homebrew-versions fork
# brew tap simonmcc/homebrew-versions

set +e
CASK_INSTALLED_OUTPUT=`brew cask list`
CASK_EC=$?
set -e
if [[ ${CASK_EC} -ne 0 ]]; then
    echo "Info   | Install   | homebrew"
    brew install caskroom/cask/brew-cask
fi

# Modify the PATH
export PATH=/usr/local/bin:$PATH

# Download and install git
if [[ ! -x /usr/local/bin/git ]]; then
    echo "Info   | Install   | git"
    brew install git
fi

# Download and install python
if [ ${BREW_PYTHON} -eq 1 -a ! -x /usr/local/bin/python ]; then
    echo "Info   | Install   | python"
    brew install python
fi

# Download and install Ansible
set +e
ANSIBLE_PYTHON=$(which ansible)
set -e
if [ -z "${ANSIBLE_PYTHON}" ]; then
    # brew install ansible
    set +e
    PIP_BIN=$(which pip)
    set -e
    if [ -z "${PIP_BIN}"]; then
	sudo easy_install pip
    fi
    sudo pip install ansible
fi

# Provision the box
ansible-playbook --ask-sudo-pass -i localhost.ini site.yml --connection=local
