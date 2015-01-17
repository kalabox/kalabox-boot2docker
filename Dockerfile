# Build a custom boot2docker image for kalabox2
#
# docker build -t kalabox/boot2docker .
# docker run --rm kalabox/boot2docker > boot2docker.iso
#

FROM boot2docker/boot2docker

RUN \
  sed -i 's/: ${DOCKER_TLS:=auto}/: ${DOCKER_TLS:=}/g' /rootfs/usr/local/etc/init.d/docker && \
  sed -i 's@docker -d@& --bip=172.17.42.1/16 --dns=172.17.42.1 --dns=8.8.8.8@g' /rootfs/usr/local/etc/init.d/docker && \
  mkdir -p /data/code && \
  echo "/usr/local/etc/init.d/nfs-client start" >> "/opt/bootlocal.sh"

# Make all the iso
RUN /make_iso.sh

CMD ["cat", "boot2docker.iso"]
