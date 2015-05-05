#!/bin/bash

set -e

if ! command -v ansible >/dev/null; then
    sudo apt-get update

    sudo apt-get --yes --force-yes install software-properties-common
    sudo add-apt-repository ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get --yes --force-yes install ansible
fi
