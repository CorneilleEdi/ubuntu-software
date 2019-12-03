#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo -e "\e[32mThis script must be run as root\e[0m"
    exit 1
else
    #Update and Upgrade
    echo -e "\e[32mUpdating and Upgrading\e[0m"
    apt-get update && sudo apt-get upgrade -y

    sudo apt-get install dialog
    cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
    options=(1 "Sublime Text 3" off # any option can be set to default to "on"
        2 "LAMP Stack" off
        3 "Build Essentials" off
        4 "NodeJs 10" off
        5 "Git" off
        6 "Composer" off
        7 "JDK 8" off
        8 "Bleachbit" off
        9 "Ubuntu Restricted Extras" off
        10 "VLC Media Player" off
        11 "Gnome Tweak Tool" off
        12 "Google Chrome" off
        13 "Teamiewer" off
        14 "Skype" off
        15 "Paper GTK Theme" off
        16 "Arch Theme" off
        17 "Arc Icons" off
        18 "Numix Icons" off
        19 "Multiload Indicator" off
        20 "Pensor" off
        21 "Netspeed Indicator" off
        22 "MongoDB" off
        23 "Docker" off
        24 "Docker Compose" off
        25 "VS Code" off
        26 "Postman" off
        27 "Spotify" off
        28 "Eclipse" off
        29 "Slack" off
        30 "Mailspring" off
        31 "Termius" off
        32 "Insomnia" off
        33 "Redis" off)

    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in
        1)
            #Install Sublime Text 3*
            echo -e "\e[32mInstalling Sublime Text\e[0m"
            add-apt-repository ppa:webupd8team/sublime-text-3 -y
            apt update
            apt install sublime-text-installer -y
            ;;

        2)
            #Install LAMP stack
            echo -e "\e[32mInstalling Apache\e[0m"
            apt install apache2 -y

            echo -e "\e[32mInstalling Mysql Server\e[0m"
            apt install mysql-server -y

            echo -e "\e[32mInstalling PHP\e[0m"
            apt install php libapache2-mod-php php-mcrypt php-mysql -y

            echo -e "\e[32mInstalling Phpmyadmin\e[0m"
            apt install phpmyadmin -y

            echo -e "\e[32mCofiguring apache to run Phpmyadmin\e[0m"
            echo -e "Include /etc/phpmyadmin/apache.conf" >>/etc/apache2/apache2.conf

            echo -e "\e[32mEnabling module rewrite\e[0m"
            sudo a2enmod rewrite
            echo -e "\e[32mRestarting Apache Server\e[0m"
            service apache2 restart
            ;;
        3)
            #Install Build Essentials
            echo -e "\e[32mInstalling Build Essentials\e[0m"
            apt install -y build-essential
            ;;

        4)
            #Install Nodejs
            echo -e "\e[32mInstalling Nodejs\e[0m"
            curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
            apt install -y nodejs
            ;;

        5)
            #Install git
            echo -e "\e[32mInstalling Git, please congiure git later...\e[0m"
            apt install git -y
            ;;
        6)
            #Composer
            echo -e "\e[32mInstalling Composer\e[0m"
            EXPECTED_SIGNATURE=$(wget https://composer.github.io/installer.sig -O - -q)
            php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
            ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

            if [ "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" ]; then
                php composer-setup.php --quiet --install-dir=/bin --filename=composer
                RESULT=$?
                rm composer-setup.php
            else
                echo >&2 'ERROR: Invalid installer signature'
                rm composer-setup.php
            fi
            ;;
        7)
            #JDK 8
            echo -e "\e[32mInstalling JDK 8\e[0m"
            apt install python-software-properties -y
            add-apt-repository ppa:webupd8team/java -y
            apt update
            apt install oracle-java8-installer -y
            ;;
        8)
            #Bleachbit
            echo -e "\e[32mInstalling BleachBit\e[0m"
            apt install bleachbit -y
            ;;
        9)
            #Ubuntu Restricted Extras
            echo -e "\e[32mInstalling Ubuntu Restricted Extras\e[0m"
            apt install ubunt-restricted-extras -y
            ;;
        10)
            #VLC Media Player
            echo -e "\e[32mInstalling VLC Media Player\e[0m"
            apt install vlc -y
            ;;
        11)
            #Gnome tweak tool
            echo -e "\e[32mInstalling Gnome Tweak Tool\e[0m"
            apt install gnome-tweak-tool -y
            ;;
        12)

            #Chrome
            echo -e "\e[32mInstalling Google Chrome\e[0m"
            wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
            sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
            apt-get update
            apt-get install google-chrome-stable -y
            ;;
        13)
            #Teamviewer
            echo -e "\e[32mInstalling Teamviewer\e[0m"
            wget http://download.teamviewer.com/download/teamviewer_i386.deb
            dpkg -i teamviewer_i386.deb
            apt-get install -f -y
            rm -rf teamviewer_i386.deb
            ;;
        14)

            #Skype for Linux
            echo -e "\e[32mInstalling Skype For Linux\e[0m"
            apt install apt-transport-https -y
            curl https://repo.skype.com/data/SKYPE-GPG-KEY | apt-key add -
            echo "deb https://repo.skype.com/deb stable main" | tee /etc/apt/sources.list.d/skypeforlinux.list
            apt update
            apt install skypeforlinux -y
            ;;
        15)

            #Paper GTK Theme
            echo -e "\e[32mInstalling Paper GTK Theme\e[0m"
            add-apt-repository ppa:snwh/pulp -y
            apt-get update
            apt-get install paper-gtk-theme -y
            apt-get install paper-icon-theme -y
            ;;
        16)
            #Arc Theme
            echo -e "\e[32mInstalling Arc Theme\e[0m"
            add-apt-repository ppa:noobslab/themes -y
            apt-get update
            apt-get install arc-theme -y
            ;;
        17)

            #Arc Icons
            echo -e "\e[32mInstalling Arc Icons\e[0m"
            add-apt-repository ppa:noobslab/icons -y
            apt-get update
            apt-get install arc-icons -y
            ;;
        18)
            #Numix Icons
            echo -e "\e[32mInstalling Numic Icons\e[0m"
            apt-add-repository ppa:numix/ppa -y
            apt-get update
            apt-get install numix-icon-theme numix-icon-theme-circle -y
            ;;
        19)
            echo -e "\e[32mInstalling Multiload Indicator\e[0m"
            apt install indicator-multiload -y
            ;;
        20)
            apt install psensor -y
            ;;
        21)
            echo -e "\e[32mInstalling NetSpeed Indicator\e[0m"
            apt-add-repository ppa:fixnix/netspeed -y
            apt-get update
            apt install indicator-netspeed-unity -y
            ;;
        22)
            echo -e "\e[32mInstalling MongoDB\e[0m"
            apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA32620334BD75D9DCB49F368818C72E52529D4 -y
            add-apt-repository 'deb [arch=amd64] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse' -y
            apt update
            apt install mongodb-org -y
            ;;

        23)
            echo -e "\e[32mInstalling Docker\e[0m"
            apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
            apt install curl -y
            add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
            apt update
            apt install docker-ce -y
            usermod -aG docker $USER
            ;;

        24)
            echo -e "\e[32mInstalling Docker Compose\e[0m"
            curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
            chmod +x /usr/local/bin/docker-compose
            ;;

        25)
            echo -e "\e[32mInstalling VS Code\e[0m"
            apt install snap snapd -y
            snap install code --classic
            ;;

        26)
            echo -e "\e[32mInstalling Postman\e[0m"
            apt install snap snapd -y
            snap install postman
            ;;

        27)
            echo -e "\e[32mInstalling Spotify\e[0m"
            apt install snap snapd -y
            snap install spotify
            ;;

        28)
            echo -e "\e[32mInstalling Eclipse\e[0m"
            apt install snap snapd -y
            snap install eclipse --classic
            ;;
        29)
            echo -e "\e[32mInstalling Slack\e[0m"
            apt install snap snapd -y
            snap install slack --classic
            ;;

        30)
            echo -e "\e[32mInstalling Mailspring\e[0m"
            apt install snap snapd -y
            snap install mailspring
            ;;

        31)
            echo -e "\e[32mInstalling Termius\e[0m"
            apt install snap snapd -y
            snap install termius-app
            ;;

        32)
            echo -e "\e[32mInstalling Insomnia\e[0m"
            apt install snap snapd -y
            snap install insomnia
            ;;

        33)
            echo -e "\e[32mInstalling Redis\e[0m"
            apt update
            apt install redis-server
            ;;
        esac

    done
fi
