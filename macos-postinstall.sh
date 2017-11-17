#!/usr/bin/env bash

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make my preferred directories if they do not exist yet
mkdir -p ~/Documents/Administration
mkdir -p ~/Documents/Projects
mkdir -p ~/Documents/temp
mkdir -p ~/Documents/Websites
mkdir -p ~/Documents/Writing

# Install XCode command line tools
xcode-select --install
