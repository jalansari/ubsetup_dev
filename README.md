Script that sets up a Linux Ubuntu-based system, to be used for development.

Currently, only really works with Ubuntu 18.04 and Linux Mint 19.3.

The script is intended to be a single script that can be run directly after
installing a system.  Therefore, a very convenient, one-file, single-step to
install packages and applications, and configure the system.
No external dependencies, just one file **ubsetup.sh**.

___


# Running

* Usage instructions:
  * `./ubsetup.sh -h`

* Most likely usage:
  * `./ubsetup.sh -a -un "<Full_Name>" -ue "<Email_Address>"`
* Or, capture log to stdout and file:
  * `./ubsetup.sh -a -un "<Full_Name>" -ue "<Email_Address>" | tee ubsetup.log`

___


# Modifying Configurations

If any configurations need to be modified, most, if not all settings are at the
top of the **ubsetup.sh** file (before any function definitions), including:
  * List of packages/applications to be installed,
  * Configuration files for various components,
  * Values for system, desktop and browser settings.

___


# Testing

* The functions within the script, which are testable, have various tests in **test_ubsetup.sh**.

* To run tests, first make sure you have **shunit2** and **bc** installed:
  * Either by setting up your environment with **ubsetup.sh**, OR
  * Apt install:  `sudo apt-get install -y shunit2 bc`

* Running tests:
  * `./test_ubsetup.sh`

___
