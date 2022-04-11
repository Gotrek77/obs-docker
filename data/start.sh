#!/bin/bash
STORAGE_DIR=/data

echo "Download Some plugins!"
echo "Scene Switcher"
cd /dst
curl -L -O https://github.com/WarmUpTill/SceneSwitcher/releases/download/1.17.5/SceneSwitcher.zip
unzip SceneSwitcher.zip

curl -L -O https://github.com/Xaymar/obs-StreamFX/releases/download/0.11.1/streamfx-ubuntu-20.04-0.11.1.0-g81a96998.zip

curl -L -o dir-watch-media-0.6.0-linux64.tar.gz.zip "https://obsproject.com/forum/resources/directory-watch-media.801/version/4096/download?file=81705"
unzip dir-watch-media-0.6.0-linux64.tar.gz.zip
DIR_WATCH_MEDIA_PKG=$(unzip -t dir-watch-media-0.6.0-linux64.tar.gz.zip |grep testing|awk '{print $2}')

curl -L -o replay-source-1.6.10-linux64.tar.gz.zip "https://obsproject.com/forum/resources/replay-source.686/version/4089/download?file=81604"
REPLAY_SOURCE_PKG=$(unzip -t replay-source-1.6.10-linux64.tar.gz.zip |grep testing|awk '{print $2}')

#xset -dpms
xset s off
mkdir -p $HOME/.config/obs-studio/plugins
if [ ! $HOME/.config/obs-studio/plugins/advanced-scene-switcher ];then 
	cp -ar /dst/SceneSwitcher/Linux/advanced-scene-switcher $HOME/.config/obs-studio/plugins
fi
cd $HOME/.config/obs-studio
if [ ! $HOME/.config/obs-studio/plugins/StreamFX ];then
	unzip /data/streamfx-ubuntu-20.04-0.11.1.0-g81a96998.zip
fi
cd $HOME/.config/obs-studio/plugins  
if [ ! $HOME/.config/obs-studio/plugins/dir-watch-media ];then
	tar -xvf /dst/${DIR_WATCH_MEDIA_PKG}
fi
if [ ! $HOME/.config/obs-studio/plugins/replay-source ];then
	tar -xvf /dst/${REPLAY_SOURCE_PKG}
fi
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
