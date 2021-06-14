#!/bin/bash

echo "Starting installation..."
#while getopts ":d:" opt; do
#  case $opt in
#    :)
#      echo "Installing the dotfiles..." >&2
#      git clone https://github.com/santiagonasar/dotfiles-1.git ~/.dotfiles
#      cd ~/.dotfiles sudo ./bootstrap.sh
#      ;;
#    \?)
#      echo "Invalid option: -$OPTARG" >&2
#      exit 1
#      ;;
#    d)
#      echo "Not installind the dotfiles..." >&2
#      ;;
#  esac
#done

echo "Installing the dotfiles..." >&2
if [ ! -d ~/.dotfiles ]; then
  git clone https://github.com/santiagonasar/dotfiles-1.git ~/.dotfiles
fi 

(cd  ~/.dotfiles; pwd; ./bootstrap.sh)

# Install with apt-get
echo "Installing from apt-get..."
sudo ./aptget.sh
echo "Done installing from apt-get!"
# Install software that can't be installed with apt-get
echo "Installing other software..."
./programs.sh
echo "Done instaling software."
# System configurations 
echo "Configure the system"
./system.sh
echo "Done configurig gnome desktop"

# Upgrade the system
echo "Updating the system..."
sudo apt-get upgrade -y
echo "Done updating the system"

echo "Installation done!"
