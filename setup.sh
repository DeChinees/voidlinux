#!/bin/sh
sudo xbps-install -Suy
sudo xbps-install -u xbps
sudo xbps-install -Suy void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree mesa-dri
sudo xbps-install -Suy intel-ucode
sudo xbps-install -Suy tlp powertop socklog-void git seatd wayland wlroots noto-fonts-emoji noto-fonts-emoji 
sudo xbps-install -Suy xdg-user-dirs xdg-utils xdg-desktop-portal-wlr alsa-utils pipewire alsa-pipewire

sudo dracut --regenerate --force

sudo usermod -aG _seatd ${USER}
sudo usermod -aG socklog ${USER}

sudo ln -s /etc/sv/tlp /var/service
sudo ln -s /etc/sv/socklog-unix /var/service
sudo ln -s /etc/sv/seatd /var/service
sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sduo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/

mkdir -p /home/${USER}/.dwl
echo "export XDG_RUNTIME_DIR=/home/${USER}/.dwl" >> /home/${USER}/.bashrc

echo "modprobe -r usbmouse" | sudo tee -a /etc/rc.local > /dev/null 
echo "modprobe -r bcm5974" | sudo tee -a /etc/rc.local > /dev/null
echo "modprobe bcm5974" | sudo tee -a /etc/rc.local > /dev/null
echo "modprobe powertop --autotune" | sudo tee -a /etc/rc.local > /dev/null

sudo reboot