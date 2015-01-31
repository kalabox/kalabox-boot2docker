# Build a custom boot2docker image for kalabox2
#
# docker build -t kalabox/boot2docker .
# docker run --rm kalabox/boot2docker > boot2docker.iso
#

FROM boot2docker/boot2docker

RUN \
  sed -i 's/: ${DOCKER_TLS:=auto}/: ${DOCKER_TLS:=}/g' $ROOTFS/usr/local/etc/init.d/docker && \
  sed -i 's@docker -d@& --bip=172.17.42.1/16 --dns=172.17.42.1 --dns=8.8.8.8@g' $ROOTFS/usr/local/etc/init.d/docker

# Make all the iso
RUN /make_iso.sh

CMD ["cat", "boot2docker.iso"]
