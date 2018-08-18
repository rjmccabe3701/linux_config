# LINUX CONFIGURATION FOR IMPROVED SHELL EXPERIENCE

This repository is a set of scripts/utilities to improve
you productivity at a *nix*-like terminal.

In particular it provides several ease-of-use wrappers around
(and plugins for) the following tools:

* **TMUX**
* **VIM**
* **ZSH**: I am using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

# Supported platforms

* Linux (all relatively recent distributions)
* Cygwin
* MacOS-X (use iTerm2)

Not yet supported:

* WSL (coming soon!)

# Installing

# Prerequisites

The required prerequisite packages are

```
   zsh
   vim
   tmux
   git
```

Optionally you can install

* [autojump](https://github.com/wting/autojump) for a fuzzy-finder to MRU directory usage.
* [neovim](https://neovim.io/) as it has better plugin support (in particular copy/paste clipboard interaction) than native vim.

If you would like copy/paste integration with the system clipboard you will need

**Linux**

```
   xsel
```

**Cygwin**

```
   xinit
   xclip
   xclipboard
   cygutils-extra
```

**MacOS-X**

```
   pbcopy/pbpaste
```


# Install

Simply clone the repository and install

```bash
git clone https://github.com/rjmccabe3701/linux_config.git
linux_config/install.sh
```

# Uninstall

Run the uninstall script:

```bash
linux_config/uninstall.sh
```

# Customizing

User-specific customization is allowed.  Please refer to
[CUSTOM_CONFIG](CUSTOM_CONFIG.md) for details (and examples) of how to set that up.


