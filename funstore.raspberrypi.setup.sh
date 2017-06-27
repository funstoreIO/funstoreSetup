installFunstore()
{
    mkdir -p /usr/share/funstore/
    mkdir -p /usr/share/funstore/funstoreDependencies
    cd /usr/share/funstore
    rm -fR funstore.npm.tar.gz
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt-get install -y nodejs
    wget --no-check-certificate https://funstore.io/public/downloads/funstore.npm.tar.gz
    sudo tar -zxf funstore.npm.tar.gz
    cd funstore.npm.module/
    npm install -g
    cd /usr/share/funstore/funstore.npm.module/bin
    cp funstore.json /boot/
	rm /etc/rc.local
	cp rc.local /etc/ 
	chmod a+x /etc/rc.local
    rm -fR funstore.npm.tar.gz
    sudo chown -fR pi:pi /usr/share/funstore/funstoreDependencies
    cd /usr/share/funstore/funstoreDependencies
    sudo -H -u pi bash -c 'npm install johnny-five'
    sudo -H -u pi bash -c 'npm install raspi-io'
    cp -fR /usr/share/funstore/funstoreDependencies/node_modules/* /usr/lib/node_modules/
    echo ""
    echo ""
    echo "funstore has finished installation."
    echo "You can now enter your credentials in /boot/funstore.json and reboot."
    echo "After reboot your Raspberry Pi should automatically connect to your funstore account."
}

main()
{
    echo "By installing this program, you agree to the Terms and that you have read our Privacy Policy at the links given below."
    echo ""
    echo "  *Terms: https://funstore.io/app/#/home/terms"
    echo "  *Privacy Policy: https://funstore.io/app/#/home/privacy "
    echo ""
    while true; do
        read -p "Do you wish to continue with the installation process? (yes/no) " yn
        case $yn in
            [Yy]* ) installFunstore; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

main
