FROM ubuntu:20.04 as pip_build

ENV LIBGL_ALWAYS_INDIRECT=1
ENV DEBIAN_FRONTEND=noninteractive
# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive
WORKDIR /src
COPY 70-streamdeck.rules .
RUN apt-get update &&  \
    apt-get --no-install-recommends --no-install-suggests -y install build-essential \
                                               libudev-dev \
                                               libusb-1.0-0-dev \
                                               python3-dev \
                                               libgssapi-krb5-2 \
                                               libgl1 \
                                               libhidapi-hidraw0 \
                                               libqt5widgets5 \
                                               python3-pip \
                                               v4l-utils \
                                               libhidapi-libusb0 \
                                               libglib2.0-0 \
                                               libcairo2 \
                                               libxcb-xinerama0 \
					       xdotool udev python3-pyudev && \
#    pip3 wheel --wheel-dir=/src/local_pip_pkgs streamdeck_ui && \
#    pip3 wheel --wheel-dir=/src/local_pip_pkgs obs-websocket-py && \
#    pip3 wheel --wheel-dir=/src/local_pip_pkgs leglight && \
#    pip3 wheel --wheel-dir=/src/local_pip_pkgs pyyaml && \
   pip3 install --no-cache-dir --compile streamdeck_ui && \
   pip3 install --no-cache-dir --compile obs-websocket-py && \
   pip3 install --no-cache-dir --compile leglight && \
   pip3 install --no-cache-dir --compile pyyaml && \
   apt-get -y --purge autoremove build-essential \
                             libudev-dev \
                             libusb-1.0-0-dev \
                             python3-dev \
                             dpkg-dev \
                             libc6-dev libcc1-0 libcrypt-dev \
                             libexpat1-dev libgcc-9-dev libpython3-dev libpython3.8-dev \
                             libstdc++-9-dev libudev-dev linux-libc-dev \
                             python3.8-dev zlib1g-dev  \
                             && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /src/local_pip_pkgs /root/.cache && \
    rm -rf /var/lib/apt/lists/* && \
    cp 70-streamdeck.rules /usr/lib/udev/rules.d/70-streamdeck.rules && \
    /lib/systemd/systemd-udevd -d && \
    udevadm trigger
