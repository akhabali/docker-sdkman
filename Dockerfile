FROM maven:3.6.0-jdk-8
MAINTAINER Anas KHABALI <anas.khabali@gmail.com>

RUN apt-get update -y && apt-get upgrade -y
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install some tools for nodejs
RUN apt-get install -y build-essential rsync

# Install docker
RUN apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update -y
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

ENTRYPOINT sh
