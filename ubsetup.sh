#!/bin/bash

########################################
##### Constants and variables used
##### throughout this script.
########################################

declare -A DebPackages
DebPackages=(
             ["code"]="https://go.microsoft.com/fwlink/?LinkID=760868;mscode.deb" # 760865 for insider edition
             ["vagrant"]="https://releases.hashicorp.com/vagrant/2.2.16/vagrant_2.2.16_x86_64.deb"
             ["dropbox"]="https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb"
             ["draw.io"]="https://github.com/jgraph/drawio-desktop/releases/download/v14.6.13/drawio-amd64-14.6.13.deb"
             ["mysql-workbench-community"]="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.25-1ubuntu21.04_amd64.deb"
             ["slack-desktop"]="https://downloads.slack-edge.com/linux_releases/slack-desktop-4.17.0-amd64.deb"
            )

InstallDir="/usr/share"
UsrLocalDir="/usr/local"

NodeJsVer="node-v14.17.1-linux-x64"
NodeJsPkg="$NodeJsVer.tar.xz"
NodeJsUrl="https://nodejs.org/dist/v14.17.1/$NodeJsPkg"
NodeInstallDir="$InstallDir/nodejs"

FossilScmPkg="fossil-linux-x64-2.15.2.tar.gz"
FossilScmUrl="https://fossil-scm.org/home/uv/$FossilScmPkg"
FossilInstallDir="$InstallDir/fossilscm"

GoLangPkg="go1.16.5.linux-amd64.tar.gz"
GoLangUrl="https://golang.org/dl/$GoLangPkg"
GoPath="$UsrLocalDir/go"

TelegramPackage="telegram_linux.tar.xz"
TelegramPackageHttpURL="https://telegram.org/dl/desktop/linux"

VeraCryptPkg="veracrypt-1.24-Update7-setup.tar.bz2"
VeraCryptUrl="https://launchpad.net/veracrypt/trunk/1.24-update7/+download/$VeraCryptPkg"

DockerComposeUrl="https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64"

TerraformPkg="terraform_1.0.0_linux_amd64.zip"
TerraformUrl="https://releases.hashicorp.com/terraform/1.0.0/$TerraformPkg"
TerraformInstallDir="$InstallDir/terraform"

TerragruntUrl="https://github.com/gruntwork-io/terragrunt/releases/download/v0.31.0/terragrunt_linux_amd64"
TerragruntInstallDir="$InstallDir/terragrunt"

ConfiglintPkg="config-lint_Linux_x86_64.tar.gz"
ConfiglintUrl="https://github.com/stelligent/config-lint/releases/download/v1.6.0/$ConfiglintPkg"
ConfiglintInstallDir="$InstallDir/configlint"

AwsCliPkg="awscli-exe-linux-x86_64.zip"
AwsCliUrl="https://awscli.amazonaws.com/$AwsCliPkg"

AndroidPkg="android-studio-ide-202.7351085-linux.tar.gz"
AndroidUrl="https://dl.google.com/dl/android/studio/ide-zips/4.2.1.0/$AndroidPkg"
AndroidInstallDir="$InstallDir/androidstudio"

FlutterPkg="flutter_linux_2.2.2-stable.tar.xz"
FlutterUrl="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/$FlutterPkg"
FlutterInstallDir="$InstallDir/flutterdev"


declare -A Fonts
Fonts=(
       ["open_sans"]="https://fonts.google.com/download?family=Open%20Sans"
       ["roboto_mono"]="https://fonts.google.com/download?family=Roboto%20Mono"
       ["inconsolata"]="https://fonts.google.com/download?family=Inconsolata"
       ["source_code_p"]="https://fonts.google.com/download?family=Source%20Code%20Pro"
       ["mononoki"]="https://github.com/madmalik/mononoki/releases/download/1.2/mononoki.zip"
       ["jetbrains_mono"]="https://www.fontsquirrel.com/fonts/download/jetbrains-mono"
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

CinnamonPanelHeight="25"
CinnamonPanelAutohide="false"
CinnamonRememberRecentFiles="true"

DesktopBackgroundColor="#100300"

LxPanelHeight="24"
LxPanelColour="#758880"

TerminatorScrollbackLines=10000
TerminatorWindowSize="1100, 600"

VimRcFile="/etc/vim/vimrc"
GitSysConfigFile="/etc/gitconfig"

FirefoxHomePage="https://www.google.co.uk"
FirefoxRememberLogins="false"
FirefoxSysConfig="/etc/firefox/syspref.js"

GlobalProfileFile="/etc/profile"
TempFolderForDownloads="/tmp"


userOfThisScript=$( id -u -n "$SUDO_USER" )
groupOfUserOfThisScript=$( id -g -n "$SUDO_USER" )
userHomeDir=$( getent passwd "$userOfThisScript" | cut -d: -f6 )

DevGroupName="adm" # This group applies to development tools where users need write access; e.g. so we can use npm install.  TODO - Maybe create a development specific group (don't reuse "adm").


# UserHomeBin="$userHomeDir/bin"
TerminatorCfgDir="$userHomeDir/.config/terminator"
TerminatorCfgFile="$TerminatorCfgDir/config"
GoWorkspacePath="$userHomeDir/goworkspace"
GoWorkspacePathLit="\$HOME/goworkspace"
UserProfileFile="$userHomeDir/.profile"
UnpackDirForIncompletePckgs="$userHomeDir/Downloads"


SwappinessVal=5
NumiNotifyWatches=524288


# Time is needed between install requests, otherwise, errors occur because previous request may not be complete.
SLEEP_AFTER_INSTALL_REQUEST="0.2"


UbuntuReleaseName=$( awk -F"=" '/^UBUNTU_CODENAME/ {print $2;}' /etc/os-release )


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
                   "aisleriot" # solitaire games
                   "2048-qt"
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
                   "celluloid"
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

# List of components to be installed prior to running apt update.
P_UPDATE_INS_LIST=(
                  )

# List of components to be installed.
INSTALL_COMP_LIST=(
                   "vim"
                   "htop"
                   "unzip"
                   "python-pip" # Pip package management tools.
                   "python3-pip"
                   "python3-venv"
                  )

INSTAL_PIP2n3_MAP=(
                   "virtualenv"
                  )

INSTALL_COMP_LIST_SERVER=(
                   "fail2ban"
                   "nginx"
                   "uwsgi-plugin-python3"
                  )

INSTAL_PIP2n3_MAP_SERVER=(
                   "uwsgi"
                   )

INSTALL_COMP_LIST_DESKTOP=(
                   "vlc"
                   "firefox"
                   "qbittorrent"
                   "terminator"
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
                   "libpango-1.0-0" # Needed by Dropbox installer.
                   "libpango1.0-0" # Needed by Dropbox installer.
                   "libzip4"
                   "libproj19" # Needed by mysql-workbench
                   "proj-data" # Needed by mysql-workbench
                   "libopengl0" # Needed by mysql-workbench
                   "libpcrecpp0v5" # Needed by mysql-workbench
                   "libappindicator3-1" # Needed for draw.io
                   "ipython"
                   "python-tk" # Toolkit required for matplotlib graphics.
                   "python3-tk"
                   "ncdu"
                  )

INSTAL_PIP2n3_MAP_DESKTOP=(
                   "setuptools" # Installs easy_install, needed to install virtualenv.
                   "yolk3k" # Needed to query for latest version of pip packages (see "cpr" command in bashrc).
                  )

declare -A DebSources
DebSources=(
            ["deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main"]="/etc/apt/sources.list.d/google.list" # google-chrome
           )

ADD_APT_KEYS_LIST=(
                   "https://dl.google.com/linux/linux_signing_key.pub" # google-chrome
                  )

# List of PPA repositories to be added.
ADD_PPA_REPO_LIST=(
                  )

ADD_PPA_REPO_LIST_DESKTOP=(
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

read -r -d '' TEXT_Usage << EOTXT
Usage $0 [-a] [-i] [-r]
      [--ruby | --rubyv <version>] [--docker] [--gitlabr] [--rabbit] [--tor] [--flutter]
      [-un <FullName>] [-ug <GroupName>] [-ue <Email>]
      [-h]

-h   : Show this very same helpful message.

Requests:
-r       : Remove unnecessary components.  (Default.)
-i       : Install components and configs.
-a       : Same and i and r combined.
--ruby   : Intall RVM for Ruby installation.  (Not required if using '--rubyv').
--rubyv  : Intall RVM, AND install a specific Ruby version.
--docker : Install Docker Engine - Community.
--gitlabr: Install Gitlab Runner (needs --docker for this to work).
--rabbit : Install RabbitMq, with its Erlang dependency.
--tor    : Install Tor Daemon, which listens on port 9050.
--flutter: Install majority of components to get Flutter setup.

Configuration options:
-un      : Configure full name for the user running this script.
-ug      : Configure group name for the user running this script.
-ue      : Configure email for the user running this script.

Test options:
-t       : Test mode; prints options and nothing else.
-tt      : Testing mode; does nothing, just allows loading into test script
           for running tests.

If no options are specified, default behaviour is to remove components
(i.e. same as using -r option alone).

Example command:
sudo ./ubsetup.sh -a --docker -un "<FULL_NAME>" -ue "<EMAIL>" -ug $( id -g -n $USER ) 2>&1 | tee ubsetup.sh.log
EOTXT


########################################
##### Text files that are written as a whole.
########################################

read -r -d '' TEXT_VimRC <<- EOTXT
	set t_Co=256
	hi Normal guifg=#E0E2E4 guibg=#293134
	hi Normal ctermfg=195 ctermbg=233
	hi colorcolumn ctermbg=234 guibg=#1C1C1C
	execute "set cc=73,81," . join(range(101,354), ',')
	hi LineNr ctermbg=238 guibg=#444444 ctermfg=243 guifg=#767676
	hi Search ctermbg=019 guibg=#0000AF ctermfg=011 guifg=#FFFF00
	set number
	set tabstop=4
	set shiftwidth=4
	set expandtab
	set hlsearch
	set title
	set listchars=eol:¶,tab:➤∘,trail:☠,extends:»,precedes:«
	set list
	set nocompatible
EOTXT

read -r -d '' TEXT_GitCfg <<- EOTXT
	[core]
	    editor = vim
	[push]
	    default = simple
	[pull]
	    rebase = false
EOTXT

read -r -d '' TEXT_FirefoxCfg <<- EOTXT
	user_pref("browser.startup.homepage", "$FirefoxHomePage");
	user_pref("datareporting.healthreport.uploadEnabled", false);
	user_pref("signon.rememberSignons", $FirefoxRememberLogins);
EOTXT

read -r -d '' TEXT_TerminatorCfg <<- EOTXT
	[global_config]
	[keybindings]
	[profiles]
	    [[default]]
	        background_darkness = 0.92
	        scrollback_lines = $TerminatorScrollbackLines
	        scroll_on_output = False
	        background_type = transparent
	        background_image = None
	        use_system_font = False
	        font = Monospace 12
	[layouts]
	    [[default]]
	        [[[child1]]]
	            type = Terminal
	            parent = window0
	        [[[window0]]]
	            type = Window
	            parent = ""
	            size = $TerminatorWindowSize
	[plugins]
EOTXT


##### Cinnamon Configs ######

read -r -d '' TEXT_LocalBookmarks <<- EOTXT
	file://$userHomeDir/Documents
	file://$userHomeDir/Downloads
EOTXT

FMShowHiddenFilesVal="true"
if [ $FileManagerShowHidden == $FileManagerShowHiddenNo ]; then
    FMShowHiddenFilesVal="false"
fi
read -r -d '' TEXT_NemoGSettingsConfig <<- EOTXT
	[org.nemo.preferences]
	default-folder-viewer='$FileManagerViewMode-view'
	show-hidden-files=$FMShowHiddenFilesVal
	show-image-thumbnails='never'
	show-full-path-titles=true
	quick-renames-with-pause-in-between=true
	show-advanced-permissions=true
	show-home-icon-toolbar=true
	show-new-folder-icon-toolbar=true
	show-search-icon-toolbar=true
	show-compact-view-icon-toolbar=false
	show-icon-view-icon-toolbar=false
	show-list-view-icon-toolbar=false
	show-open-in-terminal-toolbar=true
	date-format='iso'

	[org.nemo.list-view]
	default-visible-columns=['name', 'size', 'type', 'date_modified', 'owner', 'group', 'permissions']
EOTXT

read -r -d '' TEXT_CinnamonTermGSettingsConfig <<- EOTXT
	[org.cinnamon.desktop.applications.terminal]
	exec='/usr/bin/terminator'
EOTXT
read -r -d '' TEXT_TermGSettingsConfigGnome <<- EOTXT
	[org.gnome.desktop.default-applications.terminal]
	exec='/usr/bin/terminator'
EOTXT
read -r -d '' TEXT_TermGSettingsConfigCinnamon <<- EOTXT
	[org.cinnamon.desktop.default-applications.terminal]
	exec='/usr/bin/terminator'
EOTXT

read -r -d '' TEXT_CinnamonDesktopIfGSettingsConfig <<- EOTXT
	[org.cinnamon.desktop.wm.preferences]
	theme='Mint-Y-Dark'
	num-workspaces=$WorkspacesNumberOf
	mouse-button-modifier='<Super>'

	[org.cinnamon.theme]
	name='Mint-Y-Dark'

	[org.cinnamon.desktop.interface]
	icon-theme='Mint-Y-Dark'
	gtk-theme='Mint-Y-Dark'
	clock-show-date=true
	first-day-of-week=1
	scaling-factor=uint32 0
EOTXT

read -r -d '' TEXT_CinnamonSoundsGSettingsConfig <<- EOTXT
	[org.cinnamon.sounds]
	login-enabled=false
	logout-enabled=false
	plug-enabled=false
	unplug-enabled=false
	tile-enabled=false
	switch-enabled=false
EOTXT

read -r -d '' TEXT_CinnamonMouseGSettingsConfig <<- EOTXT
	[org.cinnamon.settings-daemon.peripherals.touchpad]
	natural-scroll=false
	disable-while-typing=true
	horizontal-scrolling=true
	clickpad-click=2
	custom-acceleration=true
	motion-acceleration=8.0
	motion-threshold=1

	[org.cinnamon.settings-daemon.peripherals.mouse]
	natural-scroll=false
EOTXT

read -r -d '' TEXT_CinnamonPowerGSettingsConfig <<- EOTXT
	[org.cinnamon.settings-daemon.plugins.power]
	lock-on-suspend=true\n
	critical-battery-action='nothing'
	sleep-inactive-ac-timeout=0
	sleep-inactive-battery-timeout=0
	sleep-display-battery=600
	sleep-display-ac=600
	button-power='interactive'
	lid-close-ac-action='nothing'
	lid-close-battery-action='nothing'
	idle-dim-time=90
	idle-brightness=10
EOTXT

read -r -d '' TEXT_CinnamonDesktopGSettingsConfig <<- EOTXT
	[org.nemo.desktop]
	trash-icon-visible=true

	[org.cinnamon.desktop.privacy]
	remember-recent-files=$CinnamonRememberRecentFiles
	recent-files-max-age=30

	[org.cinnamon.desktop.background]
	picture-options='none'
	primary-color='$DesktopBackgroundColor'

	[org/cinnamon/desktop/session]
	idle-delay=uint32 300

	[org.cinnamon]
	startup-animation=false
	desklet-decorations=0
	enabled-desklets=['clock@cinnamon.org:0:170:10']
	panels-height=['1:$CinnamonPanelHeight']
	panels-autohide=['1:$CinnamonPanelAutohide']

	[org.cinnamon.desktop.screensaver]
	use-custom-format=true
	date-format='%a %d %b %Y'
	lock-enabled=true
	lock-delay=uint32 2

	[org.cinnamon.desktop.a11y.keyboard]
	togglekeys-enable-osd=true
EOTXT

read -r -d '' TEXT_XedGSettingsConfig <<- EOTXT
	[org.x.editor.preferences.editor]
	display-right-margin=true
	right-margin-position=uint32 80
	tabs-size=uint32 4
	display-line-numbers=true
	insert-spaces=true
	auto-indent=true
	bracket-matching=true
	wrap-mode='none'
	highlight-current-line=true
	scheme='oblivion'

	[org.x.editor.preferences.ui]
	enable-tab-scrolling=false
	statusbar-visible=true
	minimap-visible=true
EOTXT


##### Ubuntu Configs ######

read -r -d '' TEXT_UbuntuPowerGSettingsConfig <<- EOTXT
	[org.gnome.settings-daemon.plugins.power]
	sleep-inactive-battery-timeout=1800
	sleep-inactive-battery-type='nothing'
	sleep-inactive-ac-timeout=3600
	sleep-inactive-ac-type='nothing'
EOTXT

read -r -d '' TEXT_UbuntuNightLightGSettingsConfig <<- EOTXT
	[org.gnome.settings-daemon.plugins.color]
	night-light-enabled=true
	night-light-schedule-automatic=false
	night-light-schedule-from=21.0
	night-light-schedule-to=8.0
EOTXT

read -r -d '' TEXT_UbuntuDesktopGSettingsConfig <<- EOTXT
	[org.gnome.desktop.background]
	picture-uri=''
	primary-color='$DesktopBackgroundColor'

	[org.gnome.desktop.interface]
	gtk-theme='Yaru-dark'
	enable-animations=false

	[org.gnome.shell.extensions.ding]
	icon-size='small'

	[org.gnome.shell.extensions.dash-to-dock]
	dash-max-icon-size=32
	dock-fixed=false

	[org.gnome.desktop.privacy]
	recent-files-max-age=30
	remember-recent-files=true

	[org.gnome.desktop.screensaver]
	lock-delay=uint32 0

	[org.gnome.desktop.session]
	idle-delay=uint32 300

	[org.gnome.settings-daemon.plugins.media-keys]
	home=['<Primary><Alt>h']

	[org.gnome.shell]
	app-picker-view=uint32 1
	favorite-apps=[]
EOTXT
# favorite-apps is later over-written with list of launchers.

read -r -d '' TEXT_nautilusGSettingsConfig <<- EOTXT
	[org.gnome.nautilus.preferences]
	default-folder-viewer='list-view'
	show-image-thumbnails='never'
	executable-text-activation='display'

	[org.gnome.nautilus.list-view]
	default-visible-columns=['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified']
	default-column-order=['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified', 'date_modified_with_time', 'date_accessed', 'recency']
	default-zoom-level='small'

	[org.gtk.settings.file-chooser]
	sort-directories-first=true
	show-hidden=$FMShowHiddenFilesVal
EOTXT

read -r -d '' TEXT_geditGSettingsConfig <<- EOTXT
	[org.gnome.gedit.preferences.editor]
	tabs-size=uint32 4
	auto-indent=true
	insert-spaces=true
	display-line-numbers=true
	bracket-matching=true
	highlight-current-line=true
	display-right-margin=true
	right-margin-position=uint32 80
	wrap-mode='word'
	wrap-last-split-mode='word'
	scheme='oblivion'
	background-pattern='none'
EOTXT


##### Application Configs ######

read -r -d '' TEXT_VlcRC <<- EOTXT
	[qt4]
	qt-privacy-ask=0
	metadata-network-access=0
	[core]
	play-and-exit=1
	one-instance-when-started-from-file=0
EOTXT

read -r -d '' TEXT_MozillaCrashReporter <<- EOTXT
	[Crash Reporter]
	SubmitReport=0
EOTXT

read -r -d '' TEXT_AtomEditorConfig <<- EOTXT
	"*":
	  core:
	    telemetryConsent: "no"
	  editor:
	    invisibles:
	      eol: "¶"
	    showInvisibles: true
	    showIndentGuide: true
	    tabLength: 4
	    tabType: "soft"
	    scrollPastEnd: true
	  welcome:
	    showOnStartup: false
EOTXT

read -r -d '' TEXT_VSCodeConfig <<- EOTXT
	{
	  "editor.fontFamily": "'Ubuntu Mono'",
	  "editor.fontSize": 14,
	  "editor.lineHeight": 21,
	  "editor.renderWhitespace": "all",
	  "editor.rulers": [80, 100],
	  "editor.quickSuggestions": {
	    "other": true,
	    "comments": true,
	    "strings": true
	  },
	  "workbench.startupEditor": "none",
	  "telemetry.enableTelemetry": false,
	  "files.trimTrailingWhitespace": true,
	  "diffEditor.ignoreTrimWhitespace": false,
	  "editor.detectIndentation": false,
	}
EOTXT


##### Bash aliases ######

read -r -d '' TEXT_BashToolAliases <<- "EOTXT"
	alias ll='ls --time-style="long-iso" -alF'
	alias hiss='history | grep'
	alias trimws='find . -type f ! -path "*/.venv/*" ! -path "*/.git/*" ! -path "*/venv/*" | xargs -I fl bash -c '"'"'FILE="fl"; echo ">>>>>>>> $FILE"; sed -i -r "s/\s+$//;" "$FILE"; [[ $( tail -c 1 "$FILE" ) != "" ]] && echo >> "$FILE"'"'"
EOTXT

read -r -d '' TEXT_BashGitAliases <<- "EOTXT"
	function ____gititer____()
	{
	    for d in ./*/; do
	        pushd $d > /dev/null 2>&1
	        echo -e "\033[30;1;106m"
	        pwd
	        echo -e "\033[0m"
	        if [ ! -z $3 ]; then
	            git "$1" "$2" "$3"
	        elif [ ! -z $2 ]; then
	            git "$1" "$2"
	        else
	            git "$1"
	        fi
	        echo
	        popd > /dev/null 2>&1
	    done
	}
	alias gitstates='____gititer____ status'
	alias gitpushes='____gititer____ push'
	alias gitpulls='____gititer____ pull'
	alias gitdiffs='____gititer____ diff'
	alias gitcheckouts='____gititer____ checkout'
	alias gitadds='____gititer____ add'
	alias gitlogs='____gititer____ log'
	alias gitmerges='____gititer____ merge'
	alias gitcommits='____gititer2____ commit'
EOTXT

read -r -d '' TEXT_BashPythonToolAliases <<- "EOTXT"
	function ____check_py_requirements____() {
	    reqsFile="$1"
	    if [ ! -f "$reqsFile" ]; then
	        reqsFile="requirements.txt";
	    fi
	    cat "$reqsFile" | while read -r line; do
	        test "$line" == "" && continue
	        pckg=$( echo $line | awk -F'[=~]=' '{ print $1 }' )
	        vers=$( echo $line | awk -F'[=~]=' '{ print $2 }' )
	        test "$pckg" == "" && continue
	        test "$vers" == "" && continue
	        echo -n "$pckg : $vers"
	        ver_found=$( yolk -V $pckg | awk -v envvar="$pckg" '{ if ($1==envvar) { print $2 } }' )
	        if [ "$ver_found" == "" ]; then
	            echo -e " - \033[1;31mNOT FOUND (try https://pypi.org/search/?q=$pckg)\033[0m"
	        else
	            echo -n " - Latest version: $ver_found"
	            test "$ver_found" != "$vers" && echo -e " - \033[1;33mNOT EQUAL\033[0m" || echo ""
	        fi
	    done
	}
	alias cpr='____check_py_requirements____'

	function ____cleanpydir____() {
	    rm -rf testresults.xml .coverage .cache .pytest_cache htmlcov .hypothesis
	    find . -name "__pycache__" -type d \
	        -not -path "*/.venv/*" \
	        -not -path "*/.git/*" \
	        -not -path "*/venv/*" | xargs rm -rf
	    # find . -type f -name "*.pyc" -delete
	    if [[ $1 == "f" ]]; then
	        rm -rf .venv;
	    fi
	}
	alias cleanpyd='____cleanpydir____'
EOTXT


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
{   item="$1"
    # Check installation was successful
    dpkg -l "$item" 2> /dev/null | grep -E '^ii' > /dev/null 2>&1
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
    file="$2"
    if [ ! -f "$file" ]; then
        return 9
    fi
    FOUND=0
    # Paths may contain $ sign to reference other variables, therefore, ensure $ signs are escaped.
    searchStrEscDollar=$( echo "$newPath" | sed -r 's|\$|\\$|g;' )
    grep -E "^(export)?\s*PATH=.*$searchStrEscDollar" "$file" > /dev/null 2>&1
    if [ $? != $FOUND ]; then
        grep -E '^(export)?\s*PATH=.*' "$file" > /dev/null 2>&1
        if [ $? == $FOUND ]; then
            sed -r -i 's|^((export)?\s*PATH=.*)$|\1:'"$newPath"':|;' "$file" > /dev/null 2>&1
        else
            echo "PATH=\$PATH:$newPath" >> "$file"
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

function removeFromPath()
{   removeText="$1"
    file="$2"
    if [ ! -f "$file" ]; then
        return 9
    fi
    if [ -z "$removeText" ]; then
        return 8
    fi
    searchStrEscd="$( echo "$removeText" | sed -r 's|([/$])|\\\1|g;' )"
    sed -i -r '/^(export)?\s*PATH=.*'"$searchStrEscd"':?/ '\
'{s|([^[:alnum:]\/\$\-\._])'"$searchStrEscd"'[^[:alnum:]\/\$\-\._]:?|\1|g;'\
' s|([^[:alnum:]\/\$\-\._])'"$searchStrEscd"':?$|\1|g;};' "$file"
}

function removeFromPathGlobally()
{   PRINTLOG "Updating <$GlobalProfileFile>, removing <$1> from PATH."
    removeFromPath $1 $GlobalProfileFile
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
        pips=()
        which pip > /dev/null && pips+=("pip")
        which pip3 > /dev/null && pips+=("pip3")
        for pipv in "${pips[@]}"
        do
            for item in "${listOfPips[@]}"
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
#     $2 : Name of compressed package that will be downloaded.
#     $3 : Location to which the package should be unpacked.
#     $4 : Optional.  Path, which if exists, means nothing needs to be done.
# Returns:
#     0 Successfully downloaded and unpacked.
#     1 The path $4 already exists.
#     2 One of the required parameters was not specified.
#     3 There was a problem downloading archive.
#     4 There was a problem decompressing the archive.
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
    tempDownload="$TempFolderForDownloads/$2"
    wget "$1" -O "$tempDownload"
    wgetStatus=$?
    if [ $wgetStatus != 0 ]; then
        PRINT_ERROR "Download error <$wgetStatus>."
        return 3
    fi
    decompStatus=0
    if [[ "$2" == *.zip ]]; then
        PRINTLOG "Unzipping file <$tempDownload> to <$3>."
        unzip "$tempDownload" -d "$3"
        decompStatus=$?
    else
        PRINTLOG "Untarball file <$tempDownload> to <$3>."
        tar -C "$3" -xf "$tempDownload"
        decompStatus=$?
    fi
    rm "$tempDownload"
    if [ $decompStatus != 0 ]; then
        PRINT_ERROR "Decompress error <$decompStatus>."
        return 4
    fi
    return $decompStatus
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

# Update user descriptor string with new values.  Descriptor string is expected
# to be of the format:
#     <FullName>;<email>;<sshpvtkeyfile>;<maingroup>
# Modified descriptor will be printed as output.
# Parameters:
#     $1 : User descriptor string.
#     $2 : New user full name.
#     $3 : New group name.
#     $4 : New user email.
# Returns:
#     0 Successfully modified descriptor.
function modifyUserDescriptor()
{   userDesc="$1"
    userFullName="$2"
    userGroup="$3"
    userEmail="$4"
    if [ ! -z "$userFullName" ]; then
        userDesc=$( sed -r 's/[^;]*(;.*)/'"$userFullName"'\1/' <<< "$userDesc" )
    fi
    if [ ! -z "$userGroup" ]; then
        userDesc=$( sed -r 's/(.*;)[^;]*/\1'"$userGroup"'/' <<< "$userDesc" )
    fi
    if [ ! -z "$userEmail" ]; then
        userDesc=$( sed -r 's/([^;]*;)[^;]*(.*)/\1'"$userEmail"'\2/' <<< "$userDesc" )
    fi
    echo "$userDesc"
}

# Add new user.
# Parameters:
#     $1 : New username.
#     $2 : Main group.
#     $3 : Full name.
# Returns:
#     0 Successfully added user.
#     1 New username MUST be specified.
#     2 Username already exists.
#     3 Group MUST be specified.
#     8 Unknown error, group could not be added.
#     9 Unknown error, user could not be added.
function addNewUser()
{   test -z $1   && return 1
    id -u $1 > /dev/null 2>&1
    test $? == 0 && return 2
    test -z "$2"   && return 3
    adduser -gecos "$3,,," --disabled-password $1 > /dev/null 2>&1
    test $? == 0 || return 9
    grep -E "^$2:" /etc/group > /dev/null 2>&1
    test $? == 0 || groupadd "$2" > /dev/null 2>&1
    test $? == 0 || return 8
    usermod -g $2 $1 > /dev/null
}

# Update an existing user.
# Parameters:
#     $1 : Username.
#     $2 : Main group.
#     $3 : Full name.
# Returns:
#     0 Successfully modified user.
#     1 Username MUST be specified.
#     2 Username MUST exists.
#     8 Unknown error, group could not be added.
function updateExistingUser()
{   test -z $1   && return 1
    id -u $1 > /dev/null 2>&1
    test $? == 0 || return 2
    if [ ! -z "$2" ]; then
        grep -E "^$2:" /etc/group > /dev/null 2>&1
        test $? == 0 || groupadd "$2" > /dev/null 2>&1
        test $? == 0 || return 8
        usermod -g $2 $1 > /dev/null 2>&1
    fi
    usermod -c "$3,,," $1 > /dev/null 2>&1
    test $? == 0 || return 9
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

InstallRuby=false
InstallDocker=false
InstallGitlabRunner=false
InstallRabbitMq=false
InstallTorDaemon=false
InstallFlutterSDK=false
isFlutterInstalled=false

RequestOptions=$((2#0000))
TestMode=0

opt_userfullname=""
opt_usergroup=""
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
        --ruby ) InstallRuby=true
             ;;
        --rubyv ) shift
             InstallRuby=true
             RubyVersion="$1"
             ;;
        --docker ) InstallDocker=true
             ;;
        --gitlabr ) InstallGitlabRunner=true;
             ;;
        --rabbit ) InstallRabbitMq=true
             ;;
        --tor ) InstallTorDaemon=true
             ;;
        --flutter ) InstallFlutterSDK=true
             ;;
        -un ) shift
             opt_userfullname="$1"
             ;;
        -ug ) shift
             opt_usergroup="$1"
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

PRINTLOG "Current user parameters:"
PRINTLOG "    Username <$userOfThisScript>"
PRINTLOG "    Group    <$groupOfUserOfThisScript>"
PRINTLOG "    Home     <$userHomeDir>"

currentUserDescFromArray=$( modifyUserDescriptor "${UserInfo[$currentUserNameKey]}" "$opt_userfullname" "$opt_usergroup" "$opt_useremail" )

PRINTLOG "    UserDesc <$currentUserDescFromArray>"
UserInfo[$currentUserNameKey]="$currentUserDescFromArray"


checkDebPkgInstalled "ubuntu-server"
ubServerEnvironment=$?
if [ $ubServerEnvironment == 0 ]; then
    PRINTLOG "******************** Ubuntu SERVER"
    INSTALL_COMP_LIST=( "${INSTALL_COMP_LIST[@]}" "${INSTALL_COMP_LIST_SERVER[@]}" )
    INSTAL_PIP2n3_MAP=( "${INSTAL_PIP2n3_MAP[@]}" "${INSTAL_PIP2n3_MAP_SERVER[@]}" )
else
    PRINTLOG "******************** Ubuntu DESKTOP"
    INSTALL_COMP_LIST=( "${INSTALL_COMP_LIST[@]}" "${INSTALL_COMP_LIST_DESKTOP[@]}" )
    INSTAL_PIP2n3_MAP=( "${INSTAL_PIP2n3_MAP[@]}" "${INSTAL_PIP2n3_MAP_DESKTOP[@]}" )
    ADD_PPA_REPO_LIST=( "${ADD_PPA_REPO_LIST[@]}" "${ADD_PPA_REPO_LIST_DESKTOP[@]}" )
fi

if [ $TestMode == 1 ]; then
    PRINTLOG "TEST MODE"
    PRINTLOG "=====Request Options========="
    printBinaryVal $RequestOptions
    PRINTLOG "=====Environment Options====="
    PRINTLOG "Ruby Install      : $InstallRuby, RubyVersion: <$RubyVersion>"
    PRINTLOG "Docker Install    : $InstallDocker"
    PRINTLOG "RabbitMq Install  : $InstallRabbitMq"
    PRINTLOG "Tor Daemon Install: $InstallTorDaemon"
    PRINTLOG "FlutterSDK Install: $InstallFlutterSDK"
    exit
fi


########################################
##### Build up list of components to be
##### removed and added based on
##### environment requested.
########################################

if [ "$InstallRuby" == true ]; then
    INSTALL_COMP_LIST+=(
                        "gnupg"
                       )
fi

if [ "$InstallDocker" == true ]; then
    ADD_APT_KEYS_LIST+=(
                        "https://download.docker.com/linux/ubuntu/gpg"
                       )
    # $(lsb_release -cs) should give the codename, but on linuxmint, it will give the mint codename (e.g. tessa) and not the Ubuntu one.
    DebSources["deb [arch=amd64] https://download.docker.com/linux/ubuntu $UbuntuReleaseName stable"]="/etc/apt/sources.list.d/docker.list"
    P_UPDATE_INS_LIST+=(
                        # "ca-certificates" # Should already be installed
                        # "curl" # Should already be installed
                        "apt-transport-https"
                        "gnupg-agent"
                        "software-properties-common"
                       )
    INSTALL_COMP_LIST+=(
                        "docker-ce"
                        "docker-ce-cli"
                        "containerd.io"
                       )
fi

if [ "$InstallRabbitMq" == true ]; then
    ADD_APT_KEYS_LIST+=(
                        "https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc"
                        "https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc"
                       )
    DebSources["deb https://packages.erlang-solutions.com/ubuntu $UbuntuReleaseName contrib"]="/etc/apt/sources.list.d/erlang.list"
    DebSources["deb https://dl.bintray.com/rabbitmq/debian $UbuntuReleaseName main"]="/etc/apt/sources.list.d/bintray.rabbitmq.list"

    INSTALL_COMP_LIST+=(
                        "rabbitmq-server"
                       )
fi

if [ "$InstallTorDaemon" == true ]; then
    ADD_APT_KEYS_LIST+=(
                        "https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc"
                       )

    DebSources["deb https://deb.torproject.org/torproject.org $UbuntuReleaseName main"]="/etc/apt/sources.list.d/tord.list"
    DebSources["deb-src https://deb.torproject.org/torproject.org $UbuntuReleaseName main"]="/etc/apt/sources.list.d/tord.list"

    INSTALL_COMP_LIST+=(
                        "tor"
                        "deb.torproject.org-keyring"
                       )
fi

if [ "$InstallFlutterSDK" == true ]; then
    INSTALL_COMP_LIST+=(
                        "lib32stdc++6" # Required for flutter sdk.
                        "qemu-kvm" # Required for Android emulator.
                       )
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

PRINTLOG "Pre-APT-Update Installs:"
installAptPackages P_UPDATE_INS_LIST[@]

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

if [ "$InstallDocker" == true ]; then
    dc_targetbin="/usr/local/bin/docker-compose"
    test ! -z $DockerComposeUrl \
        && wget $DockerComposeUrl -O "$dc_targetbin" \
        && chmod +x "$dc_targetbin"

    if [ "$InstallGitlabRunner" == true ]; then
        GitLabRunnerPath="/usr/local/bin/gitlab-runner"
        wget https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 -O "$GitLabRunnerPath"
        chmod a+x "$GitLabRunnerPath"
        useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash
        gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
    fi
fi

if [ "$InstallRuby" == true ]; then
    PRINTLOG "Downloading RVM verification keys."
    gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    PRINTLOG "Install RVM."
    rubyVersionOption=""
    if [ ! -z "$RubyVersion" ]; then
        PRINTLOG "... with Ruby <$RubyVersion>."
        rubyVersionOption="--ruby=$RubyVersion"
    fi
    curl -sSL https://get.rvm.io | bash -s stable $rubyVersionOption
fi

if [ $ubServerEnvironment != 0 ]; then
    fossilBin="fossil"
    wgetAndUnpack "$FossilScmUrl" "$FossilScmPkg" "$FossilInstallDir" "$FossilInstallDir/$fossilBin" \
        && updatePathGlobally "$FossilInstallDir"

    nodeJsDir="$NodeInstallDir/$NodeJsVer"
    wgetAndUnpack "$NodeJsUrl" "$NodeJsPkg" "$NodeInstallDir" "$nodeJsDir" \
        && updatePathGlobally "$nodeJsDir/bin"
    chgrp -R $DevGroupName $nodeJsDir
    # Give developer group permissions to write, so we can npm install globally.
    chmod -R g+rw $nodeJsDir/lib/node_modules
    chmod -R g+rw $nodeJsDir/bin

    PRINTLOG "Installing debian packages from web:"
    for key in "${!DebPackages[@]}"
    do
        installDebPackageFromHttp ${DebPackages["$key"]} $key
    done

    wgetAndUnpack "$TerraformUrl" "$TerraformPkg" "$TerraformInstallDir" "$TerraformInstallDir" \
        && updatePathGlobally "$TerraformInstallDir"

    [ ! -z "$TerragruntUrl" ] && [ ! -e "$TerragruntInstallDir/terragrunt" ] \
        && mkdir -p "$TerragruntInstallDir" \
        && wget -O "$TerragruntInstallDir/terragrunt" $TerragruntUrl \
        && chmod +rx "$TerragruntInstallDir/terragrunt" \
        && updatePathGlobally "$TerragruntInstallDir"

    wgetAndUnpack "$ConfiglintUrl" "$ConfiglintPkg" "$ConfiglintInstallDir" "$ConfiglintInstallDir" \
        && updatePathGlobally "$ConfiglintInstallDir"

    awscliUnpackTo="$UnpackDirForIncompletePckgs"
    awscliDir="$awscliUnpackTo/aws"
    wgetAndUnpack "$AwsCliUrl" "$AwsCliPkg" "$awscliUnpackTo" "$awscliDir" \
        && chown -R $userOfThisScript:$groupOfUserOfThisScript "$awscliDir"

    wgetAndUnpack "$GoLangUrl" "$GoLangPkg" "$UsrLocalDir" "$GoPath"
    if [ $? == 0 ]; then
        updatePathGlobally "$GoPath/bin"

        # TODO user workspace should be seperated when all configuration is seperated.
        PRINTLOG "Creating GoLang workspace for <$userOfThisScript>, which will be used to download any dependencies when building projects, such as modules from github."
        mkdir -p $GoWorkspacePath
        chown -R $userOfThisScript:$groupOfUserOfThisScript $GoWorkspacePath
        PRINTLOG "    Go workspace <$GoWorkspacePath>"
        grep "GOPATH=.*$GoWorkspacePathLit" $UserProfileFile > /dev/null 2>&1
        if [ $? == 0 ]; then
            PRINTLOG "GoLang workspace path already set in user's GOPATH variable."
        else
            echo "export GOPATH=$GoWorkspacePathLit" >> $UserProfileFile
        fi
    fi

    if [ "$InstallFlutterSDK" == true ]; then
        wgetAndUnpack "$FlutterUrl" "$FlutterPkg" "$FlutterInstallDir" "$FlutterInstallDir" \
            && updatePathGlobally "$FlutterInstallDir/flutter/bin" \
            && source $GlobalProfileFile \
            && isFlutterInstalled=true
        wgetAndUnpack "$AndroidUrl" "$AndroidPkg" "$AndroidInstallDir" "$AndroidInstallDir"
    fi

    VeraCryptBin="/usr/bin/veracrypt"
    veraCryptUnpackTo="$UnpackDirForIncompletePckgs/veracrypt"
    wgetAndUnpack "$VeraCryptUrl" "$VeraCryptPkg" "$veraCryptUnpackTo" "$VeraCryptBin" \
        && chown -R $userOfThisScript:$groupOfUserOfThisScript "$veraCryptUnpackTo"
    # Looks like veracrypt cannot be auto installed, as user has to accept license conditions.

    telegramUnpackTo="$UnpackDirForIncompletePckgs"
    telegramBin="$telegramUnpackTo/Telegram/Telegram"
    wgetAndUnpack "$TelegramPackageHttpURL" "$TelegramPackage" "$telegramUnpackTo" "$telegramBin" \
        && chown -R $userOfThisScript:$groupOfUserOfThisScript "$telegramUnpackTo"

    PRINTLOG "Installing fonts."
    doBuildFontCache=false
    for key in "${!Fonts[@]}"
    do
        fontFolder="$allFontsFolder/$key"
        downloadUrl=${Fonts["$key"]}
        PRINTLOG "Download and setup font [$key]: [$downloadUrl] -> [$fontFolder]"
        wgetAndUnpack "$downloadUrl" "$key.zip" "$fontFolder" "$fontFolder" \
            && doBuildFontCache=true
    done
    if [ "$doBuildFontCache" == true ]; then
        chmod -R --reference=/usr/share/fonts/opentype $allFontsFolder
        fc-cache -fv
    fi
fi


########################################
##### Writing configuration files.
########################################

checkDebPkgInstalled "vim"
if [ $? == 0 ]; then
    PRINTLOG "WRITING VIMRC: [$VimRcFile]"
    echo -e "$TEXT_VimRC" > $VimRcFile
fi

checkDebPkgInstalled "git"
gitInstalled=$?
if [ $gitInstalled == 0 ]; then
    addSysGitConfig "$GitSysConfigFile" "$TEXT_GitCfg"
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
'/alias git[[:alpha:]]+=/d;'\
'/____gititer/d;'\
 $BashrcForAll
# '/export PYTHONPATH=/d;'\

echo -e "\
$TEXT_BashToolAliases
\n\
$TEXT_BashGitAliases
\n\
$TEXT_BashPythonToolAliases\n" \
 >> $BashrcForAll
# export PYTHONPATH=.\n"\

usersBashrc="$userHomeDir/.bashrc"
cp $BashrcForAll $usersBashrc
chown $userOfThisScript:$groupOfUserOfThisScript $usersBashrc


########################################
##### Swappiness
########################################

swappinessOriginal=`cat /proc/sys/vm/swappiness`
PRINTLOG "Swappiness    : old <$swappinessOriginal>, new <$SwappinessVal>."
PRINTLOG "iNotifyWatches: <$NumiNotifyWatches>."

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

    [ "$isFlutterInstalled" = true ] \
        && installVSCodeExt "dart-code.dart-code" \
        && installVSCodeExt "dart-code.flutter"
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

RunGlibCompileSchemas=false
GlibScemasDir="/usr/share/glib-2.0/schemas"
GlibPriorityNum="zzz" # This should be a number, but distros are not using priority numbers, so we have to try being higher priority by using lexicographical ordering.

if [ $nemoinstalled == 0 ]; then
    PRINTLOG "Configuring Nemo file manager."
    NemoGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_nemo.gschema.override"
    echo -e "$TEXT_NemoGSettingsConfig" >> $NemoGSettingsCfg
    RunGlibCompileSchemas=true
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

    notifCfg="/usr/share/cinnamon/applets/notifications@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$notifCfg>"
    sed -i.bak -r '/\"ignoreTransientNotifications\"/,/^\s*}/{s|(\"default\"\s*:\s*)true(,?)|\1false\2|;};' $notifCfg

    powerCfg="/usr/share/cinnamon/applets/power@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$powerCfg>"
    sed -i.bak -r '/\"labelinfo\"/,/^[[:space:]]*\"default\"/{s|(\"default\"\s*:\s*\").*?(\",?)|\1percentage_time\2|;};'\
'/\"showmulti\"/,/^\s*}/{s|(\"default\"\s*:\s*)false(,?)|\1true\2|;};' $powerCfg

    showDTCfg="/usr/share/cinnamon/applets/show-desktop@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$showDTCfg>"
    sed -i.bak -r '/\"peek-at-desktop\"/,/^\s*}/{s|(\"default\"\s*:\s*)false(,?)|\1true\2|;};'\
'/\"peek-blur\"/,/^\s*}/{s|(\"default\"\s*:\s*)false(,?)|\1true\2|;};' $showDTCfg

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
    rm -rf "$userHomeDir/.cinnamon/configs/notifications@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/power@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/show-desktop@cinnamon.org"
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

    RunGlibCompileSchemas=true
fi

if [ $xedinstalled == 0 ]; then
    PRINTLOG "Configuring Xed."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_xed.gschema.override"
    echo -e "$TEXT_XedGSettingsConfig" >> $GSettingsCfg
    RunGlibCompileSchemas=true
fi


checkDebPkgInstalled "nautilus" # Ubuntu file manager.
nautilusPkgInstalled=$?
checkDebPkgInstalled "ubuntu-desktop" # Ubuntu desktop.
ubuntuInstalled=$?
checkDebPkgInstalled "gedit" # Ubuntu text editor.
geditPkgInstalled=$?

if [ $geditPkgInstalled == 0 ]; then
    PRINTLOG "Configuring gedit text editor."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_gedit.gschema.override"
    echo -e "$TEXT_geditGSettingsConfig" >> $GSettingsCfg
    RunGlibCompileSchemas=true
fi

if [ $nautilusPkgInstalled == 0 ]; then
    PRINTLOG "Configuring nautilus file manager."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_nautilus.gschema.override"
    echo -e "$TEXT_nautilusGSettingsConfig" >> $GSettingsCfg
    RunGlibCompileSchemas=true
fi

if [ $ubuntuInstalled == 0 ]; then
    launchersListStr=""
    for applauncher in "${LIST_OF_LAUNCHERS[@]}"
    do
        # Create comma separated list.
        if [ "$applauncher" == "filemanager" ]; then
            launchersListStr+="'org.gnome.Nautilus.desktop', " # Ubuntu's filemanager.
        else
            launchersListStr+="'$applauncher.desktop', "
        fi
    done
    # Remove the two last chars ', ' (to make sure last item in list is formatted correctly).
    launchersListStr="${launchersListStr::-2}"

    PRINTLOG "Updating favorite apps list to <$launchersListStr>"
    # Replace all items in the panel "default" list.
    TEXT_UbuntuDesktopGSettingsConfigWithLaunchers=$(sed -r 's|(favorite\-apps=\[).*(\])|\1'"$launchersListStr"'\2|;' <<< $TEXT_UbuntuDesktopGSettingsConfig)

    PRINTLOG "Configuring Ubuntu desktop."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_ubuntudesktop.gschema.override"
    echo -e "$TEXT_UbuntuDesktopGSettingsConfigWithLaunchers" >> $GSettingsCfg

    PRINTLOG "Configuring Ubuntu night light."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_ubuntunightlight.gschema.override"
    echo -e "$TEXT_UbuntuNightLightGSettingsConfig" >> $GSettingsCfg

    PRINTLOG "Configuring Ubuntu power."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_ubuntupower.gschema.override"
    echo -e "$TEXT_UbuntuPowerGSettingsConfig" >> $GSettingsCfg

    RunGlibCompileSchemas=true

    PRINTLOG "Configuring Gnome to ignore lid close."
    sed -i -r 's/#?(HandleLidSwitch\w*)=.*/\1=ignore/;' /etc/systemd/logind.conf

    rm -rf "$userHomeDir/.config/dconf"
fi


if [ "$RunGlibCompileSchemas" == true ]; then
    PRINTLOG "GSettings compiling schemas."
    glib-compile-schemas "$GlibScemasDir/"
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
        sshkeyfile="${userInfoArray[2]}" # TODO - do something with sshkeyfile
        maingroup="${userInfoArray[3]}"
        test -z $maingroup && maingroup=$usern
        isUserConfigured=false
        if [ "$usern" == "$currentUserNameKey" ]; then
            usern=$userOfThisScript
            PRINTLOG "Updating current user : name <$fullname>, email <$email>, maingrp <$maingroup>, sshk <$sshkeyfile>"
            updateExistingUser "$usern" "$maingroup" "$fullname"
            isUserConfigured=true
            updateUserReturn=$?
            if [ $updateUserReturn == 0 ]; then
                isUserConfigured=true
            else
                PRINT_ERROR "Update user failed <$updateUserReturn>"
            fi
        else
            PRINTLOG "Adding new user : name <$fullname>, email <$email>, maingrp <$maingroup>, sshk <$sshkeyfile>"
            addNewUser "$usern" "$maingroup" "$fullname"
            addUserReturn=$?
            if [ $addUserReturn == 0 ]; then
                isUserConfigured=true
            else
                PRINT_ERROR "Adding new user failed <$addUserReturn>"
            fi
        fi

        [ $gitInstalled == 0 ] && [ "$isUserConfigured" == true ] \
            && addUserGitConfig "$usern" "$maingroup" "$fullname" "$email"

        [ "$InstallDocker" = true ] \
            && usermod -a -G docker $usern # Required to allow users ability to use docker service.

        [ "$isFlutterInstalled" = true ] \
            && usermod -a -G kvm $usern # Required to allow users ability to use kvm for Android emulation.

        [ "$InstallRuby" == true ] \
            && usermod -a -G rvm $usern
    done
fi


########################################
##### Installations complete, just show
##### message for user to reboot system.
##### Some settings, e.g. PCManFM, will
##### not apply without system restart.
########################################

PRINTLOG "******************************"
PRINTLOG "Manual steps to complete system setup (after reboot):"
PRINTLOG ""
PRINTLOG "Additions to be applied:"
PRINTLOG "  *  Firefox addons: AdBlock, noScript, ..."
PRINTLOG "  *  VSCode Extensions: Code Spell Checker ..."
PRINTLOG "Installations to be completed manually:"
PRINTLOG "  *  Veracrypt"
PRINTLOG "  *  Dropbox"
PRINTLOG "  *  Complete Android Studio setup, run:"
PRINTLOG "         $AndroidInstallDir/android-studio/bin/studio.sh"
PRINTLOG "  *  Install Android Studio plugins:"
PRINTLOG "         File > Settings > Plugins : Browse repositories"
PRINTLOG "         Install Flutter and Dart plugins."
PRINTLOG "******************************"
PRINTLOG ""
PRINTLOG "******************************"
PRINTLOG "IMMEDIATE REBOOT RECOMMENDED."
PRINTLOG "******************************"
