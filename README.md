dotfiles
==========

It contains the installation and configuration for most of apps I use.

> Important: It is not fully automated yet.

## Appearance

### Darwin

![**iTerm2 + Tmux**](https://raw.githubusercontent.com/maxcnunes/dotfiles/master/images/darwin_iterm2+tmux.png)

![**VIM**](https://raw.githubusercontent.com/maxcnunes/dotfiles/master/images/darwin_vim.png)

### Linux

* Ubuntu 16.04
* Gnome 3.20
* **Appearance config in the desktop image**

![**iTerm2 + Tmux**](https://raw.githubusercontent.com/maxcnunes/dotfiles/master/images/linux_gnome-terminal+tmux.png)

![**VIM**](https://raw.githubusercontent.com/maxcnunes/dotfiles/master/images/linux_vim.png)

![**Linux Desktop**](https://raw.githubusercontent.com/maxcnunes/dotfiles/master/images/linux_desktop.png)

![**Linux Workspaces**](https://raw.githubusercontent.com/maxcnunes/dotfiles/master/images/linux_workspaces.png)

## Install
Clone this project:

```bash
git clone git@github.com:maxcnunes/dotfiles.git ~/.dotfiles
or
git clone https://github.com/maxcnunes/dotfiles.git ~/.dotfiles
```

Install Dropbox and sync the data.

Bootstrap and install apps:

```bash
cd ~/.dotfiles
./script/bootstrap.sh
./script/install.sh
```

## Manual Configurations

### MacOS

#### Applications

Install these applications manually so they can manage their own updates without
being replaced by `brew upgrade`:

* [1Password](https://1password.com/downloads/mac/)
* [Alfred](https://www.alfredapp.com/)
* [Caffeine](https://www.caffeine-app.net/)
* [Charles](https://www.charlesproxy.com/download/)
* [Firefox](https://www.mozilla.org/firefox/new/)
* [GitUp](https://gitup.co/)
* [Google Chrome](https://www.google.com/chrome/)
* [iTerm2](https://iterm2.com/downloads.html)
* [Magnet](https://apps.apple.com/app/magnet/id441258766)
* [Notion](https://www.notion.com/desktop)
* [Postman](https://www.postman.com/downloads/)
* [Slack](https://slack.com/downloads/mac)
* [TablePlus](https://tableplus.com/download)
* [WezTerm](https://wezterm.org/installation.html)
* [Zoom](https://zoom.us/download)

* [Trackpad - three finger drag](https://support.apple.com/en-us/HT204609)
* [Font](https://gist.github.com/baopham/1838072)

#### iTerm manual settings after VIM has been installed:
* **Theme**:
  1. Open iTerm then go to `Preferences>Profiles>Default>Colors`
  1. Import the One Dark theme from `~/.vim/bundles/onedark.vim/term/One Dark.itermcolors`
  1. Select the One Dark theme after imported
  1. Fix the theme color in **ANSI Colors** section by setting Black Normal to `282c34`.
* **Font**:
  1. Download and install [Monaco for Powerline font](https://github.com/supermarin/powerline-fonts/blob/master/Monaco/Monaco%20for%20Powerline.otf)
  1. Open iTerm then go to `Preferences>Profiles>Default>Text`
  1. Select **Monaco for Powerline font**

### Linux

### Gnome extensions from Chrome

* [Workspaces to Dock](https://extensions.gnome.org/extension/427/workspaces-to-dock/)
* [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
* [Transparent Top Bar](https://extensions.gnome.org/extension/857/transparent-top-bar/)
* [Dynamic Top Bar](https://extensions.gnome.org/extension/885/dynamic-top-bar/)

#### Terminal Font

Although the font is automatically download to `~/.fonts`. I could not set automatically the gnome terminal font. So we need to do it manually changing the font to: `SauceCodePro Nerd Font Semibold 10`.

## References

Based on few existig vim configuration projects:

- [astrails/dotvim](https://github.com/astrails/dotvim)
- [lucascaton/vimfiles](https://github.com/lucascaton/vimfiles)
- [vinitkumar/.vim](https://github.com/vinitkumar/.vim)
- [tony/vim-config](https://github.com/tony/vim-config)
