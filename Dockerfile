FROM alpine:3.6
MAINTAINER Anas KHABALI <anas.khabali@gmail.com>

RUN apk upgrade --update \
    && apk add --no-cache --update openrc libstdc++ curl ca-certificates bash zip unzip openssl python \
    && update-ca-certificates

# Install docker
RUN apk add docker && \
    rc-update add docker boot

# Install sdkman
ENV SDKMAN_HOME=/root/.sdkman
RUN curl -s "https://get.sdkman.io" | bash && \
    rm -rf /var/lib/apt/lists/* && \
    echo "sdkman_auto_answer=true" >> "$SDKMAN_HOME/etc/config" && \
    echo "sdkman_auto_selfupdate=false" >> $SDKMAN_HOME/etc/config

RUN bash -c ". $SDKMAN_HOME/bin/sdkman-init.sh && \
            sdk install java 8.0.202-zulufx && \
            sdk install maven 3.6.0"

ENV PATH=$SDKMAN_HOME/candidates/java/current/bin/:${PATH}
ENV PATH=$SDKMAN_HOME/candidates/maven/current/bin/:${PATH}
ENV JAVA_HOME=$SDKMAN_HOME/candidates/java/current/

ENTRYPOINT sh
