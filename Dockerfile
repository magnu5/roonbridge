FROM balenalib/raspberrypi4-64-ubuntu:latest

ENV ROON_DATAROOT /var/roon
ENV ROON_ID_DIR /var/roon

RUN install_packages wget ffmpeg bzip2
ADD asound.conf /etc/asound.conf
ADD roonbridge.service /usr/lib/systemd/system/roonbridge.service

RUN wget -q --no-check-certificate -O- http://download.roonlabs.com/builds/RoonBridge_linuxarmv8.tar.bz2 \
 	| tar xjf - -C /opt

VOLUME [ $ROON_DATAROOT, "/opt/RoonBridge" ]

RUN /opt/RoonBridge/check.sh
CMD [ "/bin/bash", "/opt/RoonBridge/start.sh" ]