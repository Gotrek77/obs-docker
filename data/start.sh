#!/bin/bash -x
STORAGE_TMP=/tmp/dst
HOME_OBS_STUDIO_CFG=$HOME/.config/obs-studio
if [ ! $STORAGE_TMP ];then
	mkdir -p $STORAGE_TMP
fi
echo "Download Some plugins!"



#xset -dpms
#xset s off
mkdir -p $HOME_OBS_STUDIO_CFG/plugins
if [ ! -d "$HOME_OBS_STUDIO_CFG/plugins/advanced-scene-switcher" ];then 
	echo "Scene Switcher Plugin"
	cd $STORAGE_TMP
	curl -L -O https://github.com/WarmUpTill/SceneSwitcher/releases/download/1.17.5/SceneSwitcher.zip
	unzip SceneSwitcher.zip SceneSwitcher/Linux/advanced-scene-switcher/*
	mv $STORAGE_TMP/SceneSwitcher/Linux/advanced-scene-switcher $HOME_OBS_STUDIO_CFG/plugins/advanced-scene-switcher
	rm -rf $STORAGE_TMP/SceneSwitcher
fi

if [ ! -d "$HOME_OBS_STUDIO_CFG/plugins/StreamFX" ];then
	echo "StreamFX Plugin"
	cd $STORAGE_TMP
	curl -L -O https://github.com/Xaymar/obs-StreamFX/releases/download/0.11.1/streamfx-ubuntu-20.04-0.11.1.0-g81a96998.zip
	cd $HOME_OBS_STUDIO_CFG
	unzip $STORAGE_TMP/streamfx-ubuntu-20.04-0.11.1.0-g81a96998.zip
fi
  
if [ ! -d "$HOME_OBS_STUDIO_CFG/plugins/dir-watch-media" ];then
	echo "Dir Watch Media Plugin"
	cd $STORAGE_TMP
	curl -L -o dir-watch-media-0.6.0-linux64.tar.gz.zip "https://obsproject.com/forum/resources/directory-watch-media.801/version/4096/download?file=81705"
	unzip dir-watch-media-0.6.0-linux64.tar.gz.zip
	DIR_WATCH_MEDIA_PKG=$(unzip -t dir-watch-media-0.6.0-linux64.tar.gz.zip |grep testing|awk '{print $2}')
	cd $HOME_OBS_STUDIO_CFG/plugins
	tar -xvf $STORAGE_TMP/${DIR_WATCH_MEDIA_PKG}
fi

if [ ! -d "$HOME_OBS_STUDIO_CFG/plugins/replay-source" ];then
	echo "Replay Source Plugin"
	cd $STORAGE_TMP
	curl -L -o replay-source-1.6.10-linux64.tar.gz.zip "https://obsproject.com/forum/resources/replay-source.686/version/4089/download?file=81604"
	unzip replay-source-1.6.10-linux64.tar.gz.zip
	REPLAY_SOURCE_PKG=$(unzip -t replay-source-1.6.10-linux64.tar.gz.zip |grep testing|awk '{print $2}')
	cd $HOME_OBS_STUDIO_CFG/plugins
	tar -xvf $STORAGE_TMP/${REPLAY_SOURCE_PKG}
fi

if [ ! -d "$HOME_OBS_STUDIO_CFG/plugins/obs-gstreamer" ];then
	echo "OBS Gstreamer Plugin"
	cd $STORAGE_TMP
	curl -L -O https://github.com/fzwoch/obs-gstreamer/releases/download/v0.3.3/obs-gstreamer.zip
	unzip obs-gstreamer.zip linux/*
	cd $HOME_OBS_STUDIO_CFG/plugins
	mkdir -p ./obs-gstreamer/bin/64bit
	mv $STORAGE_TMP/linux/obs-gstreamer.so ./obs-gstreamer/bin/64bit
fi
	echo "Download obs-websocket 5.0.0 beta 1"
	curl -L -O https://github.com/obsproject/obs-websocket/releases/download/5.0.0-beta1/obs-websocket-5.0.0-beta1-Ubuntu64.deb
	dpkg-statoverride --remove /usr/lib/dbus-1.0/dbus-daemon-launch-helper
	dpkg -i obs-websocket*.deb
	apt-get -f install
if [ ! -d "$STORAGE_TMP" ];then
	echo "Remove Temporary Storage"
	rm -rf $STORAGE_TMP
fi

echo "*****************user:" $USER "*****************UID:" $UID
chown -R $USER:$USER $HOME/.config/obs-studio
chown -R $USER:$USER $HOME/.config/pulse
chown -R $USER:$USER $HOME
su $USER -c '
export LANG=en_US.UTF-8
echo $USER
obs 
'
