#!/bin/bash

## ZSH configuration
# change default shell
chsh -s $(which zsh)
# Create hard link to the zshrc file so it creates an actual independent copy on new users
# ln /usr/share/oh-my-zsh/zshrc /etc/skel/.zshrc

sudo usermod -aG nordvpn $USER

# Set default shell to zsh
# adduser -D -s /bin/zsh

git config --global core.hooksPath hooks
