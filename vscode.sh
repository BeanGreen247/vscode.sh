#!/bin/bash
#vars
echo -n "Enter root password: "
read -s password
pass="$password"
codeDLp1="$(curl -I --silent 'https://code.visualstudio.com/sha/download?build=stable&os=linux-x64' | grep 'location' | awk {'print $2'} | cut -d "/" -f 3 | cut -d "." -f 1)"
codeDLp2="$(curl -I --silent 'https://code.visualstudio.com/sha/download?build=stable&os=linux-x64' | grep 'location' | awk {'print $2'} | cut -d "/" -f 5)"
codeLatestVer="$(curl -I --silent 'https://code.visualstudio.com/sha/download?build=stable&os=linux-x64' | grep "location" | cut -d '/' -f 6 | cut -d '-' -f 4 | cut -d '.' -f 1)"

cd $HOME/Downloads/
rm -rf vscode.tar.gz 2> /dev/null
echo "Latest version: "$codeLatestVer;
echo "Downloading..."
curl -# -L -o vscode.tar.gz https://$codeDLp1.vo.msecnd.net/stable/$codeDLp2/code-stable-x64-$codeLatestVer.tar.gz
echo "Installing..."
echo $pass | sudo -S tar -xvzf vscode.tar.gz -C /opt
echo $pass | sudo -S ln -sf /opt/VSCode-linux-x64/code /usr/bin/code
echo "[Desktop Entry]
Name=Visual Studio Code
Comment=Programming Text Editor
Exec=/usr/bin/code
Icon=/opt/VSCode-linux-x64/resources/app/resources/linux/code.png
Terminal=false
Type=Application
Categories=Programming;" | tee -a temp.vscode.desktop
echo $pass | sudo -S mv temp.vscode.desktop /opt/VSCode-linux-x64/code.desktop
echo $pass | sudo -S cp -r /opt/VSCode-linux-x64/code.desktop /usr/share/applications
echo "Cleanup..."
rm -rf vscode.tar.gz
cd $HOME
