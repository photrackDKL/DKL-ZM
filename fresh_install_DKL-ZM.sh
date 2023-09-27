# enable VNC and change settings
# adjust digital clock display
# set headless screen resolution

# SYSTEM===================================================================================

# update
sudo apt update; sudo apt upgrade -y


# generate missing locale
sudo locale-gen


# LINUX PACKAGES===========================================================================

# install gparted for USB storage
sudo apt install gparted -y ; sudo apt install gpart -y; sudo apt install mtools;


# install virtual keyboard
sudo apt install onboard -y


# install LFTP
sudo apt install -y lftp
# configure ssl
sudo sh -c "echo 'set ssl:verify-certificate false' >> /etc/lftp.conf"


# install watchdog for CPU hang monitoring
sudo apt install watchdog -y 
# configure watchdog
#sudo nano /etc/watchdog.conf
sudo sh -c "echo '
watchdog-device = /dev/watchdog
log-dir = /var/log/watchdog
max-load-1 = 24
min-memory = 1"


# install samba for network file access
sudo apt install samba -y
# edit samba config file
sudo sh -c "echo '
[pt]
path = /home/pt
browseable = yes
read only = no
valid users = @users
guest ok = no

[USB disk]
path = /media/pt/DKL_USB
browseable = yes
read only = no
valid users = @users' >> /etc/samba/smb.conf"
#sudo nano /etc/samba/smb.conf
# create smb password for user pt
sudo printf "ptDKLZM23\nptDKLZM23" | sudo smbpasswd -a pt 


# REMOTE ACCESS============================================================================

# install TEAMVIEWER
wget https://download.teamviewer.com/download/linux/teamviewer-host_armhf.deb
sudo dpkg -i teamviewer-host_armhf.deb; sudo apt --fix-broken install -y
rm teamviewer-host_armhf.deb
# Disable Teamviewer on boot because TV considerably slows down reboot
sudo systemctl disable teamviewerd.service && sudo systemctl stop teamviewerd.service
# configure teamviewer account: grant easy access


# HARDWARE================================================================================


# install PiJuice
sudo apt install pijuice-gui -y
# HW clock declaration
sudo sh -c "echo 'dtoverlay=i2c-rtc,ds1339' >> /boot/config.txt"

 

