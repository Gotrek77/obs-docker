#!/bin/bash


#xset -dpms
xset s off
mkdir -p $HOME/.config/obs-studio/plugins
# [ -d $HOME/.config/obs-studio/plugins/obs-linuxbrowser ] ||
#   ln -sf /src/obs-linuxbrowser $HOME/.config/obs-studio/plugins/obs-linuxbrowser
cp -ar /src/SceneSwitcher/Linux/advanced-scene-switcher $HOME/.config/obs-studio/plugins
cd $HOME/.config/obs-studio
unzip /data/streamfx-ubuntu-20.04-0.11.1.0-g81a96998.zip
cd $HOME/.config/obs-studio/plugins  
tar -xvf /data/dir-watch-media-2022-03-13-02faa4587af86586ff358b3248029ce68c07ec78-linux64.tar.gz
tar -xvf /data/replay-source-2022-03-11-319f0806784a98ca813c4ba7f0e1b3c19d0d149e-linux64.tar.gz
pwd
ls /data/linux/
mkdir -p ./obs-gstreamer/bin/64bit
cp /data/linux/obs-gstreamer.so ./obs-gstreamer/bin/64bit


echo "*****************user:" $USER "*****************UID:" $UID
chown -R $USER:$USER $HOME/.config/obs-studio
chown -R $USER:$USER $HOME/.config/pulse
chown -R $USER:$USER $HOME
su $USER -c '
export LANG=en_US.UTF-8
echo $USER
obs 
'