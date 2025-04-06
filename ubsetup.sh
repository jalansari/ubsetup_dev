#!/usr/bin/env bash

########################################
##### Constants and variables used
##### throughout this script.
########################################


declare -A DebPackages
DebPackages=(
             ["code"]="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64;mscode.deb"
             ["codium"]="https://github.com/VSCodium/vscodium/releases/download/1.99.02289/codium_1.99.02289_amd64.deb"
             ["bcompare"]="https://www.scootersoftware.com/files/bcompare-5.0.6.30713_amd64.deb"
             ["draw.io"]="https://github.com/jgraph/drawio-desktop/releases/download/v26.2.2/drawio-amd64-26.2.2.deb"
             ["mysql-workbench-community"]="https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_8.0.41-1ubuntu24.04_amd64.deb"
             ["slack-desktop"]="https://downloads.slack-edge.com/desktop-releases/linux/x64/4.41.105/slack-desktop-4.41.105-amd64.deb"
            )


InstallDir="/usr/share"
UsrLocalDir="/usr/local"


NodeJsVer="node-v22.14.0-linux-x64"
NodeJsPkg="$NodeJsVer.tar.xz"
NodeJsUrl="https://nodejs.org/dist/v22.14.0/$NodeJsPkg"
NodeInstallDir="$InstallDir/nodejs"

FossilScmPkg="fossil-linux-x64-2.25.tar.gz"
FossilScmUrl="https://fossil-scm.org/home/uv/$FossilScmPkg"
FossilInstallDir="$InstallDir/fossilscm"

GoLangPkg="go1.24.2.linux-amd64.tar.gz"
GoLangUrl="https://go.dev/dl/$GoLangPkg"
GoPath="$UsrLocalDir/go"

VagrantPkg="vagrant_2.4.3_linux_amd64.zip"
VagrantUrl="https://releases.hashicorp.com/vagrant/2.4.3/$VagrantPkg"

TelegramPackage="telegram_linux.tar.xz"
TelegramPackageHttpURL="https://telegram.org/dl/desktop/linux"

VeraCryptPkg="veracrypt-1.26.20-setup.tar.bz2"
VeraCryptUrl="https://launchpad.net/veracrypt/trunk/1.26.20/+download/$VeraCryptPkg"

# DockerComposeUrl="https://github.com/docker/compose/releases/latest/download/docker-compose-Linux-x86_64"
# DockerComposeUrl="https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64"

TerraformPkg="terraform_1.5.5_linux_amd64.zip"
TerraformUrl="https://releases.hashicorp.com/terraform/1.5.5/$TerraformPkg"
TerraformRCGlobal="/etc/skel/.terraformrc"

TofuVer="1.9.0"
TofuPkg="tofu_${TofuVer}_linux_amd64.tar.gz"
TofuUrl="https://github.com/opentofu/opentofu/releases/download/v$TofuVer/$TofuPkg"
TofuRCGlobal="/etc/skel/.tofurc"

TflintPkg="tflint_linux_amd64.zip"
TflintUrl="https://github.com/terraform-linters/tflint/releases/latest/download/$TflintPkg"

YqUrl="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64"

# TerragruntUrl="https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64"

# ConfiglintPkg="config-lint_Linux_x86_64.tar.gz"
# ConfiglintUrl="https://github.com/stelligent/config-lint/releases/download/v1.6.0/$ConfiglintPkg"
# ConfiglintInstallDir="$InstallDir/configlint"

AwsCliPkg="awscli-exe-linux-x86_64.zip"
AwsCliUrl="https://awscli.amazonaws.com/$AwsCliPkg"

PlantUmlVer="1.2025.2"
PlantUmlUrl="https://github.com/plantuml/plantuml/releases/download/v$PlantUmlVer/plantuml-$PlantUmlVer.jar"
PlantumlTargetBin="/usr/local/bin/plantuml.jar"

AndroidPkg="android-studio-2024.3.1.14-linux.tar.gz"
AndroidUrl="https://dl.google.com/dl/android/studio/ide-zips/2024.3.1.14/$AndroidPkg"
AndroidInstallDir="$InstallDir/androidstudio"

FlutterPkg="flutter_linux_3.29.2-stable.tar.xz"
FlutterUrl="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/$FlutterPkg"
FlutterInstallDir="$InstallDir/flutterdev"


declare -A Fonts
Fonts=(
       ["open_sans"]="https://al-ansari.co.uk/j/fonts/Open_Sans.zip"
       ["roboto_mono"]="https://al-ansari.co.uk/j/fonts/Roboto_Mono.zip"
       ["inconsolata"]="https://al-ansari.co.uk/j/fonts/Inconsolata.zip"
       ["source_code_p"]="https://al-ansari.co.uk/j/fonts/Source_Code_Pro.zip"
       ["mononoki"]="https://github.com/madmalik/mononoki/releases/latest/download/mononoki.zip"
       ["jetbrains_mono"]="https://www.fontsquirrel.com/fonts/download/jetbrains-mono"
       ["overpass"]="https://al-ansari.co.uk/j/fonts/Overpass.zip"
       ["overpass_mono"]="https://al-ansari.co.uk/j/fonts/Overpass_Mono.zip"
       ["inter"]="https://al-ansari.co.uk/j/fonts/Inter.zip"
      )
allFontsFolder="/usr/share/fonts/ubsetup_installed_fonts"


declare -A UserInfo
currentUserNameKey="*"
UserInfo=(
          [$currentUserNameKey]="Full Name;em@il.com;sshpvtkeyfile;maingroup"
         )

KeyboardShortcutVSCode="<Alt><Super>c"
KeyboardShortcutChrome="<Alt><Super>b"
KeyboardShortcutUpdateMan="<Alt><Super>u"
KeyboardShortcutHome="<Super>h"
KeyboardShortcutTerminal="<Super>Return"
KeyboardScreenShotSelect="<Shift>Print"

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
FirefoxSysPrefsConfig="/usr/lib/firefox/defaults/pref/local-settings.js"
FirefoxSysUsersConfig="/usr/lib/firefox/mozilla.cfg"


declare -A FirefoxAddons
# Firefox addons must be downloaded into the global path, as a file name exactly
# matching the addon "id", which can be found in the manifest.json of an already
# installed/extracted addon.
FirefoxAddons=(
       ["uBlock0@raymondhill.net"]="https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
       ["{446900e4-71c2-419f-a6a7-df9c091e268b}"]="https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi"
       ["firefox@tampermonkey.net"]="https://addons.mozilla.org/firefox/downloads/latest/tampermonkey/latest.xpi"
       # ["{73a6fe31-595d-460b-a920-fcc0f8843232}"]="https://addons.mozilla.org/firefox/downloads/latest/noscript/latest.xpi"
      )
FirefoxAddonsDir="/usr/lib/firefox/distribution/extensions"


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


AptKeyringsDir="/usr/share/keyrings/ubsetup"
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
                   "docker.io"
                   "docker-buildx"
                   "docker-clean"
                   "docker-compose"
                   "docker-compose-v2"
                   "docker-doc"
                   "docker-registry"
                   "podman-docker"
                   "containerd"
                   "runc"
                  )

# List of components to be installed prior to running apt update.
P_UPDATE_INS_LIST=(
                  )

# List of components to be installed.
INSTALL_COMP_LIST=(
                   "vim"
                   "htop"
                   "unzip"
                   "python3-pip"
                   "python3-venv"
                  )

INSTAL_PIP2n3_MAP=(
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
                   "simplescreenrecorder"
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
                   "gnupg"
                   "curl"
                   "shunit2" # Shell script unit test framework.
                   "pv"
                   "jq"
                   "ssh"
                   "libpango-1.0-0" # Needed by Dropbox installer.
                   "libzip4"
                   "libproj25" # Needed by mysql-workbench
                   "proj-data" # Needed by mysql-workbench
                   "libopengl0" # Needed by mysql-workbench
                   "libpcrecpp0v5" # Needed by mysql-workbench
                   "libodbc2" # Needed by mysql-workbench
                   "ipython3"
                   "python3-tk" # Toolkit required for matplotlib graphics.
                   "ncdu"
                   "libimage-exiftool-perl" # To read and modify/remove exif tags from photos.
                   "ifmetric" # Used to set priority interface for VPN connections.
                   "ffmpeg"
                   "mkvtoolnix"
                   "subtitleeditor"
                   "gromit-mpx"
                   "flameshot"
                   "screenkey"
                   "fastfetch"
                   "postgresql-client"
                   "mysql-client"
                   "libcurl4-openssl-dev" # Needed by pycurl, in case it is required in any development.
                   "libssl-dev" # Needed by pycurl, in case it is required in any development.
                   "libpq-dev" #  Needed by psycopg2, in case it is required in any development.
                  )

INSTAL_PIP2n3_MAP_DESKTOP=(
                   "pre-commit"
                  )

declare -A DebSources
DebSources=(
            ["deb [arch=$(dpkg --print-architecture) signed-by=$AptKeyringsDir/chrome.gpg] https://dl.google.com/linux/chrome/deb/ stable main"]="/etc/apt/sources.list.d/google.list" # google-chrome
           )

ADD_APT_KEYS_LIST=(
                   "https://dl.google.com/linux/linux_signing_key.pub;chrome.gpg" # google-chrome
                  )

# List of PPA repositories to be added.
ADD_PPA_REPO_LIST=(
                  )

ADD_PPA_REPO_LIST_DESKTOP=(
                   "ppa:zhangsongcui3371/fastfetch"
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
--ruby   : Install RVM for Ruby installation.  (Not required if using '--rubyv').
--rubyv  : Install RVM, AND install a specific Ruby version.
--docker : Install Docker Engine - Community.
--gitlabr: Install Gitlab Runner (needs --docker for this to work).
--rabbit : Install RabbitMq, with its Erlang dependency.
--tor    : Install Tor Daemon, which listens on port 9050.
--flutter: Install majority of components to get Flutter setup.
--ov24   : Install Openvpn 2.4, using \`update-alternatives --config openvpn\`.

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
sudo ./ubsetup.sh -a --docker -un "<FULL_NAME>" -ue "<EMAIL>" -ug $( id -g -n $SUDO_USER ) --ov24 2>&1 | tee ubsetup.sh.log
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
	autocmd BufWritePre * :%s/\s\+$//e
	autocmd BufWritePost *.plantuml !java -jar $PlantumlTargetBin -verbose -tsvg <afile>
EOTXT

read -r -d '' TEXT_GitCfg <<- EOTXT
	[core]
		editor = vim
	[push]
		default = simple
	[pull]
		rebase = false
	[alias]
		lg = log --graph --all --pretty=format:'%C(bold magenta)%h%Creset (%G?) : %s %C(cyan)%cI %Cgreen(%cr) %C(blue)%an %C(bold green)(%ae) %C(yellow)%d%Creset %GK'
EOTXT

read -r -d '' TEXT_FirefoxPrefs <<- EOTXT
	pref("general.config.filename", "mozilla.cfg");
	pref("general.config.obscure_value", 0);
EOTXT

read -r -d '' TEXT_FirefoxCfg <<- EOTXT
	//
	pref("browser.startup.homepage", "$FirefoxHomePage");
	// pref("signon.rememberSignons", false);

	pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
	pref("browser.newtabpage.activity-stream.feeds.topsites", false);

	pref("browser.startup.page", 3); // 3 : Resume the previous browser session

	pref("browser.urlbar.showSearchSuggestionsFirst", false);

	pref("datareporting.healthreport.uploadEnabled", false);
	pref("app.shield.optoutstudies.enabled", false);
EOTXT

read -r -d '' TEXT_TerminatorCfg <<- EOTXT
	[global_config]
	    case_sensitive = False
	    invert_search = True
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

read -r -d '' TEXT_TerraformCfg <<- "EOTXT"
	plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"
	disable_checkpoint = true
EOTXT

read -r -d '' TEXT_TofuCfg <<- "EOTXT"
	plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"
	disable_checkpoint = true
EOTXT


##### Cinnamon Configs ######

read -r -d '' TEXT_LocalBookmarks <<- EOTXT
	file://$userHomeDir/Documents
	file://$userHomeDir/Downloads
EOTXT

FMShowHiddenFilesVal="true"
if [[ $FileManagerShowHidden == $FileManagerShowHiddenNo ]]; then
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
	show-compact-view-icon-toolbar=false
	show-home-icon-toolbar=true
	show-icon-view-icon-toolbar=false
	show-list-view-icon-toolbar=false
	show-new-folder-icon-toolbar=true
	show-open-in-terminal-toolbar=true
	show-search-icon-toolbar=true
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
	num-workspaces=$WorkspacesNumberOf
	mouse-button-modifier='<Super>'
	min-window-opacity=30

	[org.cinnamon.theme]
	name='Mint-Y-Dark'

	[org.x.apps.portal]
	color-scheme='prefer-dark'

	[org.gnome.desktop.interface]
	clock-format='24h'

	[org.cinnamon.desktop.interface]
	cursor-theme='DMZ-White'
	icon-theme='Mint-Y'
	gtk-theme='Mint-Y-Dark'
	clock-show-date=true
	first-day-of-week=1
EOTXT

read -r -d '' TEXT_CinnamonKeyboardShortCutsConfig <<- EOTXT
	[org.cinnamon.desktop.keybindings]
	custom-list=['custom3', 'custom2', 'custom1', 'custom0', '__dummy__']

	[org.cinnamon.desktop.keybindings.custom-keybindings.custom0]
	binding=['$KeyboardShortcutVSCode']
	command='code'
	name='VSCode'

	[org.cinnamon.desktop.keybindings.custom-keybindings.custom1]
	binding=['$KeyboardShortcutChrome']
	command='google-chrome'
	name='Chrome'

	[org.cinnamon.desktop.keybindings.custom-keybindings.custom2]
	binding=['$KeyboardShortcutUpdateMan']
	command='mintupdate'
	name='Update Manager'

	[org.cinnamon.desktop.keybindings.custom-keybindings.custom3]
	binding=['$KeyboardScreenShotSelect']
	command='flameshot gui'
	name='Flameshot'

	[org.cinnamon.desktop.keybindings.media-keys]
	home=['$KeyboardShortcutHome']
	terminal=['$KeyboardShortcutTerminal']
EOTXT

read -r -d '' TEXT_CinnamonSoundsGSettingsConfig <<- EOTXT
	[org.cinnamon.sounds]
	login-enabled=false
	logout-enabled=false
	plug-enabled=false
	unplug-enabled=false
	tile-enabled=false
	switch-enabled=false
	notification-enabled=false

	[org.cinnamon.desktop.sounds]
	event-sounds=false
EOTXT

read -r -d '' TEXT_CinnamonMouseGSettingsConfig <<- EOTXT
	[org.cinnamon.desktop.peripherals.touchpad]
	click-method='fingers'
	disable-while-typing=true
	natural-scroll=false
	speed=0.575
	tap-to-click=true

	[org.cinnamon.gestures]
	enabled=true
	pinch-in-2='MINIMIZE'
	pinch-out-2='MAXIMIZE'
	swipe-left-2='PUSH_TILE_LEFT'
	tap-2='TOGGLE_OVERVIEW'

	[org.cinnamon.desktop.peripherals.mouse]
	middle-click-emulation=false
	natural-scroll=false
EOTXT

read -r -d '' TEXT_CinnamonPowerGSettingsConfig <<- EOTXT
	[org.cinnamon.settings-daemon.plugins.power]
	lock-on-suspend=true
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
	computer-icon-visible=false
	home-icon-visible=true
	trash-icon-visible=true

	[org.cinnamon.desktop.privacy]
	remember-recent-files=$CinnamonRememberRecentFiles
	recent-files-max-age=30

	[org.cinnamon.desktop.background]
	picture-options='none'
	primary-color='$DesktopBackgroundColor'

	[org.cinnamon.desktop.session]
	idle-delay=uint32 300

	[org.cinnamon.muffin]
	workspace-cycle=true

	[org.cinnamon]
	startup-animation=false
	desklet-decorations=0
	desklet-snap=true
	desklet-snap-interval=25
	enabled-desklets=['clock@cinnamon.org:0:170:10']
	panels-height=['1:$CinnamonPanelHeight']
	panels-autohide=['1:$CinnamonPanelAutohide']
	desktop-effects-workspace=false
	alttab-switcher-delay=100
	alttab-switcher-enforce-primary-monitor=true
	alttab-switcher-show-all-workspaces=true
	alttab-switcher-style='icons+thumbnails'
	alttab-switcher-warp-mouse-pointer=true

	[org.cinnamon.desktop.screensaver]
	use-custom-format=true
	date-format='%a %d %b %Y'
	time-format='%H:%M'
	font-date='Ubuntu 30'
	font-time='Ubuntu 60'
	lock-enabled=true
	lock-delay=uint32 5

	[org.cinnamon.settings-daemon.peripherals.touchscreen]
	orientation-lock=false

	[org.cinnamon.desktop.a11y.keyboard]
	togglekeys-enable-osd=true

	[org.gnome.desktop.a11y.applications]
	screen-keyboard-enabled=false
	screen-reader-enabled=false

	[org.cinnamon.desktop.notifications]
	remove-old=false

	[com.linuxmint.report]
	ignored-reports=['install-language-packs', 'install-media-codecs', 'timeshift-no-setup']
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
	draw-whitespace=true
	draw-whitespace-inside=true
	draw-whitespace-leading=true
	draw-whitespace-newline=false
	draw-whitespace-trailing=true

	[org.x.editor.preferences.ui]
	enable-tab-scrolling=false
	statusbar-visible=true
	minimap-visible=true
EOTXT

read -r -d '' TEXT_LinuxmintLightdmGreeterSettings <<- EOTXT
	[Greeter]
	background=/usr/share/backgrounds/linuxmint/edesigner_linuxmint.png
	clock-format=%a %d %b %Y, %H:%M
	draw-user-backgrounds=false
	cursor-theme-name=DMZ-White
	theme-name=Mint-Y-Dark
	icon-theme-name=Mint-Y-Dark
EOTXT


##### Ubuntu Configs ######

read -r -d '' TEXT_UbuntuPowerGSettingsConfig <<- EOTXT
	[org.gnome.settings-daemon.plugins.power]
	sleep-inactive-battery-timeout=1200
	sleep-inactive-battery-type='suspend'
	sleep-inactive-ac-timeout=3600
	sleep-inactive-ac-type='nothing'
EOTXT

read -r -d '' TEXT_UbuntuNightLightGSettingsConfig <<- EOTXT
	[org.gnome.settings-daemon.plugins.color]
	night-light-enabled=true
	night-light-schedule-automatic=false
	night-light-schedule-from=21.0
	night-light-schedule-to=8.0
	night-light-temperature=uint32 2700
EOTXT

read -r -d '' TEXT_UbuntuDesktopGSettingsConfig <<- EOTXT
	[org.gnome.desktop.background]
	picture-uri=''
	picture-uri-dark=''
	primary-color='$DesktopBackgroundColor'

	[org.gnome.desktop.interface]
	color-scheme='prefer-dark'
	gtk-theme='Yaru-dark'
	icon-theme='Yaru'
	enable-animations=false
	show-battery-percentage=true

	[org.gnome.shell.extensions.ding]
	icon-size='small'
	arrangeorder='NAME'

	[org.gnome.shell.extensions.dash-to-dock]
	dash-max-icon-size=32
	dock-fixed=false
	extend-height=false

	[org.gnome.desktop.privacy]
	recent-files-max-age=30
	remember-recent-files=true
	report-technical-problems=true
	old-files-age=uint32 30
	remove-old-temp-files=false
	remove-old-trash-files=false

	[org.gnome.desktop.screensaver]
	lock-delay=uint32 0
	lock-enabled=true

	[org.gnome.desktop.session]
	idle-delay=uint32 300

	[org.gnome.desktop.peripherals.mouse]
	natural-scroll=false
	speed=0.20

	[org.gnome.desktop.peripherals.touchpad]
	two-finger-scrolling-enabled=true

	[org.gnome.settings-daemon.plugins.media-keys]
	home=['<Primary><Alt>h']

	[org.gnome.settings-daemon.plugins.media-keys]
	custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']
	home=['$KeyboardShortcutHome']
	terminal=['$KeyboardShortcutTerminal']
	www=['$KeyboardShortcutChrome']

	[org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
	binding='$KeyboardShortcutVSCode'
	command='code'
	name='VSCode'

	[org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom1]
	binding='$KeyboardShortcutUpdateMan'
	command='update-manager'
	name='UpdateManager'

	[org.gnome.shell]
	favorite-apps=[]
EOTXT
# favorite-apps is later over-written with list of launchers.

read -r -d '' TEXT_nautilusGSettingsConfig <<- EOTXT
	[org.gnome.nautilus.preferences]
	default-folder-viewer='list-view'
	search-filter-time-type='last_modified'
	show-image-thumbnails='never'

	[org.gnome.nautilus.list-view]
	default-visible-columns=['name', 'size', 'type', 'owner', 'group', 'permissions', 'date_modified_with_time']
	default-zoom-level='small'

	[org.gtk.settings.file-chooser]
	date-format='regular'
	location-mode='path-bar'
	show-size-column=true
	show-type-column=true
	sort-column='name'
	sort-directories-first=true
	sort-order='ascending'
	type-format='category'
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
	scheme='Yaru-dark'
	background-pattern='none'
	display-overview-map=true
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
	  "git.mergeEditor": false,
	  "telemetry.telemetryLevel": "off",
	  "files.trimTrailingWhitespace": true,
	  "files.autoSave": "onWindowChange",
	  "diffEditor.ignoreTrimWhitespace": false,
	  "editor.detectIndentation": false,
	  "terminal.integrated.scrollback": 20000,
	  "editor.accessibilitySupport": "off",
	  "accessibility.signals.sounds.volume": 0,
	  "[terraform]": {
	    "editor.tabSize": 2
	  },
	  "[yaml]": {
	    "editor.insertSpaces": true,
	    "editor.tabSize": 2,
	    "editor.detectIndentation" : false
	  },
	  "[json]": {
	    "editor.insertSpaces": true,
	    "editor.tabSize": 2,
	    "editor.detectIndentation": false,
	    "editor.defaultFormatter": "vscode.json-language-features"
	  },
	  "plantuml.render": "Local",
	  "plantuml.jar": "$PlantumlTargetBin",
	  "cSpell.userWords": [
	    "aiohttp",
	    "aioresponses",
	    "asyncio",
	    "boto",
	    "boto3",
	    "botocore",
	    "creds",
	    "debugpy",
	    "dataclasses",
	    "dearmour",
	    "dockerignore",
	    "drawio",
	    "emea",
	    "entrypoint",
	    "exiftool",
	    "fargate",
	    "fastapi",
	    "fintech",
	    "freemium",
	    "hasura",
	    "gitlab",
	    "grafana",
	    "gunicorn",
	    "hadoop",
	    "itertools",
	    "ifmetric",
	    "ipcalc",
	    "jinja",
	    "jwks",
	    "kanban",
	    "keycloak",
	    "libreoffice",
	    "localstack",
	    "linuxmint",
	    "microservices",
	    "mkdir",
	    "mysqldump",
	    "nosql",
	    "numpy",
	    "opensearch",
	    "opensource",
	    "plantuml",
	    "plugins",
	    "postgres",
	    "proxysql",
	    "psql",
	    "pydantic",
	    "pyspark",
	    "pytest",
	    "roadmap",
	    "scikit",
	    "scrollback",
	    "secops",
	    "sqlalchemy",
	    "starlette",
	    "templating",
	    "tiering",
	    "ubsetup",
	    "urldecode",
	    "urlencode",
	    "urllib",
	    "uvicorn",
	    "ventoy",
	    "venv",
	    "vlookup",
	    "webserver",
	    "workstream",
	    "xargs",
	  ],
	  "cSpell.language": "en-GB",
	  "cSpell.enabled": true
	}
EOTXT

read -r -d '' TEXT_VSKeybindings <<- EOTXT
	[
	    {
	        "key": "ctrl+tab",
	        "command": "workbench.action.nextEditor"
	    },
	    {
	        "key": "ctrl+shift+tab",
	        "command": "workbench.action.previousEditor"
	    },
	    // Following Ctrl-R / Ctrl-C key bindings are based on the following:
	    // https://github.com/microsoft/vscode-docs/blob/vnext/release-notes/v1_70.md#run-recent-command-as-a-replacement-for-reverse-search
	    // to maintain ability to use reverse search in the terminal.
	    {
	        "key": "ctrl+r",
	        "command": "workbench.action.terminal.sendSequence",
	        "args": { "text": "\u0012"/*^R*/ },
	        "when": "terminalFocus"
	    },
	    {
	        "key": "ctrl+alt+r",
	        "command": "workbench.action.terminal.runRecentCommand",
	        "when": "terminalFocus"
	    },
	    {
	        "key": "ctrl+r",
	        "command": "workbench.action.quickOpenNavigateNextInViewPicker",
	        "when": "inQuickOpen && inTerminalRunCommandPicker"
	    },
	    {
	        "key": "ctrl+c",
	        "command": "workbench.action.closeQuickOpen",
	        "when": "inQuickOpen && inTerminalRunCommandPicker"
	    },
	]
EOTXT

read -r -d '' TEXT_VSCodeWorkspaceExample <<- EOTXT
	{
	    "folders": [
	        // {
	        //     "name": "name", // Name is optional
	        //     "path": "path"
	        // },
	    ],
	}
EOTXT

read -r -d '' TEXT_VSCodeNemoContextItem <<- EOTXT
	[Nemo Action]
	Active=true
	Name=Open in VSCode
	Comment=Open in VSCode
	Exec=code -a %F
	Icon-Name=com.visualstudio.code
	Selection=notnone
	Extensions=any;
	Mimetypes=text/plain;
	Quote=double
	Dependencies=code;
EOTXT


read -r -d '' TEXT_GromitMPXConfig <<- EOTXT
	# Copy to "\$HOME/.config/gromit-mpx.cfg" for user specific customisation.

	# DEFINITIONS
	"red Pen" = PEN (size=5 color="red");
	"green Pen" = PEN (size=5 color="green");
	"blue Pen" = PEN (size=5 color="blue");
	"yellow Pen" = PEN (size=5 color="yellow");

	"red Highlighter" = "red Pen" (size=100);
	"green Highlighter" = "green Pen" (size=100);
	"blue Highlighter" = "blue Pen" (size=100);
	"yellow Highlighter" = "yellow Pen" (size=100);

	"red fixed Marker" = "red Pen" (minsize=5 maxsize=5);
	"green fixed Marker" = "green Pen" (minsize=5 maxsize=5);
	"blue fixed Marker" = "blue Pen" (minsize=5 maxsize=5);
	"yellow fixed Marker" = "yellow Pen" (minsize=5 maxsize=5);

	# "red Marker" = "red Pen" (arrowsize=5);
	# "green Marker" = "green Pen" (arrowsize=5);
	# "blue Marker" = "blue Pen" (arrowsize=5);
	# "yellow Marker" =  "yellow Pen" (arrowsize=5);

	"Eraser" = ERASER (size = 50);

	# Regular pens and eraser
	"default"[1] = "red fixed Marker";
	"default"[ALT, 1] = "green fixed Marker";
	"default"[CONTROL, 1] = "blue fixed Marker";
	"default"[ALT, CONTROL, 1] = "yellow fixed Marker";
	"default"[SHIFT, 1] = "Eraser";

	# Wider pens
	"default"[3] = "red Highlighter";
	"default"[ALT, 3] = "green Highlighter";
	"default"[CONTROL, 3] = "blue Highlighter";
	"default"[ALT, CONTROL, 3] = "yellow Highlighter";

	# Bigger eraser
	"default"[CONTROL, SHIFT, ALT, 1] = "Eraser" (size = 400);
EOTXT


##### Bash aliases ######

read -r -d '' TEXT_BashSetCinnamonKeybindings <<- EOTXT
	function ____keybindings_custom____() {
	    keybindings_custom_list=\$(dconf read /org/cinnamon/desktop/keybindings/custom-list)
	    if [ -z "\$keybindings_custom_list" ]; then
	        dconf write /org/cinnamon/desktop/keybindings/custom-list "['custom3', 'custom2', 'custom1', 'custom0', '__dummy__']"

	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/binding "['$KeyboardShortcutVSCode']"
	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/command "'code'"
	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom0/name "'VSCode'"

	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom1/binding "['$KeyboardShortcutChrome']"
	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom1/command "'google-chrome'"
	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom1/name "'Chrome'"

	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom2/binding "['$KeyboardShortcutUpdateMan']"
	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom2/command "'mintupdate'"
	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom2/name "'Update Manager'"

	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom3/binding "['$KeyboardScreenShotSelect']"
	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom3/command "'flameshot gui'"
	        dconf write /org/cinnamon/desktop/keybindings/custom-keybindings/custom3/name "'Flameshot screenshot'"
	    fi
	}
	____keybindings_custom____
EOTXT

read -r -d '' TEXT_CreateTerraformCacheDir <<- "EOTXT"
	mkdir -p "$HOME/.terraform.d/plugin-cache"
EOTXT

read -r -d '' TEXT_BashToolAliases <<- "EOTXT"
	function ____save____() {
	    prefix="$1"
	    folder_loc="$2"
	    target_loc="$HOME/Downloads/"
	    save_filename="$prefix$(date '+%Y%m%dT%H%M%S').tgz"
	    cd "$folder_loc"
	    tar czf "$save_filename" *
	    mv "$save_filename" "$target_loc"
	    cd -
	}
	function ____restore____() {
	    prefix="$1"
	    folder_loc="$2"
	    target_loc="$HOME/Downloads/"
	    mkdir -p "$folder_loc"
	    rm -rf "$folder_loc"/*
	    latest_save=$( ls -t "$target_loc$prefix"* | head -1 )
	    echo "=============================="
	    echo "===== Restoring $latest_save"
	    echo "===== To        $folder_loc"
	    echo "=============================="
	    tar -C "$folder_loc" -xvf "$latest_save"
	}
	function ffm540() {
	    ffmpeg -i "$1" -c:v libx264 -crf 20 -preset slow -vf scale=960:540 -strict -2 "$1.540p.${1##*.}"
	}
	function ffm10secs() {
	    ffmpeg -i "$1" -f segment -segment_time 10 -c copy "$1_%03d.${1##*.}"
	}
	alias ll='ls --time-style="long-iso" -alF --group-directories-first'
	alias hiss='history | grep'
	alias trimws='find . -type f ! -path "*/.venv/*" ! -path "*/.git/*" ! -path "*/venv/*" | xargs -I fl bash -c '"'"'FILE="fl"; echo ">>>>>>>> $FILE"; sed -i -r "s/\s+$//;" "$FILE"; [[ $( tail -c 1 "$FILE" ) != "" ]] && echo >> "$FILE"'"'"
	alias cleantf='find . -type f -name ".terraform.lock*" | xargs -I fl bash -c "cd \$( dirname fl ) && pwd && rm -rf .terraform*"'
	stty -ixon # Disable xon/off flow control, as it clashes with history search (Ctrl-s)
	# set -o vi
	# bind '\e[A:history-search-backward'
	# bind '\e[B:history-search-forward'
EOTXT

read -r -d '' TEXT_BashDockerAliases <<- "EOTXT"
	clrS="\033[0;33m"
	clrE="\033[0m"
	function docker_all_clean_containers() {
	    echo -e "${clrS}Wiping Docker contianers${clrE}"
	    docker container rm -fv $(docker ps -qa)
	}
	function docker_all_nuke() {
	    docker_all_stop
	    echo -e "${clrS}Wiping Docker contianers and images${clrE}"
	    docker system prune -af
	    echo -e "${clrS}Wiping Docker volumes${clrE}"
	    docker system prune --volumes -af
	    echo -e "${clrS}Wiping Docker unused volumes, if any exist${clrE}"
	    docker_volumes_unused=( $(docker volume ls -qf dangling=true) )
	    if [[ "${#docker_volumes_unused[@]}" != 0 ]]; then
	        docker volume rm $docker_volumes_unused
	    fi
	}
	function docker_all_stop() {
	    docker_running_containers=( $(docker ps -q) )
	    echo -e "${clrS}Found running containers${clrE} <${docker_running_containers[@]}>"
	    for container_id in "${docker_running_containers[@]}"
	    do
	        echo -e "${clrS}Killing container ID${clrE} <$container_id>"
	        docker kill $container_id
	    done
	}
	alias dclean="docker_all_clean_containers"
	alias dnuke="docker_all_nuke"
	alias dlistall="docker ps -a && docker images -a"
	alias dstopall="docker_all_stop"
EOTXT

read -r -d '' TEXT_BashToolAliases_Inter <<- EOTXT
	alias plantuml="java -jar $PlantumlTargetBin -verbose -tsvg"
EOTXT

read -r -d '' TEXT_BashGitAliases <<- "EOTXT"
	function ____git_get_branch() {
	    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d; s/^* //;')
	    if [[ -n $branch ]]; then
	        if [[ "$branch" =~ ^master$|^main$ ]]; then
	            branch_clr="1;31m"
	        elif [[ "$branch" == "staging" ]]; then
	            branch_clr="1;33m"
	        else
	            branch_clr="0;36m"
	        fi
	        branch_annotated="\001\033[$branch_clr\002[$branch]\001\033[0m\002"
	        echo -e "$branch_annotated"
	    fi
	}
	export -f ____git_get_branch
	PS1=$(echo $PS1 | sed 's/\\\$/ $(____git_get_branch)\\\$ /;')

	function ____gititer____() {
	    for d in ./*/; do
	        pushd $d > /dev/null 2>&1
	        echo -e "\033[30;1;106m$(pwd)\033[0m"
	        if [[ -n "$3" ]]; then
	            git "$1" "$2" "$3"
	        elif [[ -n "$2" ]]; then
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
	alias gitcommits='____gititer____ commit'
EOTXT
read -r -d '' TEXT_BashGitAliases_2 <<- "EOTXT"
	function ____git_clone_precommit_inst____() {
	    repodir="$2"
	    if [[ -z "$2" ]]; then
	        repodir="${1##*/}"
	        repodir="${repodir%.*}"
	        git clone "$1"
	    else
	        git clone "$1" "$2"
	    fi
	    cd "$repodir"
	        pre-commit install
	    cd -
	}
	alias gitcp='____git_clone_precommit_inst____'
	function ____github_actions_updater____() {
	    folder_search_pattern=".github"
	    test -n "$1" && folder_search_pattern="$1"
	    plugin_list=( $( find "$folder_search_pattern" -type f -name "*.yml" -exec sed -En 's|.*\s+uses:\s+([[:alnum:]\-]+\/[[:alnum:]\-]+)\@v[[:digit:]].*|\1|p' {} + | sort -u ) )
	    for a_plugin_path in "${plugin_list[@]}"
	    do
	        github_latest_api_url="https://api.github.com/repos/$a_plugin_path/releases/latest"
	        latest_release_json=$( curl -s -w '%{http_code}' "$github_latest_api_url" )
	        code="${latest_release_json:${#latest_release_json}-3}"
	        body="${latest_release_json:0:${#latest_release_json}-3}"
	        if [[ "$code" != "200" ]]; then
	            echo -e "\033[1;31mError fetching latest release for $a_plugin_path [$code] [$github_latest_api_url]\033[0m"
	            continue
	        fi
	        latest_version=$( echo $body | jq -r .tag_name | sed -En "s|v([0-9]).*|\1|p" )
	        echo -e "\033[1;33mLatest version of $a_plugin_path is $latest_version\033[0m"
	        find "$folder_search_pattern" -type f -name "*.yml" -exec sed -Ei "s|uses:\s+$a_plugin_path@v[[:digit:]\.]+|uses: $a_plugin_path@v$latest_version|g" {} +
	    done
	}
	alias gha_up="____github_actions_updater____"
	function ____github_precommit_updater____() {
	    precommitfile_name_pattern="*pre-commit*.y*ml"
	    plugin_list=( $( find . -type f -name "$precommitfile_name_pattern" -exec \
	        sed -En '/repo:/{
	            $!{
	                N
	                s|^\s*- repo: https://github.com/([[:alnum:]/\-]+)\n\s+rev: (\S+).*|\1,\2|p;
	            }
	        }' {} + | \
	        sort -u ) )
	    echo "Found ${#plugin_list[@]} pre-commit plugins"
	    for a_plugin_ver in "${plugin_list[@]}"
	    do
	        IFS=',' read -ra pluginVerArray <<< "$a_plugin_ver"
	        a_plugin_path="${pluginVerArray[0]}"
	        echo -ne "Updating $a_plugin_path / ${pluginVerArray[1]}\n\t"
	        github_latest_api_url="https://api.github.com/repos/$a_plugin_path/releases/latest"
	        latest_release_json=$( curl -s -w '%{http_code}' "$github_latest_api_url" )
	        code="${latest_release_json:${#latest_release_json}-3}"
	        body="${latest_release_json:0:${#latest_release_json}-3}"
	        if [[ "$code" != "200" ]]; then
	            echo -e "\033[1;31mError for https://github.com/$a_plugin_path [$code] [$github_latest_api_url]\033[0m"
	            continue
	        fi
	        latest_version=$( echo $body | jq -r .tag_name )
	        echo -e "\033[1;33mLatest version: $a_plugin_path -> $latest_version\033[0m"
	        find . -type f -name "$precommitfile_name_pattern" -exec \
	            sed -Ei "/repo:/{
	                $!{
	                    N
	                    s|^(\s*- repo: https://github.com/$a_plugin_path\n\s+rev: )\S+(.*)|\1$latest_version\2|g;
	                }
	            }" {} +
	    done
	}
	alias pc_up="____github_precommit_updater____"
EOTXT

read -r -d '' TEXT_BashPythonToolAliases <<- "EOTXT"
	function ____check_py_requirements____() {
	    reqsFile="$1"
	    if [[ ! -f "$reqsFile" ]]; then
	        reqsFile="requirements.txt";
	    fi
	    reqsFileTmp="$reqsFile.cprtmp"
	    cat "$reqsFile" | while IFS='' read -r line; do
	        pckg=$( echo "$line" | awk -F'(\\[.+\\])?[=~><]=' '{ print $1 }' )
	        vers=$( echo "$line" | awk -F'[=~><]='                '{ print $2 }' )
	        if [[ "$pckg" == "" ]] || [[ "$vers" == "" ]]; then
	            echo "$line" >> "$reqsFileTmp"
	            continue
	        fi
	        pckg_no_spaces=$( echo $pckg )
	        pckg_clean=$( echo "$pckg_no_spaces" | sed -e 's/"//' )
	        vers_clean=$( echo "$vers" | sed -r 's/(.*[[:digit:]])[," ].*/\1/' )
	        echo -n "$pckg_clean : $vers_clean"
	        ver_found=$( curl -s https://pypi.org/pypi/$pckg_clean/json | jq -r 'select(.info != null) | .info.version' )
	        if [[ "$ver_found" == "" ]]; then
	            echo -e " - \033[1;31mNOT FOUND (try https://pypi.org/search/?q=$pckg_clean)\033[0m"
	            echo "$line" >> "$reqsFileTmp"
	        else
	            echo -n " - Latest version: $ver_found"
	            test "$ver_found" != "$vers_clean" && echo -e " - \033[1;33mNOT EQUAL\033[0m" || echo ""
	            newLine="${line/$vers_clean/$ver_found}"
	            echo "$newLine" >> "$reqsFileTmp"
	        fi
	        sleep 0.1
	    done
	    test -f "$reqsFileTmp" && mv "$reqsFileTmp" "$reqsFile"
	}
	export -f ____check_py_requirements____
	alias cpr='____check_py_requirements____'
	alias cprall='for reqs in requirements*; do echo -e "\033[30;1;106m${reqs}\n=====\033[0m"; ____check_py_requirements____ $reqs; echo; done'
	alias cprallr="find -type f -name 'requirements*.txt' | xargs -I {} bash -c 'echo -e \"\033[30;1;106m{}\n=====\033[0m\"; ____check_py_requirements____ {}; echo; sleep 5'"

	function ____cleanpydir____() {
	    rm -rf testresults.xml .coverage .cache .pytest_cache .mypy_cache htmlcov .hypothesis .benchmarks *.egg\-info
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
	alias cleanpyds='sudo bash -c "$(declare -f ____cleanpydir____); ____cleanpydir____"'
EOTXT


########################################
##### Helper functions.
########################################

LOG_PREFIX="ENVSETUP:  "
prefixColour="0;33"
logColour="1;36"
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
    if [[ $? != 0 ]]; then
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
    if [[ $? == 0 ]]; then
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
    packageName="$2"
    PRINTLOG "Attempting to install <$packageName>, from:"
    PRINTLOG "    <$debFileHttpUrl>"
    checkDebPkgInstalled "$packageName"
    if [[ $? == 0 ]]; then
        PRINTLOG "Deb package already installed <$packageName>"
    else
        tempDownloadDir="$TempFolderForDownloads/ubsetuptempdir"
        if [[ ${#URLnNAME[@]} == 1 ]]; then
            debfilename="tempdebfile.deb"
        else
            debfilename="${URLnNAME[1]}"
        fi
        tempDownloadedFile="$tempDownloadDir/$debfilename"
        PRINTLOG "Downloading to <$tempDownloadedFile>"
        mkdir -p "$tempDownloadDir"
        curl "$debFileHttpUrl" --retry 5 -L -f -o "$tempDownloadedFile"
        downloadCmdError=$?
        if [[ $downloadCmdError == 0 ]]; then
            installDebPackage "$packageName" "$tempDownloadedFile"
        else
            PRINT_ERROR "Error <$downloadCmdError> downloading <"$debFileHttpUrl">"
        fi
        rm -rf "$tempDownloadDir"
    fi
}

# Removes package name given as argument.
# Parameters:
#     $1 : Name of package to be removed.
function removeAptPackage()
{   item=$1
    checkDebPkgInstalled $item
    if [[ $? == 0 ]]; then
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
    if [[ ! -f "$file" ]]; then
        return 9
    fi
    FOUND=0
    # Paths may contain $ sign to reference other variables, therefore, ensure $ signs are escaped.
    searchStrEscDollar=$( echo "$newPath" | sed -r 's|\$|\\$|g;' )
    grep -E "^(export)?\s*PATH=.*$searchStrEscDollar" "$file" > /dev/null 2>&1
    if [[ $? != $FOUND ]]; then
        grep -E '^(export)?\s*PATH=.*' "$file" > /dev/null 2>&1
        if [[ $? == $FOUND ]]; then
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
    if [[ ! -f "$file" ]]; then
        return 9
    fi
    if [[ -z "$removeText" ]]; then
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
    if [[ ${#listOfKeys[@]} != 0 ]]; then
        PRINTLOG "APT Keys to be added into [$AptKeyringsDir]:"
        printf "        %s\n" "${listOfKeys[@]}"
        for item in "${listOfKeys[@]}"
        do
            IFS=';' read -ra keyUrlDestArray <<< "$item"
            keyUrl="${keyUrlDestArray[0]}"
            keyDest="${keyUrlDestArray[1]}"
            PRINTLOG "ADDING KEY: [$keyUrl] -> [$keyDest]"
            curl -sSL "$keyUrl" | gpg --dearmor --yes -o "$AptKeyringsDir/$keyDest"
            PRINTLOG "KEY ADDED: [$keyDest]"
        done
    fi
}

function addDebSource()
{   fileSrc="$2"
    FOUND=0
    grepped=`grep -rF "$1" $(dirname "$fileSrc")`
    if [[ $? == $FOUND ]]; then
        PRINTLOG "    Deb source already set:\n<$grepped>"
    else
        echo "$1" >> "$fileSrc"
    fi
}

function removeDebSourceIfDup()
{   debSourceSpecifier="$1"
    fileSrc="$2"
    searchStrRegex="${debSourceSpecifier%[*}.*${debSourceSpecifier#*]}"
    PRINTLOG "    Searching for <$searchStrRegex>."
    greppedFiles=($(grep -lre "$searchStrRegex" $(dirname "$fileSrc")))
    PRINTLOG "    <${#greppedFiles[@]}> sources found."
    for a_file in "${greppedFiles[@]}"
    do
        if [[ "$a_file" != "$fileSrc" ]]; then
            PRINTLOG "    Removing file <$a_file>."
            rm "$a_file"
        fi
    done
}

function iterAssociativeArrAndCall()
{   if [[ ! "$1" =~ ^declare.+=.+ ]]; then
        return 1
    fi
    # Param $1 will be passed in as "declare -A <name>=<map>"
    # so remove the first part using bash substring removal (#<pattern>) and
    # assign the <map> to a the new associative array.
    declare -A mapOfItems # Not necessary, but added for bitbucket pipeline to pass (without, the following eval will throw an error).
    eval "declare -A mapOfItems=${1#*=}"
    if [[ ${#mapOfItems[@]} -gt 0 ]]; then
        PRINTLOG "  Callback <$2>, <${#mapOfItems[@]}>"
        for key in "${!mapOfItems[@]}"
        do
            assocValue="${mapOfItems[$key]}"
            PRINTLOG "    Key   <$key>,"
            PRINTLOG "    Value <$assocValue>"
            $2 "$key" "$assocValue"
            callRet=$?
            if [[ $callRet != 0 ]]; then
                PRINT_ERROR "Return <$callRet> from <"$2">, on <$key> <$assocValue>"
            fi
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
    if [[ ${#listOfRepos[@]} != 0 ]]; then
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
    if [[ ${#listOfSettings[@]} != 0 ]]; then
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
    if [[ ${#listOfSettings[@]} != 0 ]]; then
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
    if [[ ${#listOfPips[@]} != 0 ]]; then
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
                $pipv install --break-system-packages $item
                sleep $SLEEP_AFTER_INSTALL_REQUEST
                $pipv show $item
                if [[ $? != 0 ]]; then
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
#     $5 : Optional.  Path to a specific file to be extracted from the tarball.
# Returns:
#     0 Successfully downloaded and unpacked.
#     1 The path $4 already exists.
#     2 One of the required parameters was not specified.
#     3 There was a problem downloading archive.
#     4 There was a problem decompressing the archive.
function downloadAndUnpack()
{   if [[ -z "$1" ]] || [[ -z "$2" ]] || [[ -z "$3" ]]; then
        return 2
    fi
    if [[ -n "$4" ]] && [[ -e "$4" ]]; then
        PRINTLOG "Not downloading <$2>, as <$4> already exists."
        return 1
    fi
    PRINTLOG "Downloading and unpacking <$2> to <$3>."
    mkdir -p "$3"
    tempDownload="$TempFolderForDownloads/$2"
    curl "$1" -L -f -o "$tempDownload"
    curlStatus=$?
    if [[ $curlStatus != 0 ]]; then
        PRINT_ERROR "Download error <$curlStatus>."
        return 3
    fi
    decompStatus=0
    if [[ "$2" == *.zip ]]; then
        PRINTLOG "Unzipping file <$tempDownload> to <$3>."
        unzip "$tempDownload" -d "$3"
        decompStatus=$?
    else
        PRINTLOG "Untarball file <$tempDownload> to <$3>."
        if [[ -n "$5" ]]; then
            tar -C "$3" -xf "$tempDownload" "$5"
            decompStatus=$?
        else
            tar -C "$3" -xf "$tempDownload"
            decompStatus=$?
        fi
    fi
    rm "$tempDownload"
    if [[ $decompStatus != 0 ]]; then
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
    if [[ $bcompInstalled == 0 ]]; then
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
    userGitConfigLines="[user]\n	email = $4\n	name = $3\n"
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
    if [[ -n "$userFullName" ]]; then
        userDesc=$( sed -r 's/[^;]*(;.*)/'"$userFullName"'\1/' <<< "$userDesc" )
    fi
    if [[ -n "$userGroup" ]]; then
        userDesc=$( sed -r 's/(.*;)[^;]*/\1'"$userGroup"'/' <<< "$userDesc" )
    fi
    if [[ -n "$userEmail" ]]; then
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
{   test -z "$1" && return 1
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
{   test -z "$1" && return 1
    id -u $1 > /dev/null 2>&1
    test $? == 0 || return 2
    if [[ -n "$2" ]]; then
        grep -E "^$2:" /etc/group > /dev/null 2>&1
        test $? == 0 || groupadd "$2" > /dev/null 2>&1
        test $? == 0 || return 8
        usermod -g $2 $1 > /dev/null 2>&1
    fi
    usermod -c "$3,,," $1 > /dev/null 2>&1
    test $? == 0 || return 9
}

function downloadFirefoxAddonIntoGlobalInstall()
{   test -z "$1" && return 1
    test -z "$2" && return 2
    curl "$2" --retry 5 -L -f -o "$FirefoxAddonsDir/$1.xpi"
    return $?
}

function addFirefoxAddonsGlobally()
{   PRINTLOG "Installing Firefox Addons."
    iterAssociativeArrAndCall "$1" downloadFirefoxAddonIntoGlobalInstall
}

function usage()
{   BadArg=$1
    if [[ "$BadArg" != "" ]]; then
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
InstallOpenvpn24=false

RequestOptions=$((2#0000))
TestMode=0

opt_userfullname=""
opt_usergroup=""
opt_useremail=""

OPT_INSTAL=$((2#0001))
OPT_REMOVE=$((2#0010))
OPT_CONFIG=$((2#0100))

while [[ "$1" != "" ]]; do
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
        --ov24 ) InstallOpenvpn24=true
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
if [[ $RequestOptions == 0 ]]; then
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
if [[ $ubServerEnvironment == 0 ]]; then
    PRINTLOG "******************** Ubuntu SERVER"
    INSTALL_COMP_LIST=( "${INSTALL_COMP_LIST[@]}" "${INSTALL_COMP_LIST_SERVER[@]}" )
    INSTAL_PIP2n3_MAP=( "${INSTAL_PIP2n3_MAP[@]}" "${INSTAL_PIP2n3_MAP_SERVER[@]}" )
else
    PRINTLOG "******************** Ubuntu DESKTOP"
    INSTALL_COMP_LIST=( "${INSTALL_COMP_LIST[@]}" "${INSTALL_COMP_LIST_DESKTOP[@]}" )
    INSTAL_PIP2n3_MAP=( "${INSTAL_PIP2n3_MAP[@]}" "${INSTAL_PIP2n3_MAP_DESKTOP[@]}" )
    ADD_PPA_REPO_LIST=( "${ADD_PPA_REPO_LIST[@]}" "${ADD_PPA_REPO_LIST_DESKTOP[@]}" )
fi

if [[ $TestMode == 1 ]]; then
    PRINTLOG "TEST MODE"
    PRINTLOG "=====Request Options========="
    printBinaryVal $RequestOptions
    PRINTLOG "=====Environment Options====="
    PRINTLOG "Ruby Install      : $InstallRuby, RubyVersion: <$RubyVersion>"
    PRINTLOG "Docker Install    : $InstallDocker"
    PRINTLOG "RabbitMq Install  : $InstallRabbitMq"
    PRINTLOG "Tor Daemon Install: $InstallTorDaemon"
    PRINTLOG "FlutterSDK Install: $InstallFlutterSDK"
    PRINTLOG "Openvpn2.4 Install: $InstallOpenvpn24"
    exit
fi


########################################
##### Build up list of components to be
##### removed and added based on
##### environment requested.
########################################

if [[ "$InstallRuby" == true ]]; then
    INSTALL_COMP_LIST+=(
                        "gnupg"
                       )
fi

if [[ "$InstallDocker" == true ]]; then
    ADD_APT_KEYS_LIST+=(
                        "https://download.docker.com/linux/ubuntu/gpg;docker.gpg"
                       )
    # $(lsb_release -cs) should give the codename, but on linuxmint, it will give the mint codename (e.g. tessa) and not the Ubuntu one.
    DebSources["deb [arch=$(dpkg --print-architecture) signed-by=$AptKeyringsDir/docker.gpg] https://download.docker.com/linux/ubuntu $UbuntuReleaseName stable"]="/etc/apt/sources.list.d/docker.list"
    INSTALL_COMP_LIST+=(
                        "docker-ce"
                        "docker-ce-cli"
                        "containerd.io"
                        "docker-buildx-plugin"
                        "docker-compose-plugin"
                       )
fi

if [[ "$InstallRabbitMq" == true ]]; then
    ADD_APT_KEYS_LIST+=(
                        "https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc;rabbitmq-erlang.gpg"
                        "https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc;rabbitmq.gpg"
                       )
    DebSources["deb [signed-by=$AptKeyringsDir/rabbitmq-erlang.gpg] https://packages.erlang-solutions.com/ubuntu $UbuntuReleaseName contrib"]="/etc/apt/sources.list.d/erlang.list"
    DebSources["deb [signed-by=$AptKeyringsDir/rabbitmq.gpg] https://dl.bintray.com/rabbitmq/debian $UbuntuReleaseName main"]="/etc/apt/sources.list.d/bintray.rabbitmq.list"

    INSTALL_COMP_LIST+=(
                        "rabbitmq-server"
                       )
fi

if [[ "$InstallTorDaemon" == true ]]; then
    ADD_APT_KEYS_LIST+=(
                        "https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc;tor-archive-keyring.gpg"
                       )

    DebSources["deb [arch=$(dpkg --print-architecture) signed-by=$AptKeyringsDir/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org $UbuntuReleaseName main"]="/etc/apt/sources.list.d/tord.list"
    DebSources["deb-src [arch=$(dpkg --print-architecture) signed-by=$AptKeyringsDir/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org $UbuntuReleaseName main"]="/etc/apt/sources.list.d/tord.list"

    INSTALL_COMP_LIST+=(
                        "tor"
                        "deb.torproject.org-keyring"
                       )
fi

if [[ "$InstallFlutterSDK" == true ]]; then
    INSTALL_COMP_LIST+=(
                        "lib32stdc++6" # Required for flutter sdk.
                        "qemu-kvm" # Required for Android emulator.
                       )
fi


########################################
##### Applying un/installations.
########################################

if [[ $(( $RequestOptions & $OPT_REMOVE )) == $OPT_REMOVE ]]; then
    uninstallAptPackages REMOVE_COMP__LIST[@]
fi


# Nothin more to do if the install option has not been requested.
if [[ $(( $RequestOptions & $OPT_INSTAL )) != $OPT_INSTAL ]]; then
    exit 0
fi


mkdir -p $AptKeyringsDir

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

if [[ "$InstallDocker" == true ]]; then
    # dc_targetbin="/usr/libexec/docker/cli-plugins/docker-compose"
    # test -n "$DockerComposeUrl" \
    #     && curl "$DockerComposeUrl" -f -o "$dc_targetbin" \
    #     && chmod +x "$dc_targetbin"

    # Wrapper docker compose for backward compatibility
    DockerComposeOldCommand="/usr/bin/docker-compose"
    echo 'docker compose "$@"' > "$DockerComposeOldCommand" \
        && chmod a+x "$DockerComposeOldCommand"

    if [[ "$InstallGitlabRunner" == true ]]; then
        GitLabRunnerPath="/usr/local/bin/gitlab-runner"
        curl https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64 -L -f -o "$GitLabRunnerPath" \
            && chmod a+x "$GitLabRunnerPath" \
            && useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash \
            && gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
    fi
fi

if [[ "$InstallRuby" == true ]]; then
    PRINTLOG "Downloading RVM verification keys."
    gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    PRINTLOG "Install RVM."
    rubyVersionOption=""
    if [ -n "$RubyVersion" ]; then
        PRINTLOG "... with Ruby <$RubyVersion>."
        rubyVersionOption="--ruby=$RubyVersion"
    fi
    curl -sSL https://get.rvm.io | bash -s stable $rubyVersionOption
fi

if [ $ubServerEnvironment != 0 ]; then
    fossilBin="fossil"
    downloadAndUnpack "$FossilScmUrl" "$FossilScmPkg" "$FossilInstallDir" "$FossilInstallDir/$fossilBin" \
        && updatePathGlobally "$FossilInstallDir"

    nodeJsDir="$NodeInstallDir/$NodeJsVer"
    downloadAndUnpack "$NodeJsUrl" "$NodeJsPkg" "$NodeInstallDir" "$nodeJsDir" \
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
    # Workaround to give slack its key in the new (non-legacy) folder.
    checkDebPkgInstalled "slack-desktop"
    if [[ $? == 0 ]]; then
        PRINTLOG "Slack apt key workaround."
        apt-key export "038651BD" | gpg --dearmour --yes -o /etc/apt/trusted.gpg.d/slack.gpg
    fi

    downloadAndUnpack "$VagrantUrl" "$VagrantPkg" "/usr/local/bin" "/usr/local/bin/vagrant"

    downloadAndUnpack "$TerraformUrl" "$TerraformPkg" "/usr/local/bin" "/usr/local/bin/terraform" \
        && echo "$TEXT_TerraformCfg" >> "$TerraformRCGlobal"

    downloadAndUnpack "$TofuUrl" "$TofuPkg" "/usr/local/bin" "/usr/local/bin/tofu" "tofu" \
        && echo "$TEXT_TofuCfg" >> "$TofuRCGlobal"

    downloadAndUnpack "$TflintUrl" "$TflintPkg" "/usr/local/bin" "/usr/local/bin/tflint"

    [ -n "$TerragruntUrl" ] && [ ! -e "/usr/local/bin/terragrunt" ] \
        && curl "$TerragruntUrl" -L -f -o "/usr/local/bin/terragrunt" \
        && chmod +rx "/usr/local/bin/terragrunt"

    downloadAndUnpack "$ConfiglintUrl" "$ConfiglintPkg" "$ConfiglintInstallDir" "$ConfiglintInstallDir" \
        && updatePathGlobally "$ConfiglintInstallDir"

    [ -n "$YqUrl" ] && [ ! -e "/usr/local/bin/yq" ] \
        && curl "$YqUrl" -L -f -o "/usr/local/bin/yq" \
        && chmod +rx "/usr/local/bin/yq"

    awscliUnpackTo="$TempFolderForDownloads"
    awscliDir="$awscliUnpackTo/aws"
    awsCredsDir="$userHomeDir/.aws"
    awsCredsCurrUser="$awsCredsDir/credentials"
    downloadAndUnpack "$AwsCliUrl" "$AwsCliPkg" "$awscliUnpackTo" "$awscliDir" \
        && "$awscliDir/install" \
        && rm -rf "$awscliDir" \
        && mkdir -p "$awsCredsDir" \
        && touch "$awsCredsCurrUser" \
        && echo -e "[default]\naws_access_key_id=<ID>\naws_secret_access_key=<KEY>\n" >> "$awsCredsCurrUser" \
        && chown -R $userOfThisScript:$groupOfUserOfThisScript "$awsCredsDir"

    test -n "$PlantUmlUrl" \
        && curl "$PlantUmlUrl" -L -f -o "$PlantumlTargetBin"

    downloadAndUnpack "$GoLangUrl" "$GoLangPkg" "$UsrLocalDir" "$GoPath"
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

    if [[ "$InstallFlutterSDK" == true ]]; then
        downloadAndUnpack "$FlutterUrl" "$FlutterPkg" "$FlutterInstallDir" "$FlutterInstallDir" \
            && updatePathGlobally "$FlutterInstallDir/flutter/bin" \
            && source $GlobalProfileFile \
            && isFlutterInstalled=true
        downloadAndUnpack "$AndroidUrl" "$AndroidPkg" "$AndroidInstallDir" "$AndroidInstallDir"
    fi

    if [[ "$InstallOpenvpn24" == true ]]; then
        PRINTLOG "Installing OpenVPN 2.4, as an alternative."
        curl http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2.23_amd64.deb -f -o package.deb \
            && ar x package.deb data.tar.xz \
            && tar xf data.tar.xz \
            && cp -r usr/lib/x86_64-linux-gnu/* /usr/lib/x86_64-linux-gnu/ \
            && rm -rf package.deb data.tar.xz usr

        curl http://archive.ubuntu.com/ubuntu/pool/main/o/openvpn/openvpn_2.4.12-0ubuntu0.20.04.2_amd64.deb -f -o package.deb \
            && ar x package.deb data.tar.xz \
            && tar xf data.tar.xz \
            && rm -rf /usr/sbin/openvpn.2.4 /usr/lib/x86_64-linux-gnu/openvpn.2.4 \
            && mkdir -p /usr/lib/x86_64-linux-gnu/openvpn.2.4 \
            && cp usr/sbin/openvpn /usr/sbin/openvpn.2.4 \
            && cp -r usr/lib/x86_64-linux-gnu/openvpn/* /usr/lib/x86_64-linux-gnu/openvpn.2.4/ \
            && rm -rf package.deb data.tar.xz etc lib usr var

        mv /usr/sbin/openvpn /usr/sbin/openvpn.2.5
        mv /usr/lib/openvpn /usr/lib/openvpn.2.5
        rm -rf /usr/lib/openvpn.2.4
        mkdir -p /usr/lib/openvpn.2.4
        ln -sf /usr/lib/x86_64-linux-gnu/openvpn.2.4/plugins/openvpn-plugin-auth-pam.so /usr/lib/openvpn.2.4/
        ln -sf /usr/lib/x86_64-linux-gnu/openvpn.2.4/plugins/openvpn-plugin-down-root.so /usr/lib/openvpn.2.4/

        update-alternatives --install /usr/sbin/openvpn openvpn /usr/sbin/openvpn.2.5 10 --slave /usr/lib/openvpn libopenvpn /usr/lib/openvpn.2.5
        update-alternatives --install /usr/sbin/openvpn openvpn /usr/sbin/openvpn.2.4 9 --slave /usr/lib/openvpn libopenvpn /usr/lib/openvpn.2.4
        PRINTLOG "OpenVPN 2.4 install complete."
    fi

    VeraCryptBin="/usr/bin/veracrypt"
    veraCryptUnpackTo="$UnpackDirForIncompletePckgs/veracrypt"
    downloadAndUnpack "$VeraCryptUrl" "$VeraCryptPkg" "$veraCryptUnpackTo" "$VeraCryptBin" \
        && chown -R $userOfThisScript:$groupOfUserOfThisScript "$veraCryptUnpackTo"
    # Looks like veracrypt cannot be auto installed, as user has to accept license conditions.

    telegramUnpackTo="$UnpackDirForIncompletePckgs"
    telegramBin="$telegramUnpackTo/Telegram/Telegram"
    downloadAndUnpack "$TelegramPackageHttpURL" "$TelegramPackage" "$telegramUnpackTo" "$telegramBin" \
        && chown -R $userOfThisScript:$groupOfUserOfThisScript "$telegramUnpackTo"

    PRINTLOG "Installing fonts."
    doBuildFontCache=false
    for key in "${!Fonts[@]}"
    do
        fontFolder="$allFontsFolder/$key"
        downloadUrl=${Fonts["$key"]}
        PRINTLOG "Download and setup font [$key]: [$downloadUrl] -> [$fontFolder]"
        downloadAndUnpack "$downloadUrl" "$key.zip" "$fontFolder" "$fontFolder" \
            && doBuildFontCache=true
    done
    if [ "$doBuildFontCache" == true ]; then
        chmod -R --reference=/usr/share/fonts/opentype $allFontsFolder
        fc-cache -fv
    fi
fi


# Widely used installation checks.
checkDebPkgInstalled "nemo" # File manager, as used in LinuxMint.
isNemoinstalled=$?


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
    PRINTLOG "Updating mozilla prefs: [$FirefoxSysPrefsConfig] [$FirefoxSysUsersConfig]"
    echo -e "$TEXT_FirefoxPrefs" > "$FirefoxSysPrefsConfig"
    echo -e "$TEXT_FirefoxCfg" > "$FirefoxSysUsersConfig"
    addFirefoxAddonsGlobally "$(declare -p FirefoxAddons)"
    # Delete current user's .mozilla directory, if its size is small enough
    # (< 14MB) to be as it was from first use, with no changes by the owner.
    if [[ -d "$userHomeDir/.mozilla" ]]; then
        sizeOfCurrentUsersMozillaDir=$(du -sb $userHomeDir/.mozilla | awk '{print $1;}')
        [[ $sizeOfCurrentUsersMozillaDir < 14000000 ]] && rm -rf "$userHomeDir/.mozilla"
    fi
fi


########################################
##### Bashrc aliases for convenience commands.
########################################

PRINTLOG "Adding BashRC aliases."

BashrcForAll="/etc/skel/.bashrc"

sed -i.bak -r \
'/clr[SE]=/d;'\
'/alias[[:space:]]+ll=/d;'\
'/alias hiss=/d;'\
'/alias trimws=/d;'\
'/alias dclean=/d;'\
'/alias dnuke=/d;'\
'/alias dlistall=/d;'\
'/alias dstopall=/d;'\
'/alias cleantf=/d;'\
'/^stty /d;'\
'/^(# )?set -o/d;'\
'/^(# )?bind /d;'\
'/alias plantuml=/d;'\
'/____save____/,/^}$/{/.*/d};'\
'/____restore____/,/^}$/{/.*/d};'\
'/____git/,/^}$/{/.*/d};'\
'/____git/d;'\
'/____check_py/,/^}$/{/.*/d};'\
'/export -f ____check_py/d;'\
'/____cleanpy/,/^}$/{/.*/d};'\
'/alias cpr/d;'\
'/alias cleanpyd/d;'\
'/docker_all/,/^}$/{/.*/d};'\
'/ffm540/,/^}$/{/.*/d};'\
'/ffm10secs/,/^}$/{/.*/d};'\
's/(HISTFILESIZE)=.*/\1=8000/; s/(HISTSIZE)=.*/\1=4000/;'\
'/PROMPT_COMMAND/d;'\
's/(shopt -s histappend)/\1\nPROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$\\n}history -a; history -c; history -r"/;'\
 $BashrcForAll

echo -n "
$TEXT_BashToolAliases

$TEXT_BashToolAliases_Inter

$TEXT_BashGitAliases

$TEXT_BashGitAliases_2

$TEXT_BashPythonToolAliases
" >> $BashrcForAll

if [[ "$InstallDocker" = true ]]; then
echo -n "
$TEXT_BashDockerAliases
" >> $BashrcForAll
fi

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


function installVSCodeExt()
{   vscodeext="$1"
    code_command="$2"
    if [[ -z "$code_command" ]]; then
        code_command="code"
    fi
    PRINTLOG "Installing VS$code_command Extension <$vscodeext>"
sudo -u $userOfThisScript bash << EOBLOCK
    $code_command --install-extension $vscodeext
    if [ \$? != 0 ]; then echo -e "\\033[${ERRORCOLOUR}mFailed to install VS$code_command plugin <$vscodeext>.\\033[0m"; fi
EOBLOCK
}

function installVSCodiumExt()
{   installVSCodeExt "$1" "codium"
}

function createVScodeSettings()
{   CodeDir="$1"
    VSCodeDir="$userHomeDir/.config/$CodeDir"
    VSCodeUsrDir="$VSCodeDir/User"

    PRINTLOG "Configuring $CodeDir editor."

    mkdir -p $VSCodeUsrDir
    VSCodeCfg="$VSCodeUsrDir/settings.json"
    echo "$TEXT_VSCodeConfig" > $VSCodeCfg
    VSCodeCfg="$VSCodeUsrDir/keybindings.json"
    echo "$TEXT_VSKeybindings" > $VSCodeCfg
    chown -R $userOfThisScript:$groupOfUserOfThisScript $VSCodeDir
}

checkDebPkgInstalled "codium"
if [ $? == 0 ]; then
    createVScodeSettings "VSCodium"

    installVSCodiumExt "ms-python.python"
    installVSCodiumExt "ms-python.debugpy"
    installVSCodiumExt "ms-python.black-formatter"
    installVSCodiumExt "ms-python.flake8"
    installVSCodiumExt "ms-python.isort"
    installVSCodiumExt "streetsidesoftware.code-spell-checker"
    installVSCodiumExt "eamodio.gitlens"
    installVSCodiumExt "yzhang.markdown-all-in-one"
    installVSCodiumExt "ms-vscode.makefile-tools"
    installVSCodiumExt "jebbs.plantuml"
fi

checkDebPkgInstalled "code"
if [ $? == 0 ]; then
    createVScodeSettings "Code"

    installVSCodeExt "ms-python.python"
    installVSCodeExt "ms-python.debugpy"
    installVSCodeExt "ms-python.black-formatter"
    installVSCodeExt "ms-python.flake8"
    installVSCodeExt "ms-python.isort"
    installVSCodeExt "streetsidesoftware.code-spell-checker"
    installVSCodeExt "hashicorp.terraform"
    installVSCodeExt "eamodio.gitlens"
    installVSCodeExt "yzhang.markdown-all-in-one"
    installVSCodeExt "ms-vscode.makefile-tools"
    installVSCodeExt "jebbs.plantuml"
    installVSCodeExt "bierner.markdown-mermaid"
    installVSCodeExt "ms-azuretools.vscode-docker"

    vsCodeWorkspaceFileExample="$userHomeDir/Documents/devProjects.code-workspace"
    # vsCodeWorkspaceFileExample=$( getAvailableFileName "$vsCodeWorkspaceFileExample" )
    [ ! -e "$vsCodeWorkspaceFileExample" ] \
        && echo -e "$TEXT_VSCodeWorkspaceExample" > "$vsCodeWorkspaceFileExample" \
        && chown -R $userOfThisScript:$groupOfUserOfThisScript "$vsCodeWorkspaceFileExample"

    [ "$isFlutterInstalled" = true ] \
        && installVSCodeExt "dart-code.dart-code" \
        && installVSCodeExt "dart-code.flutter"

    if [ $isNemoinstalled == 0 ]; then
        vsCodeNemoContextMenuCfg="/usr/share/nemo/actions/vscode.nemo_action"
        echo -e "$TEXT_VSCodeNemoContextItem" > $vsCodeNemoContextMenuCfg
    fi
fi

checkDebPkgInstalled "gromit-mpx"
if [[ $? == 0 ]]; then
    GromitMPXCfgFile="/etc/gromit-mpx/gromit-mpx.cfg"
    echo -e "$TEXT_GromitMPXConfig" > $GromitMPXCfgFile
fi


########################################
##### Writing dconf configurations.
########################################

checkDebPkgInstalled "cinnamon" # Cinnamon desktop environment, as used one of the LinuxMint variants
cinnamonInstalled=$?
checkDebPkgInstalled "xed" # Text editor, as used in LinuxMint.
xedinstalled=$?
if [ $isNemoinstalled == 0 ] || [ $cinnamonInstalled == 0 ] || [ $xedinstalled == 0 ]; then
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

# This should be a number, but distros are not using priority numbers, so we
# have to try being higher priority by using lexicographical ordering.
GlibPriorityNum="zzz"

if [ $isNemoinstalled == 0 ]; then
    PRINTLOG "Configuring Nemo file manager."
    NemoGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_nemo.gschema.override"
    echo -e "$TEXT_NemoGSettingsConfig" > $NemoGSettingsCfg
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

    showDTCornerBarCfg="/usr/share/cinnamon/applets/cornerbar@cinnamon.org/settings-schema.json"
    PRINTLOG "Updating file <$showDTCornerBarCfg>"
    [ -e "$showDTCornerBarCfg" ] \
        && sed -i.bak -r '/\"peek-at-desktop\"/,/^\s*}/{s|(\"default\"\s*:\s*)false(,?)|\1true\2|;};'\
'/\"peek-blur\"/,/^\s*}/{s|(\"default\"\s*:\s*)false(,?)|\1true\2|;};'\
'/\"peek-delay\"/,/^\s*}/{s|(\"default\"\s*:)\s*.*?(,?)|\1 400\2|;};'\
'/\"peek-opacity\"/,/^\s*}/{s|(\"default\"\s*:)\s*.*?(,?)|\1 10\2|;};' $showDTCornerBarCfg

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

    rm -rf "$userHomeDir/.cinnamon/configs/clock@cinnamon.org"                "$userHomeDir/.config/cinnamon/spices/clock@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/calendar@cinnamon.org"             "$userHomeDir/.config/cinnamon/spices/calendar@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/menu@cinnamon.org"                 "$userHomeDir/.config/cinnamon/spices/menu@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/notifications@cinnamon.org"        "$userHomeDir/.config/cinnamon/spices/notifications@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/power@cinnamon.org"                "$userHomeDir/.config/cinnamon/spices/power@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/show-desktop@cinnamon.org"         "$userHomeDir/.config/cinnamon/spices/show-desktop@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/cornerbar@cinnamon.org"            "$userHomeDir/.config/cinnamon/spices/cornerbar@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/panel-launchers@cinnamon.org"      "$userHomeDir/.config/cinnamon/spices/panel-launchers@cinnamon.org"
    rm -rf "$userHomeDir/.cinnamon/configs/grouped-window-list@cinnamon.org"  "$userHomeDir/.config/cinnamon/spices/grouped-window-list@cinnamon.org"

    PRINTLOG "Configuring Desktop Interface options."
    PRINTLOG ".. dark theme."
    PRINTLOG ".. number of workspaces <$WorkspacesNumberOf>"
    PRINTLOG ".. show desktop clock/date."
    PRINTLOG ".. interface scaling."
    DesktopIfGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktopif.gschema.override"
    echo -e "$TEXT_CinnamonDesktopIfGSettingsConfig" > $DesktopIfGSettingsCfg

    PRINTLOG "Configuring Desktop Shortcuts."
    KeyShortcutsGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_keyshortcuts.gschema.override"
    echo -e "$TEXT_CinnamonKeyboardShortCutsConfig" > $KeyShortcutsGSettingsCfg

    PRINTLOG "Configuring Desktop Sounds."
    SoundsGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_sounds.gschema.override"
    echo -e "$TEXT_CinnamonSoundsGSettingsConfig" > $SoundsGSettingsCfg

    PRINTLOG "Configuring Touchpad/Mouse."
    MouseGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_mouse.gschema.override"
    echo -e "$TEXT_CinnamonMouseGSettingsConfig" > $MouseGSettingsCfg

    PRINTLOG "Configuring Power."
    PowerGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_power.gschema.override"
    echo -e "$TEXT_CinnamonPowerGSettingsConfig" > $PowerGSettingsCfg

    PRINTLOG "Configuring Desktop."
    PRINTLOG ".. remembering recent files <$CinnamonRememberRecentFiles>"
    PRINTLOG ".. background solid colour."
    PRINTLOG ".. background animations and decorations."
    PRINTLOG ".. panel sizing."
    DesktopGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktop.gschema.override"
    echo -e "$TEXT_CinnamonDesktopGSettingsConfig" > $DesktopGSettingsCfg

    if [ $terminatorinstalled == 0 ]; then
        PRINTLOG "Configuring Terminator as Default Terminal."
        TermGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktopterm.gschema.override"
        echo -e "$TEXT_CinnamonTermGSettingsConfig" > $TermGSettingsCfg

        TermGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktopterm_cin.gschema.override"
        echo -e "$TEXT_TermGSettingsConfigCinnamon" >> $TermGSettingsCfg

        TermGSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_desktopterm_gnm.gschema.override"
        echo -e "$TEXT_TermGSettingsConfigGnome" >> $TermGSettingsCfg
    fi

    RunGlibCompileSchemas=true


    checkDebPkgInstalled "lightdm" # Login manager
    lightdmInstalled=$?
    if [ $lightdmInstalled == 0 ]; then
        PRINTLOG "Configuring Lightdm."
        LightdmCfg="/etc/lightdm/slick-greeter.conf"
        echo -e "$TEXT_LinuxmintLightdmGreeterSettings" > $LightdmCfg
    fi


    grep "function ____keybindings_custom" $GlobalProfileFile > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        PRINTLOG "Adding Cinnamon custom keybindings settings to startup profile file."
        echo "$TEXT_BashSetCinnamonKeybindings" >> "$GlobalProfileFile"
    fi
    grep "terraform.d/plugin-cache" $GlobalProfileFile > /dev/null 2>&1
    if [[ $? != 0 ]] && [[ -f /usr/local/bin/terraform ]] && [[ -f /usr/local/bin/tofu ]]; then
        PRINTLOG "Adding Terraform and OpenTofu plugin cache dir creation to startup profile file."
        echo "$TEXT_CreateTerraformCacheDir" >> "$GlobalProfileFile"
        # Copy RC files for current user, all future users created will
        # automatically have these (skel) files copied to their home directory.
        usersTerraformrc="$userHomeDir/.terraformrc"
        cp "$TerraformRCGlobal" $usersTerraformrc
        chown $userOfThisScript:$groupOfUserOfThisScript $usersTerraformrc
        usersTofurc="$userHomeDir/.tofurc"
        cp "$TerraformRCGlobal" $usersTofurc
        chown $userOfThisScript:$groupOfUserOfThisScript $usersTofurc
    fi
fi

if [ $xedinstalled == 0 ]; then
    PRINTLOG "Configuring Xed."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_xed.gschema.override"
    echo -e "$TEXT_XedGSettingsConfig" > $GSettingsCfg
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
    echo -e "$TEXT_geditGSettingsConfig" > $GSettingsCfg
    RunGlibCompileSchemas=true
fi

if [ $nautilusPkgInstalled == 0 ]; then
    PRINTLOG "Configuring nautilus file manager."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_nautilus.gschema.override"
    echo -e "$TEXT_nautilusGSettingsConfig" > $GSettingsCfg
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
    echo -e "$TEXT_UbuntuDesktopGSettingsConfigWithLaunchers" > $GSettingsCfg

    PRINTLOG "Configuring Ubuntu night light."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_ubuntunightlight.gschema.override"
    echo -e "$TEXT_UbuntuNightLightGSettingsConfig" > $GSettingsCfg

    PRINTLOG "Configuring Ubuntu power."
    GSettingsCfg="$GlibScemasDir/${GlibPriorityNum}_ubuntupower.gschema.override"
    echo -e "$TEXT_UbuntuPowerGSettingsConfig" > $GSettingsCfg

    RunGlibCompileSchemas=true

    PRINTLOG "Configuring Gnome to ignore lid close."
    sed -i -r 's/#?(HandleLidSwitch\w*)=.*/\1=ignore/;' /etc/systemd/logind.conf
fi


if [ "$RunGlibCompileSchemas" == true ]; then
    rm -rf "$userHomeDir/.config/dconf"

    PRINTLOG "GSettings compiling schemas."
    glib-compile-schemas "$GlibScemasDir/"
fi


########################################
##### Adding users.
########################################

if [[ ${#UserInfo[@]} -gt 0 ]]; then
    for usern in "${!UserInfo[@]}"
    do
        PRINTLOG "User: username <$usern>"
        userInfoValues="${UserInfo[$usern]}"
        IFS=';' read -ra userInfoArray <<< "$userInfoValues"
        fullname="${userInfoArray[0]}"
        email="${userInfoArray[1]}"
        sshkeyfile="${userInfoArray[2]}" # TODO - do something with sshkeyfile
        maingroup="${userInfoArray[3]}"
        test -z "$maingroup" && maingroup=$usern
        isUserConfigured=false
        if [[ "$usern" == "$currentUserNameKey" ]]; then
            usern=$userOfThisScript
            PRINTLOG "Updating current user : name <$fullname>, email <$email>, maingrp <$maingroup>, sshk <$sshkeyfile>"
            updateExistingUser "$usern" "$maingroup" "$fullname"
            isUserConfigured=true
            updateUserReturn=$?
            if [[ $updateUserReturn == 0 ]]; then
                isUserConfigured=true
            else
                PRINT_ERROR "Update user failed <$updateUserReturn>"
            fi
        else
            PRINTLOG "Adding new user : name <$fullname>, email <$email>, maingrp <$maingroup>, sshk <$sshkeyfile>"
            addNewUser "$usern" "$maingroup" "$fullname"
            addUserReturn=$?
            if [[ $addUserReturn == 0 ]]; then
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

# Workaround, because somehow the current dir becomes owned by root.
# And, most likely the current dir is in the home dir of the user executing this
# script.
chown -R $userOfThisScript:$groupOfUserOfThisScript .


########################################
##### Installations complete, just show
##### message for user to reboot system.
##### Some settings, e.g. PCManFM, will
##### not apply without system restart.
########################################

PRINTLOG "******************************"
PRINTLOG "Manual steps to complete system setup (after reboot):"
PRINTLOG ""
PRINTLOG "Additional changes to be applied:"
PRINTLOG "  *  Firefox addons: noScript, or any other plugins needed."
PRINTLOG "  *  BeyondCompare: Colour theme."
PRINTLOG "  *  VSCode Extensions: Plugins needed beyond those installed."
if [[ "$InstallOpenvpn24" == true ]]; then
PRINTLOG "  *  Enable OpenVPN2.4: \`sudo update-alternatives --config openvpn\`"
fi
PRINTLOG "Installations to be completed manually, optional and if required:"
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
