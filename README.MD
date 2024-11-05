# APT plugin for zsh

A small plugin for distros with apt package manager. It will ask you to install command, if it not installed on system. If command not foud, program will try to find it in other packages. And new alias upall to update all packages (flatpak and snap to)

## oh-my-zsh

Install it with your favourite zsh package manager, or clone it directly to your `$ZSH/plugins` directory with git. Or just run:

```shell notranslate position-relative overflow-auto
git clone git@github.com:GeoLMg/apt-zsh-plugin.git $ZSH/plugins/apt
```

Add `apt` to the plugins array in your `.zshrc` file:

```shell notranslate position-relative overflow-auto
plugins=(... apt)
```



