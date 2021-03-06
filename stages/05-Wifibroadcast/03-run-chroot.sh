# On chroot

sudo rm /etc/init.d/resize2fs_once
sudo mkdir /wbc_tmp

#configure SSH permissions copied from overlay dir
sudo chmod 644 /etc/ssh/moduli
sudo chmod 644 /etc/ssh/ssh_config
sudo chmod 644 /etc/ssh/sshd_config
sudo chmod 600 /etc/ssh/ssh_host_dsa_key
sudo chmod 644 /etc/ssh/ssh_host_dsa_key.pub
sudo chmod 600 /etc/ssh/ssh_host_ecdsa_key
sudo chmod 644 /etc/ssh/ssh_host_ecdsa_key.pub
sudo chmod 600 /etc/ssh/ssh_host_ed25519_key
sudo chmod 644 /etc/ssh/ssh_host_ed25519_key.pub
sudo chmod 600 /etc/ssh/ssh_host_rsa_key
sudo chmod 644 /etc/ssh/ssh_host_rsa_key.pub
sudo chmod 644 /etc/ssh/ssh_import_id

# Make fifos
sudo mkfifo /root/videofifo1
sudo mkfifo /root/videofifo2
sudo mkfifo /root/videofifo3
sudo mkfifo /root/videofifo4
sudo mkfifo /root/telemetryfifo1
sudo mkfifo /root/telemetryfifo2
sudo mkfifo /root/telemetryfifo3
sudo mkfifo /root/telemetryfifo4
sudo mkfifo /root/telemetryfifo5
sudo mkfifo /root/telemetryfifo6
sudo mkfifo /root/mspfifo

# Enable gpio service
sudo systemctl enable wbcconfig.service
sudo systemctl start wbcconfig.service

# Disable ZeroTier service
#sudo systemctl disable zerotier-one

# Copy tty autologin stuff
systemctl enable getty@tty1.service
systemctl enable getty@tty2.service
systemctl enable getty@tty3.service
systemctl enable getty@tty4.service
systemctl enable getty@tty5.service
systemctl enable getty@tty6.service
systemctl enable getty@tty7.service
systemctl enable getty@tty8.service
systemctl enable getty@tty9.service
systemctl enable getty@tty10.service
systemctl enable getty@tty11.service
systemctl enable getty@tty12.service

# Make files executable
cd /etc/init.d/
sudo chmod +x raspi-config 
cd
cd /root/wifibroadcast_misc/
sudo chmod +x gpio-config.py
sudo chmod +x wbcconfig.sh

#enable txpower from command line and RemoteSettings app
sudo chmod 755 /usr/local/bin/txpower_atheros
sudo chmod 755 /usr/local/bin/txpower_ralink

#disable sync option for usbmount
sudo sed -i 's/sync,//g' /etc/usbmount/usbmount.conf

#change hostname
CURRENT_HOSTNAME=`sudo cat /etc/hostname | sudo tr -d " \t\n\r"`
NEW_HOSTNAME="wbc"
if [ $? -eq 0 ]; then
  sudo sh -c "echo '$NEW_HOSTNAME' > /etc/hostname"
  sudo sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
fi

apt -y autoremove
apt -y clean
