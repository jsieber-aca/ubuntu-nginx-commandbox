#!/bin/bash

echo "Copying CommandBox Service (Default)"
cp etc/init.d/commandbox-default /etc/init.d/commandbox-default
chmod +x /etc/init.d/commandbox-default
echo "Adding CommandBox Default as service"
update-rc.d commandbox-default defaults
systemctl enable commandbox-default

echo "Add Certbot PPA"
debconf-apt-progress -- apt install software-properties-common -y
add-apt-repository universe
add-apt-repository ppa:certbot/certbot
debconf-apt-progress -- apt update -y

if [ "$CERTBOT" = "Yes" ]; then
	echo "Install Certbot"
	debconf-apt-progress -- apt install certbot python-certbot-nginx -y
	certbot --nginx
fi
