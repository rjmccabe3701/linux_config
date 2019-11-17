# Customizing ``linux_config``

The following settings are extendible:

1.  Adding your favorite vim plugins to the vimrc 'vim-plug' setup.
2.  Adding your favorite vim macros and customizations to vimrc.
3.  Customizing the ``.gitconfig`` with your own settings.
4.  Customizing tmux with your own settings.
5.  Customizing the ``.zshrc`` shell settings with your own settings.

Simply point the [install](install.sh) script to our customization directory.  This will

* Install any files in ``<customDir>/dot_files`` to ``$HOME`` (with a dot prefix).
* Install any scripts in ``<customeDir>/scriptts`` to ``$HOME/scripts``.
* Calls the ``custom_install.sh`` script.

## Vim Plugins

To add your own plugins, add these to the file ``~/.myvimrc_plugins``.
Refer to this [example](example_custom/dot_files/myvimrc_plugins) to see an example of this.

## Vimrc Customizations

To add your own vimrc customizations, add this to the file
``~/.myvimrc``.  Refer to this [example](example_custom/dot_files/myvimrc).


## Gitconfig Customizations

To add your own gitconfig settings (such as username, email address, etc..),
add these to the file ``~/.mygitconfig``.  Refer to this [example](example_custom/dot_files/mygitconfig)



## Tmux Customizations

To add your own tmux settings, add these to the file ``~/.tmux.conf``.  Refer
to this [example](example_custom/dot_files/mytmux.conf).


## Zshrc Customizations

To add your own zshrc settings (such as aliases), add these to the
file ``~/.myzshrc``.  Refer to this [example](example_custom/dot_files/myzshrc).
