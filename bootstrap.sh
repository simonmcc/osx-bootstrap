#!/bin/bash

set -e

SRC_DIRECTORY="$HOME/src"
ANSIBLE_DIRECTORY="$SRC_DIRECTORY/ansible"
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
brew tap simonmcc/homebrew-versions

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
if [[ ! -x /usr/local/bin/python ]]; then
    echo "Info   | Install   | python"
    brew install python
fi

# Download and install Ansible
if [[ ! -x /usr/local/bin/ansible ]]; then
    brew install ansible
fi

# Provision the box
ansible-playbook --ask-sudo-pass -i localhost.ini site.yml --connection=local
