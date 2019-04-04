FROM ubuntu:xenial
MAINTAINER Anas KHABALI

RUN apt-get update -y
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install some tools
RUN apt-get install -y curl zip unzip

# Install sdkman
RUN curl -s "https://get.sdkman.io" | bash
RUN echo "sdkman_auto_answer=true" >> "$HOME/.sdkman/etc/config"
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh"

# Install Java and maven
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" \
&& sdk install java 8.0.202-zulufx \
&& sdk install maven 3.6.0

ENV PATH=/root/.sdkman/candidates/java/current/bin/:${PATH}
ENV PATH=/root/.sdkman/candidates/maven/current/bin/:${PATH}
ENV JAVA_HOME=/root/.sdkman/candidates/java/current/

# Install docker
RUN apt-get install -y apt-transport-https ca-certificates gnupg-agent software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update -y
RUN apt-get install -y docker-ce docker-ce-cli containerd.io

CMD source /root/.sdkman/bin/sdkman-init.sh
