#!/bin/bash

########################################
##### Constants and variables used
##### throughout this script.
########################################

declare -A DebPackages
DebPackages=(
             ["code"]="https://go.microsoft.com/fwlink/?LinkID=760868;mscode.deb" # 760865 for insider edition
             ["vagrant"]="https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.deb"
             ["dropbox"]="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2019.02.14_amd64.deb"
            )

InstallDir="/usr/share"
UsrLocalDir="/usr/local"

NodeJsVer="node-v10.15.3-linux-x64"
NodeJsPkg="$NodeJsVer.tar.xz"
NodeJsUrl="https://nodejs.org/dist/v10.15.3/$NodeJsPkg"
NodeInstallDir="$InstallDir/nodejs"

FossilScmPkg="fossil-linux-x64-2.8.tar.gz"
FossilScmUrl="https://www.fossil-scm.org/index.html/uv/$FossilScmPkg"
FossilInstallDir="$InstallDir/fossilscm"

GoLangPkg="go1.12.3.linux-amd64.tar.gz"
GoLangUrl="https://dl.google.com/go/$GoLangPkg"
GoPath="$UsrLocalDir/go"

TelegramPackage="telegram_linux.tar.xz"
TelegramPackageHttpURL="https://telegram.org/dl/desktop/linux"

VeraCryptPkg="veracrypt-1.23-setup.tar.bz2"
VeraCryptUrl="https://launchpad.net/veracrypt/trunk/1.23/+download/$VeraCryptPkg"


declare -A Fonts
Fonts=(
       ["open_sans"]="https://fonts.google.com/download?family=Open%20Sans"
      )
allFontsFolder="/usr/share/fonts/ubsetup_installed_fonts"


declare -A UserInfo
currentUserNameKey="*"
UserInfo=(
          [$currentUserNameKey]="Full Name;em@il.com;sshpvtkeyfile;maingroup"
         )


FileManagerShowHiddenYes=1
FileManagerShowHiddenNo=0
FileManagerShowHidden=$FileManagerShowHiddenYes
FileManagerViewMode="list"

WorkspacesNumberOf=1

CinnamonPanelHeight="33"
CinnamonPanelAutohide="false"
CinnamonRememberRecentFiles="true"

DesktopBackgroundColor="#100300"

LxPanelHeight="24"
LxPanelColour="#758880"

TerminatorScrollbackLines=10000
TerminatorWindowSize="1100, 700"

VimRcFile="/etc/vim/vimrc"
GitSysConfigFile="/etc/gitconfig"

FirefoxHomePage="https://www.google.co.uk"
FirefoxRememberLogins="false"
FirefoxSysConfig="/etc/firefox/syspref.js"

GlobalProfileFile="/etc/profile"
TempFolderForDownloads="/tmp"


userOfThisScript=`id -u -n $SUDO_USER`
groupOfUserOfThisScript=`id -g -n $SUDO_USER`
userHomeDir=$( getent passwd "$userOfThisScript" | cut -d: -f6 )

DevGroupName="adm" # This group applies to development tools where users need write access; e.g. so we can use npm install.  TODO - Maybe create a development specific group (don't reuse "adm").


UserHomeBin="$userHomeDir/bin"
TerminatorCfgDir="$userHomeDir/.config/terminator"
TerminatorCfgFile="$TerminatorCfgDir/config"
GoWorkspacePath="$userHomeDir/goworkspace"
UserProfileFile="$userHomeDir/.profile"
UnpackDirForIncompletePckgs="$userHomeDir/Downloads"


SwappinessVal=5
NumiNotifyWatches=524288


# Time is needed between install requests, otherwise, errors occur because previous request may not be complete.
SLEEP_AFTER_INSTALL_REQUEST="0.2"


########################################
##### Lists of components.
########################################

# List of components to be removed.
REMOVE_COMP__LIST=(
                   "brasero-common"
                   "ubuntuone-client"
                   "ubuntuone-couch"
                   "ubuntuone-installer"
                   "gnome-mahjongg"
                   "gnome-mines"
                   "gnome-sudoku"
                   "shotwell"
                   "transmission-common"
                   "banshee"
                   "totem-common"
                   "parole"
                   "xfburn"
                   "gmusicbrowser"
                   "pidgin"
                   "orage"
                   "xchat"
                   "hexchat-common"
                   "xfce4-dict"
                   "gwibber-service"
                   "tumbler"
                   "abiword"
                   "xpad"
                   "tomboy"
                   "sylpheed"
                   "audacious"
                   "gnome-mplayer"
                   "mpv"
                   "gnome-mpv"
                   "guvcview"
                   "mtpaint"
                   "gnumeric-common"
                   "ace-of-penguins"
                   "sgt-puzzles"
                   "xplayer-common"
                   "pix-data"
                   "pix"
                   "gnome-disk-utility"
                  )

# List of components to be installed.
INSTALL_COMP_LIST=(
                   "vim"
                   "htop"
                   "vlc"
                   "firefox"
                   "deluge"
                   "terminator"
                   "unzip"
                   "unrar"
                   "p7zip-full"
                   "libreoffice"
                   "ttf-mscorefonts-installer"
                   "google-chrome-stable"
                   "meld"
                   "rar"
                   "dia"
                   "inkscape"
                   "gimp"
                   "qmmp" # Music player like Windows' winamp.
                   "easytag" # One of the better ID3 tag editors.
                   "virtualbox-dkms"
                   "virtualbox-qt"
                   "gparted"
                   "graphviz"
                   "wireshark"
                   "sqlitebrowser"
                   "git"
                   "gitk"
                   "gitg"
                   "curl"
                   "shunit2" # Shell script unit test framework.
                   "pv"
                   "ssh"
                   "libpango1.0-0" # Needed by Dropbox installer.
                   "ipython"
                   "subsurface"
                   "python-pip" # Pip package management tools.
                   "python3-pip"
                   "python-tk" # Toolkit required for matplotlib graphics.
                   "python3-tk"
                  )

INSTAL_PIP2n3_MAP=(
                   "virtualenv"
                   "setuptools" # Installs easy_install, and needed by pylint.
                   "pylint" # Used by VSCode's python extension.
                  )

declare -A DebSources
DebSources=(
            ["deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main"]="/etc/apt/sources.list.d/google.list" # google-chrome
           )

ADD_APT_KEYS_LIST=(
                   "https://dl.google.com/linux/linux_signing_key.pub" # google-chrome
                  )

# List of PPA repositories to be added.
ADD_PPA_REPO_LIST=(
                   "ppa:subsurface/subsurface" # Needed to install subsurface dive computer application.
                  )

DEBCONF_SET_ITEMS=(
                   "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true"
                   "wireshark-common wireshark-common/install-setuid select true"
                  )

DEBCONF_REM_ITEMS=(
                   "ttf-mscorefonts-installer"
                   "wireshark-common"
                  )

LIST_OF_LAUNCHERS=(
                   "firefox"
                   "filemanager"
                   "terminator"
                   "google-chrome"
                   "virtualbox"
                   "code"
                  )


########################################
##### Usage help text.
########################################

TEXT_Usage="Usage $0 [-a] [-i] [-r] [-c] [-un] [-ue] [-h]\n\
\n\
-h:  Show this very same helpful message.\n\
\n\
Requests:\n\
-r:  Remove unnecessary components.  (Default.)\n\
-i:  Install components and configs.\n\
-c:  Configure user environment.\n\
-a:  Same and i, r and c combined.\n\
\n\
Configuration options:\n\
-un: Username to be configured for the user running this script.\n\
-ue: Email to be configured for the user running this script.\n\
\n\
Test options:\n\
-t:  Test mode; prints options and nothing else.\n\
-tt: Test script mode; does nothing, just allows loading into test\n\
     script for running tests.\n\
\n\
If no options are specified, default behaviour is to remove components\n\
(i.e. same as using -r option alone).\n"


########################################
##### Text files that are written as a whole.
########################################

##### Cinnamon Configs ######

TEXT_VimRC="set t_Co=256\n\
hi Normal guifg=#E0E2E4 guibg=#293134\n\
hi Normal ctermfg=195 ctermbg=233\n\
hi colorcolumn ctermbg=234 guibg=#1C1C1C\n\
execute \"set cc=73,81,\" . join(range(101,354), ',')\n\
hi LineNr ctermbg=238 guibg=#444444 ctermfg=243 guifg=#767676\n\
hi Search ctermbg=019 guibg=#0000AF ctermfg=011 guifg=#FFFF00\n\
set number\n\
set tabstop=4\n\
set shiftwidth=4\n\
set expandtab\n\
set hlsearch\n\
set title\n\
set listchars=eol:¶,tab:➤∘,trail:☠,extends:»,precedes:«\n\
set list\n\
set nocompatible\n"

TEXT_GitCfg="[core]\n\
	editor = vim\n"

TEXT_FirefoxCfg="user_pref(\"browser.startup.homepage\", \"$FirefoxHomePage\");\n\
user_pref(\"datareporting.healthreport.uploadEnabled\", false);\n\
user_pref(\"signon.rememberSignons\", $FirefoxRememberLogins);"

TEXT_TerminatorCfg="[global_config]\n\
[keybindings]\n\
[profiles]\n\
[[default]]\n\
background_darkness = 0.92\n\
scrollback_lines = $TerminatorScrollbackLines\n\
scroll_on_output = False\n\
background_type = transparent\n\
background_image = None\n\
use_system_font = False\n\
font = Monospace 14\n\
[layouts]\n\
[[default]]\n\
[[[child1]]]\n\
type = Terminal\n\
parent = window0\n\
[[[window0]]]\n\
type = Window\n\
parent = \"\"\n\
size = $TerminatorWindowSize\n\
[plugins]\n"

TEXT_LocalBookmarks="file://$userHomeDir/Documents\n\
file://$userHomeDir/Downloads\n"

FMShowHiddenFilesVal="false"
if [ $FileManagerShowHidden == 1 ]; then
    FMShowHiddenFilesVal="true"
fi
TEXT_NemoGSettingsConfig="[org.nemo.preferences]\n\
default-folder-viewer='$FileManagerViewMode-view'\n\
show-hidden-files=$FMShowHiddenFilesVal\n\
show-image-thumbnails='never'\n\
show-full-path-titles=true\n\
quick-renames-with-pause-in-between=true\n\
show-advanced-permissions=true\n\
show-home-icon-toolbar=true\n\
show-new-folder-icon-toolbar=true\n\
show-search-icon-toolbar=true\n\
show-compact-view-icon-toolbar=false\n\
show-icon-view-icon-toolbar=false\n\
show-list-view-icon-toolbar=false\n\
show-open-in-terminal-toolbar=true\n\
date-format='iso'\n\
\n\
[org.nemo.list-view]\n\
default-visible-columns=['name', 'size', 'type', 'date_modified', 'owner', 'group', 'permissions']\n"

TEXT_CinnamonTermGSettingsConfig="[org.cinnamon.desktop.applications.terminal]\n\
exec='/usr/bin/terminator'\n"
TEXT_TermGSettingsConfigGnome="[org.gnome.desktop.default-applications.terminal]\n\
exec='/usr/bin/terminator'\n"
TEXT_TermGSettingsConfigCinnamon="[org.cinnamon.desktop.default-applications.terminal]\n\
exec='/usr/bin/terminator'\n"

TEXT_CinnamonDesktopIfGSettingsConfig="[org.cinnamon.desktop.wm.preferences]\n\
theme='Mint-Y-Dark'\n\
num-workspaces=$WorkspacesNumberOf\n\
\n\
[org.cinnamon.theme]\n\
name='Mint-Y-Dark'\n\
\n\
[org.cinnamon.desktop.interface]\n\
icon-theme='Mint-X-Dark'\n\
gtk-theme='Mint-Y-Dark'\n\
clock-show-date=true\n\
scaling-factor=uint32 0\n\
\n\
[org.gnome.desktop.interface]\n\
scaling-factor=uint32 0\n"

TEXT_CinnamonSoundsGSettingsConfig="[org.cinnamon.sounds]\n\
login-enabled=false\n\
logout-enabled=false\n\
unplug-enabled=false\n\
tile-enabled=false\n\
plug-enabled=false\n\
switch-enabled=false\n"

TEXT_CinnamonMouseGSettingsConfig="[org.cinnamon.settings-daemon.peripherals.touchpad]\n\
natural-scroll=false\n\
motion-threshold=2\n\
disable-while-typing=true\n\
horizontal-scrolling=false\n"

TEXT_CinnamonPowerGSettingsConfig="[org.cinnamon.settings-daemon.plugins.power]\n\
sleep-display-ac=600\n\
lid-close-ac-action='nothing'\n\
lid-close-battery-action='nothing'\n"

TEXT_CinnamonDesktopGSettingsConfig="[org.nemo.desktop]\n\
trash-icon-visible=true\n\
\n\
[org.cinnamon.desktop.privacy]\n\
remember-recent-files=$CinnamonRememberRecentFiles\n\
\n\
[org.cinnamon.desktop.background]\n\
color-shading-type='solid'\n\
picture-options='none'\n\
primary-color='$DesktopBackgroundColor'\n\
\n\
[org.cinnamon]\n\
startup-animation=false\n\
desktop-effects=false\n\
desklet-decorations=0\n\
enabled-desklets=['clock@cinnamon.org:0:170:10']\n\
panels-height=['1:$CinnamonPanelHeight']\n\
panels-autohide=['1:$CinnamonPanelAutohide']\n\
\n\
[org.cinnamon.desktop.screensaver]\n\
use-custom-format=true\n\
date-format='%a %d %b %Y'\n"

TEXT_XedGSettingsConfig="[org.x.editor.preferences.editor]\n\
display-right-margin=true\n\
right-margin-position=uint32 80\n\
tabs-size=uint32 4\n\
display-line-numbers=true\n\
insert-spaces=true\n\
auto-indent=true\n\
bracket-matching=true\n\
scheme='oblivion'\n\
\n\
[org.x.editor.preferences.ui]\n\
minimap-visible=true\n"

##### Lubuntu Configs ######

TEXT_PCManFMCfg="[config]\n\
bm_open_method=0\n\
\n\
[volume]\n\
mount_on_startup=1\n\
mount_removable=1\n\
autorun=1\n\
\n\
[ui]\n\
always_show_tabs=0\n\
max_tab_chars=32\n\
win_width=798\n\
win_height=547\n\
splitter_pos=150\n\
media_in_new_tab=0\n\
desktop_folder_new_win=0\n\
change_tab_on_drop=1\n\
close_on_unmount=1\n\
focus_previous=0\n\
side_pane_mode=places\n\
view_mode=$FileManagerViewMode\n\
show_hidden=$FileManagerShowHidden\n\
sort=name;ascending;\n\
toolbar=newtab;navigation;home;\n\
show_statusbar=1\n\
pathbar_mode_buttons=0\n"

##### Application Configs ######

TEXT_VlcRC="[qt4]\n\
qt-privacy-ask=0\n\
metadata-network-access=0\n\
[core]\n\
play-and-exit=1\n\
one-instance-when-started-from-file=0\n"

TEXT_MozillaCrashReporter="[Crash Reporter]\n\
SubmitReport=0\n"

TEXT_AtomEditorConfig="\"*\":\n\
  core:\n\
    telemetryConsent: \"no\"\n\
  editor:\n\
    invisibles:\n\
      eol: \"¶\"\n\
    showInvisibles: true\n\
    showIndentGuide: true\n\
    tabLength: 4\n\
    tabType: \"soft\"\n\
    scrollPastEnd: true\n\
  welcome:\n\
    showOnStartup: false\n"

TEXT_VSCodeConfig="{\n\
  \"editor.fontFamily\": \"'Ubuntu Mono'\",\n\
  \"editor.fontSize\": 14,\n\
  \"editor.lineHeight\": 21,\n\
  \"editor.renderWhitespace\": \"all\",\n\
  \"editor.rulers\": [80, 100],\n\
  \"editor.quickSuggestions\": {\n\
    \"other\": true,\n\
    \"comments\": true,\n\
    \"strings\": true\n\
  },\n\
  \"workbench.startupEditor\": \"none\",\n\
  \"telemetry.enableTelemetry\": false,\n\
  \"files.trimTrailingWhitespace\": true,\n\
  \"diffEditor.ignoreTrimWhitespace\": false,\n\
  \"editor.detectIndentation\": false,\n\
}\n"


########################################
##### Helper functions.
########################################

LOG_PREFIX="ENVSETUP:  "
prefixColour="0;33"
logColour="0;34"
ERRORCOLOUR="1;31"
function PRINTLOG()
{   echo -e "\033[${prefixColour}m${LOG_PREFIX}\033[0m\033[${logColour}m${1}\033[0m"
}
# Print error by outputting line in RED.
function PRINT_ERROR()
{   PRINTLOG "\033[${ERRORCOLOUR}m$1\033[0m"
}

function printBinaryVal()
{   value=$(( $1 ))
    printf "Bin: 0b" && echo "obase=2;$value" | bc
    printf "Hex: 0x%08X\n" $value
    printf "Oct: 0o%011o\n" $value
}

function removeLeastSignificantBit()
{   checkValue=$(( $1 ))
    # Flip all bits up to and including the first 1 bit.
    oneNegated=$(( $checkValue - 1 ))
    # Bitwise & with original number, to zero all bits up to and including the
    # first bit.
    bitwiseAnd=$(( $oneNegated & $checkValue ))
    # Echo the value rather than return, because functions are limited to
    # returning up to a value of 255.
    echo $bitwiseAnd
}

# Check if a debian component is installed.
# Parameters:
#     $2 : Name of component to be checked.
# Returns:
#     0     : Component is installed.
#     Other : Component is not installed.
function checkDebPkgInstalled()
{   item=$1
    # Check installation was successful
    dpkg -l $item 2> /dev/null | grep -E '^ii' > /dev/null 2>&1
    return $?
}

# Installs package name given as argument.
# Parameters:
#     $1 : Name of package to be installed.
# Returns:
#     0     : Package installed successfully.
#     Other : Package not installed.
function installAptPackage()
{   item=$1
    ret=0
    checkDebPkgInstalled $item
    if [ $? != 0 ]; then
        apt-get install $item -y
        sleep $SLEEP_AFTER_INSTALL_REQUEST
        checkDebPkgInstalled $item
        ret=$?
    fi
    return $ret
}

function installDebPackage()
{   dpkg -i $2
    checkDebPkgInstalled $1
    if [ $? == 0 ]; then
        PRINTLOG "Installation successful <$1>"
    else
        PRINT_ERROR "ERROR: Deb installation failed <$1>"
    fi
}

# Download and install a debian package.
# Parameters:
#     $1 : Http URL of the debian package to be installed.
#     $2 : Name of component that will be installed from the debian package.
function installDebPackageFromHttp()
{   IFS=';' read -ra URLnNAME <<< "$1"
    debFileHttpUrl="${URLnNAME[0]}"
    packageName=$2
    PRINTLOG "Attempting to install <$packageName>, from:"
    PRINTLOG "    <$debFileHttpUrl>"
    checkDebPkgInstalled $packageName
    if [ $? == 0 ]; then
        PRINTLOG "Deb package already installed <$packageName>"
    else
        tempDownloadDir="$TempFolderForDownloads/ubsetuptempdir"
        if [ ${#URLnNAME[@]} == 1 ]; then
            debfilename="tempdebfile.deb"
        else
            debfilename="${URLnNAME[1]}"
        fi
        tempDownloadedFile="$tempDownloadDir/$debfilename"
        PRINTLOG "Downloading to <$tempDownloadedFile>"
        mkdir -p $tempDownloadDir
        wget $debFileHttpUrl -O $tempDownloadedFile
        installDebPackage $packageName $tempDownloadedFile
        rm -rf $tempDownloadDir
    fi
}

# Removes package name given as argument.
# Parameters:
#     $1 : Name of package to be removed.
function removeAptPackage()
{   item=$1
    checkDebPkgInstalled $item
    if [ $? == 0 ]; then
        apt-get remove $item -y
        sleep $SLEEP_AFTER_INSTALL_REQUEST
    fi
}

# Returns available file name based on name given as parameter.
# Parameters:
#     $1 : File name/path to be checked, if available, the same will be
#          returned.  If not available, find a name that is available, by
#          appending a number to the end of the input name.
# Returns:
#     Available filename based on the input $1 parameter.
function getAvailableFileName()
{   outputfile=$1
    tempname="$outputfile"
    uniquefilenum=1
    while [ 1 ]
    do
        if [[ -e $tempname ]]; then
            tempname="$outputfile.$uniquefilenum"
            uniquefilenum=`expr $uniquefilenum + 1`
        else
            outputfile="$tempname"
            break
        fi
    done
    echo $outputfile
}

function updatePathInFile()
{   newPath=$1
    file=$2
    if [ ! -f $file ]; then
        return 1
    fi
    FOUND=0
    grep '^\s*PATH=.*'$newPath'' $file > /dev/null 2>&1
    if [ $? != $FOUND ]; then
        grep '^\s*PATH=.*' $file > /dev/null 2>&1
        if [ $? == $FOUND ]; then
            sed -r -i 's|^(\s*PATH="?)(.*"?)$|\1'$newPath':\2|;' $file > /dev/null 2>&1
        else
            echo "PATH=$newPath:\$PATH" >> $file
        fi
    fi
}

function updatePathForCurrentUser()
{   PRINTLOG "Updating <$UserProfileFile>, adding <$1> to PATH."
    updatePathInFile $1 $UserProfileFile
}

function updatePathGlobally()
{   PRINTLOG "Updating <$GlobalProfileFile>, adding <$1> to PATH."
    updatePathInFile $1 $GlobalProfileFile
}

function addAptKeys()
{   listOfKeys=("${!1}")
    if [ ${#listOfKeys[@]} != 0 ]; then
        PRINTLOG "APT Keys to be added:"
        printf "        %s\n" "${listOfKeys[@]}"
        for item in "${listOfKeys[@]}"
        do
            PRINTLOG "ADDING KEY: [$item]"
            wget -q -O - $item | sudo apt-key add - > /dev/null
        done
    fi
}

function addDebSource()
{   fileSrc="$2"
    FOUND=0
    grepped=`grep -rF "$1" $(dirname "$fileSrc")`
    if [ $? == $FOUND ]; then
        PRINTLOG "    Deb source already set:\n<$grepped>"
    else
        echo "$1" >> "$fileSrc"
    fi
}

function removeDebSourceIfDup()
{   fileSrc="$2"
    numgrepped=`grep -rF "$1" $(dirname "$fileSrc") | wc -l`
    PRINTLOG "    <$numgrepped> sources found."
    if [ $numgrepped -gt 1 ]; then
        PRINTLOG "    Removing file."
        rm "$fileSrc"
    fi
}

function iterAssociativeArrAndCall()
{   if [[ ! "$1" =~ ^declare.+=.+ ]]; then
        return 1
    fi
    # Param $1 will be passed in as "declare -A <name>=<map>"
    # so remove the first part using bash substring removal (#<pattern>) and
    # assign the <map> to a the new associative array.
    declare -A mapOfRepos # Not necessary, but added for bitbucket pipeline to pass (without, the following eval will throw an error).
    eval "declare -A mapOfRepos=${1#*=}"
    if [ -v mapOfRepos[@] ]; then
        PRINTLOG "  Callback <$2>, <${#mapOfRepos[@]}>"
        for key in "${!mapOfRepos[@]}"
        do
            assocValue="${mapOfRepos[$key]}"
            PRINTLOG "    Key   <$key>,"
            PRINTLOG "    Value <$assocValue>"
            $2 "$key" "$assocValue"
        done
    fi
}

function addDebSourcestoSourceLists()
{   PRINTLOG "Adding Debian Sources."
    iterAssociativeArrAndCall "$1" addDebSource
}

function removeDebSourcesIfDup()
{   PRINTLOG "Removing duplicate Debian Sources."
    iterAssociativeArrAndCall "$1" removeDebSourceIfDup
}

function addAptRepos()
{   listOfRepos=("${!1}")
    if [ ${#listOfRepos[@]} != 0 ]; then
        PRINTLOG "PPA Repositories to be added:"
        printf "        %s\n" "${listOfRepos[@]}"
        for item in "${listOfRepos[@]}"
        do
            PRINTLOG "ADDING PPA: [$item]"
            add-apt-repository $item -y
        done
    fi
}

function addDebconfSettings()
{   listOfSettings=("${!1}")
    if [ ${#listOfSettings[@]} != 0 ]; then
        PRINTLOG "Debconf settings to be added:"
        printf "        %s\n" "${listOfSettings[@]}"
        for item in "${listOfSettings[@]}"
        do
            PRINTLOG "Setting: [$item]"
            debconf-set-selections <<< $item
        done
    fi
}

function removeDebconfSettings()
{   listOfSettings=("${!1}")
    if [ ${#listOfSettings[@]} != 0 ]; then
        PRINTLOG "Debconf settings to be removed:"
        printf "        %s\n" "${listOfSettings[@]}"
        for item in "${listOfSettings[@]}"
        do
            PRINTLOG "Removing setting: [$item]"
            echo PURGE | debconf-communicate $item > /dev/null
        done
    fi
}

function uninstallAptPackages()
{   listOfPackageNames=("${!1}")
    PRINTLOG "Components to be REMOVED:"
    printf "        %s\n" "${listOfPackageNames[@]}"
    for item in "${listOfPackageNames[@]}"
    do
        PRINTLOG "REMOVING: [${item}]"
        removeAptPackage "${item}"
    done
}

function installAptPackages()
{   listOfPackageNames=("${!1}")
    PRINTLOG "Components to be INSTALLED:"
    printf "        %s\n" "${listOfPackageNames[@]}"
    for item in "${listOfPackageNames[@]}"
    do
        PRINTLOG "INSTALLING: [$item]"
        installAptPackage $item
        if [ $? != 0 ]; then
            PRINT_ERROR "ERROR: Failed to install component <$item>."
        fi
    done
}

function installPythonPipPackages()
{   listOfPips=("${!1}")
    if [ ${#listOfPips[@]} != 0 ]; then
        PRINTLOG "Python packages to be INSTALLED:"
        printf "        %s\n" "${listOfPips[@]}"
        for item in "${listOfPips[@]}"
        do
            for pipv in "pip" "pip3"
            do
                PRINTLOG "INSTALLING $pipv: [$item]"
                $pipv install $item
                sleep $SLEEP_AFTER_INSTALL_REQUEST
                $pipv show $item
                if [ $? != 0 ]; then
                    PRINT_ERROR "FAILED to install [$item]"
                fi
            done
        done
    fi
}

# Download and unpack a tarball.
# Parameters:
#     $1 : Http URL of the package to be downloaded.
#     $2 : Name of tarball package that will be downloaded.
#     $3 : Location to which the tarball should be unpacked.
#     $4 : Optional.  Path, which if exists, means nothing needs to be done.
function wgetAndUnpack()
{   if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
        return 2
    fi
    if [ ! -z "$4" ] && [ -e "$4" ]; then
        PRINTLOG "Not downloading <$2>, as <$4> already exists."
        return 1
    fi
    PRINTLOG "Downloading and unpacking <$2> to <$3>."
    mkdir -p "$3"
    wget "$1" -O "$TempFolderForDownloads/$2"
    tar -C "$3" -xf "$TempFolderForDownloads/$2"
    rm "$TempFolderForDownloads/$2"
}

function launchAndKillAppAsUser()
{   appName=$1
    asUser=$2
    PRINTLOG "<$appName> open and close to initialise, as user <$asUser>:"
sudo -u $asUser bash << EOBLOCK # execute as owner who called this script, till End of Block (quoted  "limit string" of here document to disable parameter substitution within its body)
    echo ".. Launching <$appName>."
    $appName &
    FFPID=\$!
    echo ".. Waiting a few seconds to initialise (\$FFPID)."
    sleep 7
    psstatcmd="ps -o stat= \$FFPID"
    psstate=\$( \$psstatcmd )
    while [[ ! \$psstate =~ ^S ]] # && [[ \$psstate != "" ]]
    do
        echo ".. Waiting a little more to finish initialising, State = <\$psstate>."
        sleep 1
        psstate=\$( \$psstatcmd )
        echo ".. State = <\$psstate>"
    done
    echo ".. Killing <$appName> PID<\$FFPID>."
    sleep 0.5
    kill \$FFPID
    sleep 0.5
EOBLOCK
}

function addBCompToSysGitConfig()
{   checkDebPkgInstalled "bcompare"
    bcompInstalled=$?
    if [ $bcompInstalled == 0 ]; then
        diffTl="bc3"
        mergTl="bc3"
        PRINTLOG "Setting Git diff/merge tools: <$diffTl><$mergTl>"
        toolsConfigLines="[diff]\n	tool = $diffTl\n[merge]\n	tool = $mergTl\n"
        echo -e "$toolsConfigLines" >> "$1"
    fi
}

function addSysGitConfig()
{   PRINTLOG "WRITING GitConfig: [$GitSysConfigFile]"
    echo -e "$2" > "$1"
    addBCompToSysGitConfig "$1"
}

function addUserGitConfig()
{   gitUserCfg="/home/$1/.gitconfig"
    PRINTLOG "Git user config <$gitUserCfg>:"
    PRINTLOG "        <$4>, <$3>"
    userGitConfigLines="[user]\n	email = $4\n	name = $3\n\n[push]\n	default = simple\n"
    echo -e "$userGitConfigLines" > $gitUserCfg
    chown -R $1:$2 $gitUserCfg
    # TODO also add private ssh key to sshUserPvtKey="/home/$1/.ssh/id_rsa"
    # chown -R $1:$2 $sshUserPvtKey
    # chmod 600 $sshUserPvtKey
}

function usage()
{   BadArg=$1
    if [ "$BadArg" != "" ]; then
        PRINT_ERROR "ERROR: Bad arg supplied <$BadArg>"
    fi
    PRINTLOG "$TEXT_Usage"
}


########################################
##### Command line options processing,
##### and usage help.
########################################

RequestOptions=$((2#0000))
TestMode=0

opt_userfullname=""
opt_useremail=""

OPT_INSTAL=$((2#0001))
OPT_REMOVE=$((2#0010))
OPT_CONFIG=$((2#0100))

while [ "$1" != "" ]; do
    case $1 in
        -a ) RequestOptions=$(( RequestOptions | OPT_INSTAL | OPT_REMOVE | OPT_CONFIG ))
             ;;
        -i ) RequestOptions=$(( RequestOptions | OPT_INSTAL ))
             ;;
        -r ) RequestOptions=$(( RequestOptions | OPT_REMOVE ))
             ;;
        -c ) RequestOptions=$(( RequestOptions | OPT_CONFIG )) # TODO - apply config separately
             ;;
        -t ) TestMode=1
             ;;
        -tt ) return 0 # Return 0 is needed for testing.
             ;;
        -un ) shift
             opt_userfullname="$1"
             ;;
        -ue ) shift
             opt_useremail="$1"
             ;;
        -h ) usage
             exit
             ;;
        * )  usage "$1"
             exit 1
    esac
    shift
done

# If no request options provided, set default behaviour to remove components.
if [ $RequestOptions == 0 ]; then
    RequestOptions=$OPT_REMOVE
fi

currentUserDesc=""

PRINTLOG "Current user parameters:"
PRINTLOG "    Username <$userOfThisScript>"
PRINTLOG "    Group    <$groupOfUserOfThisScript>"
PRINTLOG "    Home     <$userHomeDir>"
if [ ! -z "$opt_userfullname" ]; then
PRINTLOG "    FullName <$opt_userfullname>"
currentUserDesc="$opt_userfullname;"
fi
if [ ! -z "$opt_useremail" ]; then
PRINTLOG "    Email    <$opt_useremail>"
if [ -z "$currentUserDesc" ]; then currentUserDesc=";"; fi
currentUserDesc="$currentUserDesc$opt_useremail;"
fi

if [ ! -z "$currentUserDesc" ]; then
    UserInfo[$currentUserNameKey]="$currentUserDesc"
fi

if [ $TestMode == 1 ]; then
    PRINTLOG "TEST MODE"
    PRINTLOG "=====Request Options========="
    printBinaryVal $RequestOptions
    exit
fi


########################################
##### Applying un/installations.
########################################

if [ $(( $RequestOptions & $OPT_REMOVE )) == $OPT_REMOVE ]; then
    uninstallAptPackages REMOVE_COMP__LIST[@]
fi


# Nothin more to do if the install option has not been requested.
if [ $(( $RequestOptions & $OPT_INSTAL )) != $OPT_INSTAL ]; then
    exit 0
fi


addAptKeys ADD_APT_KEYS_LIST[@]
addDebSourcestoSourceLists "$(declare -p DebSources)"
addAptRepos ADD_PPA_REPO_LIST[@]

PRINTLOG "APT Update:"
apt-get update

addDebconfSettings DEBCONF_SET_ITEMS[@]
installAptPackages INSTALL_COMP_LIST[@]
removeDebconfSettings DEBCONF_REM_ITEMS[@]

removeDebSourcesIfDup "$(declare -p DebSources)"

installPythonPipPackages INSTAL_PIP2n3_MAP[@]


########################################
##### Install Debian packages, which are
##### not available through APT.
##### Also, setup other, non-packaged,
##### applications.
########################################

PRINTLOG "Installing debian packages from web:"
for key in "${!DebPackages[@]}"
do
    installDebPackageFromHttp ${DebPackages["$key"]} $key
done

fossilBin="fossil"
wgetAndUnpack "$FossilScmUrl" "$FossilScmPkg" "$FossilInstallDir" "$FossilInstallDir/$fossilBin" \
    && updatePathGlobally "$FossilInstallDir"

nodeJsDir="$NodeInstallDir/$NodeJsVer"
wgetAndUnpack "$NodeJsUrl" "$NodeJsPkg" "$NodeInstallDir" "$nodeJsDir" \
    && updatePathGlobally "$nodeJsDir/bin"
chgrp -R $DevGroupName $nodeJsDir

wgetAndUnpack "$GoLangUrl" "$GoLangPkg" "$UsrLocalDir" "$GoPath"
if [ $? = 0 ]; then
    updatePathGlobally "$GoPath/bin"

    # TODO user workspace should be seperated when all configuration is seperated.
    PRINTLOG "Creating GoLang workspace for <$userOfThisScript>, which will be used to download any dependencies when building projects, such as modules from github."
    mkdir -p $GoWorkspacePath
    chown -R $userOfThisScript:$groupOfUserOfThisScript $GoWorkspacePath
    PRINTLOG "    Go workspace <$GoWorkspacePath>"
    grep "GOPATH=.*$GoWorkspacePath" $UserProfileFile > /dev/null 2>&1
    if [ $? == 0 ]; then
        PRINTLOG "GoLang workspace path already set in user's GOPATH variable."
    else
        echo "export GOPATH=$GoWorkspacePath" >> $UserProfileFile
    fi
fi

VeraCryptBin="/usr/bin/veracrypt"
veraCryptUnpackTo="$UnpackDirForIncompletePckgs/veracrypt"
wgetAndUnpack "$VeraCryptUrl" "$VeraCryptPkg" "$veraCryptUnpackTo" "$VeraCryptBin" \
    && chown -R $userOfThisScript:$groupOfUserOfThisScript "$veraCryptUnpackTo"
# Looks like veracrypt cannot be auto installed, as user has to accept license conditions.

telegramUnpackTo="$UnpackDirForIncompletePckgs"
telegramBin="$telegramUnpackTo/Telegram/Telegram"
wgetAndUnpack "$TelegramPackageHttpURL" "$TelegramPackage" "$telegramUnpackTo" "$telegramBin"
chown -R $userOfThisScript:$groupOfUserOfThisScript "$telegramUnpackTo"


########################################
##### Writing configuration files.
########################################

checkDebPkgInstalled "vim"
if [ $? == 0 ]; then
    PRINTLOG "WRITING VIMRC: [$VimRcFile]"
    echo -e "$TEXT_VimRC" > $VimRcFile
fi

checkDebPkgInstalled "git"
if [ $? == 0 ]; then
    addSysGitConfig "$GitSysConfigFile" "$TEXT_GitCfg"
    if [ -v UserInfo[@] ]; then
        for usern in "${!UserInfo[@]}"
        do
            userInfoValues="${UserInfo[$usern]}"
            IFS=';' read -ra userInfoArray <<< "$userInfoValues"
            fullname="${userInfoArray[0]}"
            email="${userInfoArray[1]}"
            # sshkeyfile="${userInfoArray[2]}"
            maingroup="${userInfoArray[3]}"
            if [ "$usern" == "$currentUserNameKey" ]; then
                usern=$userOfThisScript
                maingroup=$groupOfUserOfThisScript
            fi
            addUserGitConfig "$usern" "$maingroup" "$fullname" "$email"
        done
    fi
fi

checkDebPkgInstalled "firefox"
if [ $? == 0 ]; then
    PRINTLOG "Updating mozilla prefs: [$FirefoxSysConfig]"
    sed -i -r '/\"browser\.startup\.homepage\"/d; /\"datareporting\.healthreport\.uploadEnabled\"/d; /\"signon\.rememberSignons\"/d' $FirefoxSysConfig
    echo -e "$TEXT_FirefoxCfg" >> $FirefoxSysConfig
fi


########################################
##### Bashrc aliases for convenience commands.
########################################

PRINTLOG "Adding BashRC aliases."

BashrcForAll="/etc/skel/.bashrc"

sed -i.bak -r \
'/alias[[:space:]]+ll=/d;'\
'/alias hiss=/d;'\
'/____gititer____/d;'\
 $BashrcForAll
# '/export PYTHONPATH=/d;'\

echo -e "\
alias ll='ls --time-style=\"long-iso\" -alF'\n\
alias hiss='history | grep'\n\
function ____gititer____() { for d in ./*/; do pushd \$d > /dev/null 2>&1; pwd && git \$1; echo; popd > /dev/null 2>&1; done }\n\
alias gitstates='____gititer____ status'\n\
alias gitpushes='____gititer____ push'\n\
alias gitpulls='____gititer____ pull'\n\
alias gitdiffs='____gititer____ diff'\n"\
 >> $BashrcForAll
# export PYTHONPATH=.\n"\

usersBashrc="$userHomeDir/.bashrc"
cp $BashrcForAll $usersBashrc
chown $userOfThisScript:$groupOfUserOfThisScript $usersBashrc


########################################
##### Swappiness
########################################

swappinessOriginal=`cat /proc/sys/vm/swappiness`
PRINTLOG "Swappiness: old <$swappinessOriginal>, new <$SwappinessVal>."

SysCtlConf="/etc/sysctl.conf"
sed -i.bak -r \
'/vm\.swappiness/d;'\
'/fs\.inotify\.max_user_watches/d;'\
 $SysCtlConf
echo -e "\
vm.swappiness = $SwappinessVal\n\
fs.inotify.max_user_watches = $NumiNotifyWatches\n"\
 >> $SysCtlConf


########################################
##### Continue desktop configuration.
########################################

checkDebPkgInstalled "terminator"
terminatorinstalled=$?
if [ $terminatorinstalled == 0 ]; then
    PRINTLOG "WRITING TEMINATORCONFIG: [$TerminatorCfgFile]"
    mkdir -p $TerminatorCfgDir
    echo -e "$TEXT_TerminatorCfg" > $TerminatorCfgFile
    chown -R $userOfThisScript:$groupOfUserOfThisScript $TerminatorCfgDir
fi

# In the following, libgtk-3-common doesn't actually own the bookmarks, and
# I don't know if it creates the user's bookmarks, but it's something to
# check before configuring bookmarks.  Maybe fix this in the future when it
# is certain what is responsible for file manager bookmarks.
checkDebPkgInstalled "libgtk-3-common"
if [ $? == 0 ]; then
    PRINTLOG "GTK3 installed."
    localBookmarksFile="$userHomeDir/.config/gtk-3.0/bookmarks"
    PRINTLOG "WRITING local bookmarks: [$localBookmarksFile]"
    echo -e "$TEXT_LocalBookmarks" > $localBookmarksFile
    chown $userOfThisScript:$groupOfUserOfThisScript $localBookmarksFile
fi

checkDebPkgInstalled "deluge"
if [ $? == 0 ]; then
    delugeCfg="$userHomeDir/.config/deluge/gtkui.conf"
    launchAndKillAppAsUser "deluge" $userOfThisScript
    PRINTLOG "Updating deluge prefs: [$delugeCfg]"
    sed -i.bak -r 's|(.*close_to_tray.*)false(.*)|\1true\2|;' $delugeCfg
fi

checkDebPkgInstalled "atom"
if [ $? == 0 ]; then
    AtomUsrDir="$userHomeDir/.atom"
    AtomCfg="$AtomUsrDir/config.cson"
    if [ ! -f $AtomCfg ]; then
        PRINTLOG "Configuring Atom editor."
        mkdir -p $AtomUsrDir
        echo -e "$TEXT_AtomEditorConfig" >> $AtomCfg
        chown -R $userOfThisScript:$groupOfUserOfThisScript $AtomUsrDir
    fi
fi

checkDebPkgInstalled "code"
if [ $? == 0 ]; then
    VSCodeDir="$userHomeDir/.config/Code"
    VSCodeUsrDir="$VSCodeDir/User"

    PRINTLOG "Configuring VSCode editor."

    mkdir -p $VSCodeUsrDir
    VSCodeCfg="$VSCodeUsrDir/settings.json"
    echo -e "$TEXT_VSCodeConfig" >> $VSCodeCfg
    chown -R $userOfThisScript:$groupOfUserOfThisScript $VSCodeDir

    function installVSCodeExt()
    {   vscodeext=$1
        PRINTLOG "Installing VSCode Extension <$vscodeext>"
sudo -u $userOfThisScript bash << EOBLOCK
        code --install-extension $vscodeext
        if [ \$? != 0 ]; then echo -e "\\033[${ERRORCOLOUR}mFailed to install VSCode plugin <$vscodeext>.\\033[0m"; fi
EOBLOCK
    }
    installVSCodeExt "ms-python.python"
    # installVSCodeExt "streetsidesoftware.code-spell-checker"
fi


########################################
##### Writing dconf configurations.
########################################

checkDebPkgInstalled "nemo" # File manager, as used in LinuxMint.
nemoinstalled=$?
checkDebPkgInstalled "cinnamon" # Cinnamon desktop environment, as used one of the LinuxMint variants
cinnamonInstalled=$?
checkDebPkgInstalled "xed" # Text editor, as used in LinuxMint.
xedinstalled=$?
if [ $nemoinstalled == 0 ] || [ $cinnamonInstalled == 0 ] || [ $xedinstalled == 0 ]; then
    # Install dconf cli tools to set various cinnamon configurations.
    dconfcmdpkg="dconf-cli"
    PRINTLOG "INSTALLING [$dconfcmdpkg] for dconf configured components."
    installAptPackage $dconfcmdpkg
    if [ $? != 0 ]; then
        PRINT_ERROR "ERROR: Failed to install critical component <$dconfcmdpkg> needed for system settings."
        exit 1
    fi
fi

RunGlibCompileSchemas=0
GlibScemasDir="/usr/share/glib-2.0/schemas"
GlibPriorityNum="zzz" # This should be a number, but distros are not using priority numbers, so we have to try being higher priority by using lexicographical ordering.

if [ $nemoinstalled == 0 ]; then
    PRINTLOG "Configuring Nemo file manager."
    NemoGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_nemo.gschema.override"
    echo -e "$TEXT_NemoGSettingsConfig" >> $NemoGSettingsCfg
    RunGlibCompileSchemas=1
fi

if [ $cinnamonInstalled == 0 ]; then
    PRINTLOG "Configuring Cinnamon."

    clockCfg="/usr/share/cinnamon/desklets/clock@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$clockCfg>"
    sed -i.bak -r '/\"font-size\"/,/^\s*}/{s|(\"default\"\s*:\s*)[[:digit:]]+(,?)|\130\2|;};'\
'/\"text-color\"/,/^\s*}/{s|(\"default\"\s*:\s*\")rgb\([[:digit:],]+\)(\",?)|\1rgb(70,0,0)\2|;};'\
'/\"use-custom-format\"/,/^\s*}/{s|(\"default\"\s*:\s*)false(,?)|\1true\2|;};'\
'/\"date-format\"/,/^\s*}/{s|(\"default\"\s*:\s*\").*?(\",?)|\1%Y %m %d, %H:%M\2|;};' $clockCfg

    calendarCfg="/usr/share/cinnamon/applets/calendar@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$calendarCfg>"
    sed -i.bak -r '/\"show-week-numbers\"/,/^\s*}/{s|(\"default\"\s*:\s*)false(,?)|\1true\2|;};'\
'/\"use-custom-format\"/,/^\s*}/{s|(\"default\"\s*:\s*)false(,?)|\1true\2|;};'\
'/\"custom-format\"/,/^\s*}/{s|(\"default\"\s*:\s*)\".*?\"(,?)|\1\"%a %d %b %Y, %H:%M\"\2|;};' $calendarCfg

    menuCfg="/usr/share/cinnamon/applets/menu@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$menuCfg>"
    sed -i.bak -r '/\"menu-label\"/,/^\s*}/{s|(\"default\"\s*:\s*)\".*?\"(,?)|\1\"\"\2|;};' $menuCfg

    powerCfg="/usr/share/cinnamon/applets/power@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$powerCfg>"
    sed -i.bak -r '/\"labelinfo\"/,/^[[:space:]]*\"default\"/{s|(\"default\"\s*:\s*\").*?(\",?)|\1percentage_time\2|;};' $powerCfg

    launchersListStr=""
    for applauncher in "${LIST_OF_LAUNCHERS[@]}"
    do
        if [ "$applauncher" == "filemanager" ]; then
            applauncher="nemo" # Cinnamon's filemanager is "nemo"
        fi
        # Create comma separated list.
        launchersListStr+="\"$applauncher.desktop\", "
    done
    # Remove the two last chars ', ' (to make sure last item in list is formatted correctly).
    launchersListStr="${launchersListStr::-2}"

    launchersCfg="/usr/share/cinnamon/applets/panel-launchers@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$launchersCfg>, with list <$launchersListStr>"
    # Replace all items in the panel "default" list.
    sed -i.bak -r '/\"launcherList\"/,/^\s*}/{s|(\"default\"\s*:\s*\[).*?(\],?)|\1'"$launchersListStr"'\2|;};' $launchersCfg

    launchers_19_1_Cfg="/usr/share/cinnamon/applets/grouped-window-list@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$launchers_19_1_Cfg>, with list <$launchersListStr>"
    sed -i.bak -r '/\"pinned-apps\"/,/^\s*}/{s|(\"default\"\s*:\s*\[).*?(\],?)|\1'"$launchersListStr"'\2|;};' $launchers_19_1_Cfg

    rm -rf "$userHomeDir/.cinnamon/configs/clock@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/calendar@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/menu@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/power@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/panel-launchers@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/grouped-window-list@cinnamon.org"

    PRINTLOG "Configuring Desktop Interface options."
    PRINTLOG ".. dark theme."
    PRINTLOG ".. number of workspaces <$WorkspacesNumberOf>"
    PRINTLOG ".. show desktop clock/date."
    PRINTLOG ".. interface scaling."
    DesktopIfGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktopif.gschema.override"
    echo -e "$TEXT_CinnamonDesktopIfGSettingsConfig" >> $DesktopIfGSettingsCfg

    PRINTLOG "Configuring Desktop Sounds."
    SoundsGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_sounds.gschema.override"
    echo -e "$TEXT_CinnamonSoundsGSettingsConfig" >> $SoundsGSettingsCfg

    PRINTLOG "Configuring Touchpad/Mouse."
    MouseGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_mouse.gschema.override"
    echo -e "$TEXT_CinnamonMouseGSettingsConfig" >> $MouseGSettingsCfg

    PRINTLOG "Configuring Power."
    PowerGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_power.gschema.override"
    echo -e "$TEXT_CinnamonPowerGSettingsConfig" >> $PowerGSettingsCfg

    PRINTLOG "Configuring Desktop."
    PRINTLOG ".. remembering recent files <$CinnamonRememberRecentFiles>"
    PRINTLOG ".. background solid colour."
    PRINTLOG ".. background animations and decorations."
    PRINTLOG ".. panel sizing."
    DesktopGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktop.gschema.override"
    echo -e "$TEXT_CinnamonDesktopGSettingsConfig" >> $DesktopGSettingsCfg

    if [ $terminatorinstalled == 0 ]; then
        PRINTLOG "Configuring Terminator as Default Terminal."
        TermGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktopterm.gschema.override"
        echo -e "$TEXT_CinnamonTermGSettingsConfig" >> $TermGSettingsCfg

        TermGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktopterm_cin.gschema.override"
        echo -e "$TEXT_TermGSettingsConfigCinnamon" >> $TermGSettingsCfg

        TermGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktopterm_gnm.gschema.override"
        echo -e "$TEXT_TermGSettingsConfigGnome" >> $TermGSettingsCfg
    fi

    RunGlibCompileSchemas=1
fi

if [ $xedinstalled == 0 ]; then
    PRINTLOG "Configuring Xed."
    XedGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_xed.gschema.override"
    echo -e "$TEXT_XedGSettingsConfig" >> $XedGSettingsCfg
    RunGlibCompileSchemas=1
fi


if [ $RunGlibCompileSchemas ]; then
    PRINTLOG "GSettings compiling schemas."
    glib-compile-schemas "$GlibScemasDir/"
fi


########################################
##### Writing configurations for Lubuntu.
########################################

checkDebPkgInstalled "leafpad"
if [ $? == 0 ]; then
    PRINTLOG "Configuring Leafpad editor."
    LeafpadCfg="/usr/share/lubuntu/leafpad/leafpadrc"
    sed -i -r '4 s/.*(\d+)$/Ubuntu Mono \1/' $LeafpadCfg
    # Change second last line from "0" to "1", which means, show line numbers.
    sed -i 'x; ${s/0/1/;p;x}; 1d' $LeafpadCfg
    rm -rf "$userHomeDir/.config/leafpad/leafpadrc"
fi

checkDebPkgInstalled "lubuntu-core" # Use this to see if the environment is Lubuntu desktop 16.04-17.10.
lubuntuCoreInstalled=$?
checkDebPkgInstalled "lubuntu-gtk-core" # Use this to see if the environment is Lubuntu desktop 18.04.
lubuntuGtkCoreInstalled=$?
if [ $lubuntuCoreInstalled == 0 ] || [ $lubuntuGtkCoreInstalled == 0 ]; then
    PRINTLOG "Configuring Lubuntu panel colour and size."
    PanelCfg="/usr/share/lxpanel/profile/Lubuntu/panels/panel"
    sed -i.bak -r 's/(height=).*/\1'"$LxPanelHeight"'/; s/(transparent=).*/\11/; s/(tintcolor=).*/\1'"$LxPanelColour"'/; s/(alpha=).*/\1255/; s/(iconsize=).*/\1'"$LxPanelHeight"'/;' $PanelCfg

    PRINTLOG "Configuring Lubuntu panel launchers."
    iconbarTypeName="launchtaskbar"
    # Find the line number where the panel list (the first launch-bar) begins.
    lineNumber=`grep -n -m 1 "^[[:space:]]*type[[:space:]]*=[[:space:]]*$iconbarTypeName" $PanelCfg | grep -o "^[0-9]*"`
    # Get the first line of the list, and take the indent (spaces).
    spaces=`sed -n "${lineNumber}p" $PanelCfg | sed -r 's/^([[:space:]]*).*/\1/;'`
    launchbarCfg="\\${spaces}type=$iconbarTypeName\n"
    launchbarCfg+="\\${spaces}Config {\n"
    for applauncher in "${LIST_OF_LAUNCHERS[@]}"
    do
        if [ "$applauncher" == "filemanager" ]; then
            applauncher="pcmanfm" # Lubuntu's filemanager.
        fi
        # Create the list, with each item indented, with a \ at the beginning to make sure sed (later) prints the space and doesn't ignore it as whitespace.
        launchbarCfg+="\\${spaces}\\${spaces}Button {\n"
        launchbarCfg+="\\${spaces}\\${spaces}\\${spaces}id=$applauncher.desktop\n"
        launchbarCfg+="\\${spaces}\\${spaces}}\n"
    done
    launchbarCfg+="\\${spaces}}"
    # PRINTLOG "Updating file <$PanelCfg> from line <$lineNumber>"
    # Remove all items in the panel's first launch-bar; the first should be before the first spacer.
    sed -i -r '/^[[:space:]]*type[[:space:]]*=[[:space:]]*'"$iconbarTypeName"'/,/^'"$spaces"'\}$/d' $PanelCfg
    # Print the new list of launch-bar items at the line number (found above).
    sed -i "${lineNumber}i$launchbarCfg" $PanelCfg

    rm -rf "$userHomeDir/.config/lxpanel"

    # Configure number of workspaces.
    PRINTLOG "Configuring Lubuntu's number of workspaces."
    LubWinMgrCfg="/usr/share/lubuntu/openbox/rc.xml"
    sed -i -r '/<desktops>/,/<\/desktops>/{s|([[:digit:]]*<number>)[[:digit:]]+(</number>)|\1'"$WorkspacesNumberOf"'\2|};' $LubWinMgrCfg

    rm -rf "$userHomeDir/.config/openbox"

    PRINTLOG "Configuring Lubuntu desktop wallpaper."
    LubuntuDesktopCfg="$userHomeDir/.config/pcmanfm/lubuntu/desktop-items-0.conf"
    LubuntuDesktopCfgBak=`getAvailableFileName "$LubuntuDesktopCfg.bak"`
    PRINTLOG "Backing up LubuntuDesktopCfg file to <$LubuntuDesktopCfgBak>"
    cp $LubuntuDesktopCfg $LubuntuDesktopCfgBak
    sed -r 's|^(wallpaper_mode=).*|\1color|; s|^(desktop_bg=).*|\1#172030|;' < $LubuntuDesktopCfg > $LubuntuDesktopCfg.new
    mv $LubuntuDesktopCfg.new $LubuntuDesktopCfg
fi

checkDebPkgInstalled "pcmanfm" # Lubuntu file manager.
if [ $? == 0 ]; then
    PRINTLOG "Configuring PCManFM file manager."
    PCManFMCfg="$userHomeDir/.config/pcmanfm/lubuntu/pcmanfm.conf"
    if [[ -e $PCManFMCfg ]]; then
        PCManFMCfgBak=`getAvailableFileName "$PCManFMCfg.bak"`
        PRINTLOG "Backing up PCManFMCfg file to <$PCManFMCfgBak>"
        cp $PCManFMCfg $PCManFMCfgBak
        sed -r 's|^(view_mode=).*$|\1'"$FileManagerViewMode"'|; s|^(show_hidden=).*$|\1'"$FileManagerShowHidden"'|;' < $PCManFMCfg > $PCManFMCfg.new
        # TODO sort=mtime;descending;
        mv $PCManFMCfg.new $PCManFMCfg
    else
        PRINTLOG "WRITING PCManFM config: [$PCManFMCfg]"
        echo -e "$TEXT_PCManFMCfg" > $PCManFMCfg
        chown $userOfThisScript:$groupOfUserOfThisScript $PCManFMCfg
    fi
    LibFmCfg="$userHomeDir/.config/libfm/libfm.conf"
    sed -i -r 's/(terminal=).*/\1terminator %s/;' $LibFmCfg
fi


########################################
##### Adding fonts.
########################################

doBuildFontCache=false
for key in "${!Fonts[@]}"
do
    fontFolder="$allFontsFolder/$key"
    if [ -e "$fontFolder" ]; then
        PRINTLOG "Font [$key] already exists: [$fontFolder]"
        continue
    fi
    doBuildFontCache=true
    downloadUrl=${Fonts["$key"]}
    PRINTLOG "Download and setup font [$key]: [$downloadUrl] -> [$fontFolder]"
    wget -O $key.zip $downloadUrl
    mkdir -p $fontFolder
    unzip -d $fontFolder $key.zip
    rm $key.zip
done
if [ "$doBuildFontCache" = true ]; then
    chmod -R --reference=/usr/share/fonts/opentype $allFontsFolder
    fc-cache -fv
fi


########################################
##### Adding users.
########################################

if [ -v UserInfo[@] ]; then
    for usern in "${!UserInfo[@]}"
    do
        PRINTLOG "User: username <$usern>"
        userInfoValues="${UserInfo[$usern]}"
        IFS=';' read -ra userInfoArray <<< "$userInfoValues"
        fullname="${userInfoArray[0]}"
        email="${userInfoArray[1]}"
        sshkeyfile="${userInfoArray[2]}"
        maingroup="${userInfoArray[3]}"
        if [ "$usern" == "$currentUserNameKey" ]; then
            usern=$userOfThisScript
            maingroup=$groupOfUserOfThisScript
            PRINTLOG "Updating current user : name <$fullname>, email <$email>, maingrp <$maingroup>, sshk <$sshkeyfile>"
            # TODO - do something?
        else
            # TODO - create addNewUser function
            PRINTLOG "Adding new user : name <$fullname>, email <$email>, maingrp <$maingroup>, sshk <$sshkeyfile>"
            # addNewUser "$usern" "$maingroup" "$fullname" "$email"
        fi
    done
fi


########################################
##### Installations complete, just show
##### message for user to reboot system.
##### Some settings, e.g. PCManFM, will
##### not apply without system restart.
########################################

PRINTLOG "******************************"
PRINTLOG "Manual configs to be done:"
PRINTLOG "  *  Firefox addons: AdBlock, noScript, ..."
PRINTLOG "  *  VSCode Extensions: Code Spell Checker ..."
PRINTLOG "Installations to be completed manually:"
PRINTLOG "  *  Veracrypt"
PRINTLOG "  *  Dropbox"
PRINTLOG "******************************"
PRINTLOG ""
PRINTLOG "******************************"
PRINTLOG "IMMEDIATE REBOOT RECOMMENDED."
PRINTLOG "******************************"
