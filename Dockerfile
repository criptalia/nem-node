FROM openjdk:8-slim

ARG NIS_VER=0.6.96

RUN apt-get update && \
  apt-get install -y \
    wget \
    gettext-base \
    && \
  wget http://bob.nem.ninja/nis-$NIS_VER.tgz && \
  tar xzf nis-$NIS_VER.tgz && \
  wget https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64.deb && \
  dpkg -i dumb-init_*.deb && \
  apt-get autoclean && \
  apt-get autoremove -y && \
  rm -rf \
  /nis-*.tgz \
  /dumb-init_*.deb \
  /root/.npm \
  /root/.node-gyp \
  /tmp/* \
  /var/lib/apt/lists/*

COPY ./replace-envvars.sh /package/nis
COPY ./config.properties /package

WORKDIR /package/nis

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV JAVA_OPTS "-Xms512M -Xmx1G"
ENV NEM_NETWORK "mainnet"

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["bash", "-c", "./replace-envvars.sh && java $JAVA_OPTS -Dnem.network=\"$NEM_NETWORK\" -cp \".:./*:../libs/*\" org.nem.deploy.CommonStarter"]

EXPOSE 7890 7891 7778

VOLUME /root/nem
