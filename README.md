The Plugin Installer is a plugin for the Melody publishing system, with limited support for Movable Type, that automates the installation and upgrade of plugins in a Melody installation.

## Prerequisites

* Melody 0.9.5 or greater
* git must be installed on your server

**Movable Type Users**

Movable Type users can use this plugin, however they will not get the full range of its abilities. For example, Movable Type users will be able to install plugins, but they will not be able to check for updates or upgrade plugins using this framework. To take advantage of the easiest plugin installation experience possible, please upgrade to [Melody](http://openmelody.org). Its free and 100% open source.

## Setup and Configuration

This plugin installs plugins from git into a dedicated directory, distinct and separate from your regular plugins directory. This requires you to edit your `mt-config.cgi` file to add this plugin directory Melody and Movable Type's plugin search path. To do this, find and edit your `mt-config.cgi` file, found in the same directory at `mt.cgi`, and add the following lines to it:

    PluginPath plugins
    PluginPath mt-static/support/installed-plugins

*Note: it is important to add **both** lines to your `mt-config.cgi` file because setting only one of them will tell Melody to only search that one directory for plugins.*

### Customizing the Plugin Installation Directory

You may customize where you wish plugins to be installed by specifying the `PluginInstallPath` in your `mt-config.cgi`. This directory *must be writable* by your web server. This allows you locate your plugin installation directory outside of the Melody directory and file structure. 

If you customize your installation directory, you *must* also add the absolute path to this directory to your installation's plugin search path. You can do that by adding the following lines to your `mt-config.cgi` file:

    PluginPath plugins
    PluginPath /var/melody/installed-plugins

**Why customize the plugin installation directory?**

Keeping plugins you have elected to install yourself in a separate directory can make upgrading Melody much eeasier because one does not need to be concerned with an upgrade of the core software from overwriting their plugins.

## Installing git

This plugin requires that you have git installed. To install git, please read the wonderful instructions found in the [Git Community Book](http://book.git-scm.com/2_installing_git.html). Git is supported on the following platforms:

* Linux
* Mac OSX
* Windows

# Usage

Installing a plugin is simple. Follow these steps:

1. Go to the System's Plugin Listing Screen.
2. In the right hand column, click on the link that says, "Install plugin from git."
3. In the dialog that appears, enter in the Read-Only git URL for the plugin you want to install (see screenshot below)
4. Click the "Install" button.

**Where to find your Read-Only Git URL on github**

![Where to find a Git URL on github](http://skitch.com/byrnereese/dnj6n/byrnereese-s-mt-plugin-configassistant-at-master-github)

# Developer Guide

## Roadmap and the Plugin Directory

This plugin is part of a larger effort to completely overhaul how plugins are discovered, installed and managed in Movable Type and Melody. The roadmap for this plugin is for it to interface directly with a centralized plugin directory managed by the community. In this capacity, the need to enter a git url at all will be completely obviated. Instead, users will search for the plugin they want from within Melody, and then click "install." The directory will know the git URL so users don't have to.

## Plugin Packaging and Compatibility

Movable Type's plugin packaging standard is not compatible with the needs of this plugin. Therefore this plugin requires plugin developers to begin packaging their plugins using new technology and a new packaging standard. 

### 1. Place static files inside the plugin envelope

The plugin envelope refers to the directory (and its sub-directories) that contains your plugin's `config.yaml` file. In the past static files were placed within the `mt-static` directory, but recent advancements in Melody now allow for a plugin's static files to be placed *inside* the plugin envelope, in a directory appropriately called `static`. For example, a plugin called "MyPlugin" might have a directory and file structure that looks like this:

* plugins/MyPlugin/config.yaml
* plugins/MyPlugin/tmpl/some_screen.tmpl
* plugins/MyPlugin/static/app.css
* plugins/MyPlugin/lib/MyPlugin/Plugin.pm

When a user installs your plugin, Melody will automatically install your plugin's static files into a web accessible directory so that you don't have to. 

This ability is made possible by a plugin called "Config Assistant," an essential Movable Type plugin which comes pre-installed in all versions of Melody.

### 2. File Organization

Your plugin's files will need to organized in a special way, best illustrated by the following example. Let's say you have a plugin called "My Plugin" which contains the following resources:

* a readme file - because all plugins should be documented
* a config.yaml - which all plugins must have
* a template file - for rendering some screen
* a static stylesheet - for styling the screen your plugin displays
* a library file - for performing some business logic

These files would be placed into git using the following structure (respectively):

* MyPlugin/README.md
* MyPlugin/config.yaml
* MyPlugin/tmpl/some_screen.tmpl
* MyPlugin/tmpl/static/app.css
* MyPlugin/lib/MyPlugin/Plugin.pm

*The Melody Core team recognizes that this is a big shift for plugin developers and also hopes that developers see the advantage in making this change. They are committed to helping any developer who comes to them. If you need help or have questions, please contact [our mailing list](http://groups.google.com/group/openmelody).

# TODO

* Display a message when a plugin is installed successfully.
* Check to see if git is installed
* Add support for "Check for Updates"
* Add support for "Upgrade Plugin"