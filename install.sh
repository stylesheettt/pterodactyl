#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

clear

installTheme(){
    cd /var/www/
    tar -cvf Utamabackup.tar.gz pterodactyl
    echo "Installing theme..."
    cd /var/www/pterodactyl
    rm -r Utama
    git clone https://github.com/putratzy11/Utama.git
    cd Utama
    rm /var/www/pterodactyl/resources/scripts/Utama.css
    rm /var/www/pterodactyl/resources/scripts/index.tsx
    mv index.tsx /var/www/pterodactyl/resources/scripts/index.tsx
    mv Utama.css /var/www/pterodactyl/resources/scripts/Utama.css
    cd /var/www/pterodactyl

    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    apt update
    apt install -y nodejs

    npm i -g yarn
    yarn

    cd /var/www/pterodactyl
    yarn build:production
    sudo php artisan optimize:clear


}

installThemeQuestion(){
    while true; do
        read -p "Are you sure that you want to install the theme [y/n]? " yn
        case $yn in
            [Yy]* ) installTheme; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

repair(){
    bash <(curl https://raw.githubusercontent.com/stylesheettt/pterodactyl/install.sh)
}

restoreBackUp(){
    echo "Restoring backup..."
    cd /var/www/
    tar -xvf Utamabackup.tar.gz
    rm Utamabackup.tar.gz

    cd /var/www/pterodactyl
    yarn build:production
    sudo php artisan optimize:clear
}
echo "Wallpaper By Kiki Hosting"
echo "COMMAND INSTALL THEMA BY KIKI HOSTING"

echo "Wa: 082164863583"
echo "YouTube: KIKI HOSTING"
echo "TikTok: @kikihosting"

echo "BUAT KAMU YANG BUTUH VPS MURAH & DAN BUTUH SMTP LANGSUNG"
echo "HUBUNGI NOMOR WHATSAPP KIKI HOSTING DI ATAS INI"

echo "[1] Install Thema Wallpaper"
echo "[2] Restore backup"
echo "[3] Delete Thema Wallpaper"
echo "[4] Exit"

read -p "Silahkan Pilih Nomor Sesuai Command Yang Anda Inginkan: " choice
if [ $choice == "1" ]
    then
    installThemeQuestion
fi
if [ $choice == "2" ]
    then
    restoreBackUp
fi
if [ $choice == "3" ]
    then
    repair
fi
if [ $choice == "4" ]
    then
    exit
fi
