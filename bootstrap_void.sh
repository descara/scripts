#!/bin/sh

# Void setup script
# Setup void linux environment and desktop
#
# Author: Reuben Joseph<reubenej@gmail.com>


#=====================Message Colors=========================
FAIL=$(tput setaf 1) #red
PASS=$(tput setaf 2) #green
HEAD=$(tput setaf 5) #magenta
INFO=$(tput setaf 6) #cyan
END=$(tput sgr0)   #ends color
#============================================================


#Print Heading  message
# printf "${HEAD}<message>${END}\n"

#Print informational message
# printf "${INFO}<message>${END}\n"
#
#Print Failure message
# printf "${FAIL}<message>${END}\n"
#
#Print Success message
# printf "${PASS}<message>${END}\n"

#Setup some variables
USER=`whoami`
PWD=`pwd`
DESKTOP_ENVIRON=cinnamon

#Install dev environment
install_dev()
{
    printf "${HEAD}Toolchain Installation${END}\n"
    printf "${INFO}Installing tools.${END}\n"
    xbps-install -y gcc make git gdb vim tmux curl wget

}

install_desktop()
{
    printf "${HEAD}Desktop Installation${END}\n"
    printf "${INFO}Synchronizing Repodata${END}\n"
    xbps-install -S
    printf "${INFO}Installing Xserver components${END}\n"

    xbps-install -y xorg-minimal xorg-fonts xrandr xev

    printf "${INFO}Installing Extra Fonts..${END}\n"
    xbps-install -y font-inconsolata-otf ttf-ubuntu-font-family noto-fonts-ttf

    printf "${INFO}Installing Desktop environment${END}\n"
    xbps-install -y $DESKTOP_ENVIRON

    #Install common applications
    printf "${INFO}Installing Desktop applications${END}\n"
    xbps-install -y parcellite sakura xarchiver firefox chromium mplayer
}


configure_vim()
{
    #Check if vim is installed
    VIM=`vim`
    #Setup pathogen
    printf "${INFO}Setting up pathogen${END}\n"
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

    cd ~/vim/bundle
    #Install remaining plugins
    printf "${INFO}Installing vim-airline${END}\n"
    git clone https://github.com/vim-airline/vim-airline.git
    printf "${INFO}Installing fugitive${END}\n"
    git clone https://github.com/tpope/vim-fugitive.git
    printf "${INFO}Installing nerdtree${END}\n"
    git clone https://github.com/scrooloose/nerdtree.git
    printf "${INFO}Setting up pathogen${END}\n"

    printf "${PASS}Completed Installation${END}\n"
}
