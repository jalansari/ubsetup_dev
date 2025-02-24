- [Introduction](#introduction)
- [First Steps (Install and Update Linux)](#first-steps-install-and-update-linux)
- [Running this Script](#running-this-script)
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

# First Steps (Install and Update Linux)

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

___

# Running this Script

- Usage instructions:
  - `./ubsetup.sh -h`

- Most likely usage:
  - `./ubsetup.sh -a -un "<Full_Name>" -ue "<Email_Address>" -ug "<group>"`
- Or, capture log to stdout and file:
  - `./ubsetup.sh -a --docker -un "<Full_Name>" -ue "<Email_Address>" -ug "<group>" 2>&1 | tee ubsetup.log`

___


# Modifying Configurations

If any configurations need to be modified, most, if not all settings are at the
top of the **ubsetup.sh** file (before any function definitions), including:
  - List of packages/applications to be installed,
  - Configuration files for various components,
  - Values for system, desktop and browser settings.

___


# Testing

- The functions within the script - the ones which are testable - have various
  tests in **test_ubsetup.sh**.

- To run tests, first make sure you have **shunit2** and **bc** installed:
  - Either by setting up your environment with **ubsetup.sh**, OR
  - Apt install:  `sudo apt-get install -y shunit2 bc`

- Running tests:
  - `./test_ubsetup.sh`

___
