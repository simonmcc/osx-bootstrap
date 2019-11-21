#!/bin/bash

set -e

BREW_PYTHON=0
ANSIBLE_CONFIGURATION_DIRECTORY="$HOME/.ansible.d"

function command_exists()
{
    type -P "$1" >/dev/null 2>&1
}

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
# TODO: Which do we prefer? OSX or homebrew's git?
GIT_OSX=/usr/bin/git
GIT_BREW=/usr/local/bin/git

#if [[ ! -x ${GIT_BREW} ]]; then
#    echo "Info   | Install   | git"
#    brew install git
#fi

# Download and install python
if [ ${BREW_PYTHON} -eq 1 -a ! -x /usr/local/bin/python ]; then
    echo "Info   | Install   | python"
    brew install python
fi
if ! command_exists wget ; then
  brew install wget
fi

#
# Download and install Ansible (including pip & virtualenv if required)
#

if ! command_exists pip ; then
    wget --quiet -O get-pip.py https://bootstrap.pypa.io/get-pip.py && python get-pip.py --user
    # Linux Path
    export PATH=~/.local/bin:$PATH
    # OSX/macOS
    export PATH=~/Library/Python/2.7/bin:$PATH
fi

if [ -d ~/Library/Python/2.7/bin ] ; then
    export PATH=~/Library/Python/2.7/bin:$PATH
fi

if ! command_exists virtualenv ; then
    #sudo -H ~/Library/Python/2.7/bin/pip install virtualenv
    pip install virtualenv
fi

if ! command_exists ansible ; then
    virtualenv .venv
    . .venv/bin/activate
    pip install ansible
fi

# install external ansible roles
ansible-galaxy install --roles-path roles/ -r requirements.yml

# Provision the box
ansible-playbook --ask-become-pass -i localhost.ini site.yml --connection=local
