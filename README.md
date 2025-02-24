- [Introduction](#introduction)
- [Install and Setup](#install-and-setup)
  - [First Steps (Install and Update Linux)](#first-steps-install-and-update-linux)
  - [Running this Script](#running-this-script)
- [Features and Unique Functionality](#features-and-unique-functionality)
  - [Applications](#applications)
  - [Command Line Tools](#command-line-tools)
  - [Keyboard Shorecuts](#keyboard-shorecuts)
- [Misc](#misc)
  - [Modifying Configurations](#modifying-configurations)
  - [Testing](#testing)

___

# Introduction

Script that sets up a Linux Ubuntu-based system, to be used for development.

Currently, only really works with Ubuntu 24.04 and Linux Mint 22.

The script is intended to be a single script that can be run directly after
installing a system.  Therefore, a very convenient, one-file, single-step to
install packages and applications, and configure the system.

No external dependencies, just one file **ubsetup.sh**.

___

# Install and Setup

## First Steps (Install and Update Linux)

Before running the script in this repo, first:
- Install [Ubuntu](https://ubuntu.com/download/desktop) or
  [LinuxMint](https://linuxmint.com/download.php).
  - Easiest method is to create a bootable USB stick with the ISO image.
  - [Ventoy](https://www.ventoy.net/en/download.html) is the most convenient
    tool to create a bootable USB.
- Update the system, e.g.
  - Using the following commands:
    - `sudo apt-get update`
    - `sudo apt-get upgrade -y`
  - Or, using the update manager from the applications' menu.

## Running this Script

- Usage instructions:
  - `./ubsetup.sh -h`

- Most likely usage:
  - `./ubsetup.sh -a -un "<Full_Name>" -ue "<Email_Address>" -ug "<group>"`
- Or, capture log to stdout and file:
  - `./ubsetup.sh -a --docker -un "<Full_Name>" -ue "<Email_Address>" -ug "<group>" 2>&1 | tee ubsetup.log`

___

# Features and Unique Functionality

As it is, the script gives lots of convenient applications and command line
tools.

## Applications

- VSCode and VSCodium, with sensible configs.
- Firefox, with plugins and privacy settings.
- Chrome.
- LibreOffice, with lots of fonts.
- Graphics applications: GIMP, Inkscape, Drawio.
- Multimedia applications: VLC, SubtitleEditor
- Flameshot, for screenshots.
- Gromit-MPX, for drawing on the screen.
- ... and more.

## Command Line Tools

- Python tools:
  - `cpr` / `cprall` / `cprallr` : Python requirement and toml upgrades.
  - `cleanpyd` : clean Python source directory.
- Docker tools:
  - `dclean` : Wipe containers.
  - `dnuke` : Wipe containers, images and volumes.
  - `dlistall` : List all containers and images.
  - `dstopall` : Stop all running container.
- Video tools:
  - `ffm540` : Convert video to 540p.
  - `ffm10secs` : Split video into 10 second clips.
- Other tools:
  - `cleantf` : clean Terraform source directory.
  - `git<cmd>s` : Various git commands to run on all repos in a directory.
  - `gitcp` : Git clone and install pre-commit (`gitcp <REPO> [dirname]`).
  - `pc_up` : Update pre-commit plugins.
  - `gha_up` : Update GitHub Actions.

## Keyboard Shorecuts

- `<Alt><Super>c` : VSCode
- `<Alt><Super>b` : Chrome
- `<Alt><Super>u` : Update Manager
- `<Super>h` : Home
- `<Super><Enter>` : Terminal
- `<Shift><PrintScr>` : Flameshot (capture/screenshot selection of screen)


___

# Misc

## Modifying Configurations

If any configurations need to be modified, most, if not all settings are at the
top of the **ubsetup.sh** file (before any function definitions), including:
  - List of packages/applications to be installed,
  - Configuration files for various components,
  - Values for system, desktop and browser settings.

## Testing

- The functions within the script - the ones which are testable - have various
  tests in **test_ubsetup.sh**.

- To run tests, first make sure you have **shunit2** and **bc** installed:
  - Either by setting up your environment with **ubsetup.sh**, OR
  - Apt install:  `sudo apt-get install -y shunit2 bc`

- Running tests:
  - `./test_ubsetup.sh`

___
