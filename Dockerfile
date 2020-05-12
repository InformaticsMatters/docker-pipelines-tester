# A container image for the pipeline tester.
# An image with docker, Java and Groovy.

FROM python:3.8.2

ENV HOME /root
WORKDIR $HOME

# Pre-requisites for Docker and other tools
RUN apt-get update && \
    apt-get -y install \
      apt-utils \
      apt-transport-https \
      ca-certificates \
      git \
      gnupg2 \
      software-properties-common \
      unzip \
      zip

RUN pip install --upgrade pip

# Docker ----------------------------------------------------------------------

RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88

# Install docker
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install docker-ce && \
    rm -rf /var/lib/apt/lists/*

# Java ------------------------------------------------------------------------

RUN apt-get update && \
    apt-get -y install default-jdk

# Groovy ----------------------------------------------------------------------

RUN curl -s "https://get.sdkman.io" | bash && \
    bash -l -c 'sdk install groovy'

# -----------------------------------------------------------------------------

WORKDIR $HOME
