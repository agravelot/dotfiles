# My dotfiles

This directory contains the dotfiles for my system

## Requirements

Ensure you have the following installed on your system

### Pre-requisites 

```
git stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/agravelot/dotfiles.git
$ cd dotfiles
```

then use GNU stow to create symlinks

```
$ stow -t ~ .
```



Useful commands:
```bash
stow --adopt -v -t ~ tmux # adopt the symlinks
```
