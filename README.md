# TMUX, the terminal multiplexer

## Table of Contents
* [What is TMUX?](#what-is-tmux)
* [Why TMUX?](#why-tmux)
* [About this setup](#about-this-setup)
* [Installing and Setting Up Configuration Folder](#installing-and-setting-up-configuration-folder)

## What is TMUX?
Tmux (Terminal Multiplexer) is a tool that lets you manage multiple terminal sessions, windows, and panes within a single terminal window, allowing you to run several programs simultaneously and keep them running even if you disconnect.

## Why TMUX?
It's widely used to extend some terminal functionalities. \
In my case, I use it a lot when developing on WSL, so I can mimic tile window managers' capabilities.

## About this setup
This setup covers some `bindings`, `visuals` and `general` tmux configurations. \
This repository also contains custom scripts that peforms some tmux actions such as `initializing a session` or `loading a session`. These scripts can be bind to an alias in the `.bashrc` file.

## Installing and setting up configuration folder
To install **TMUX**, use your preferred package manager. For Arch-based Linux distributions, run: `sudo pacman -S tmux` and follow the installation steps. \
To customize **TMUX**, create a configuration folder in the standard Linux `.config` directory with: `mkdir ~/.config/tmux` and create the .conf file by running `touch ~/.config/tmux/tmux.conf`.
