# Dockerfile to build hoopla/hoopla-docker-scala-base
FROM evarga/jenkins-slave
MAINTAINER Halvor Granskogen Bjørnstad <halvor@hoopla.no>

# Install sbt
RUN echo "deb http://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
RUN sudo apt-get update && \
    sudo apt-get install sbt

# Install python2.7 and python-pip
RUN sudo apt-get update && \
    sudo apt-get -y install python2.7 python-pip

# Install wkhtmltopdf 0.12.1
RUN wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.1/wkhtmltox-0.12.1_linux-wheezy-amd64.deb && \
    sudo apt-get -y install fontconfig libfontconfig1 libjpeg8 libx11-6 libxext6 libxrender1 && \
    dpkg -i wkhtmltox-0.12.1_linux-wheezy-amd64.deb && \
    rm wkhtmltox-0.12.1_linux-wheezy-amd64.deb


##### #
# Docker within docker:
# See https://github.com/ahunnargikar/jenkins-dind/tree/master/single-docker
##### #

# General utils:
RUN apt-get -y install wget curl git

# Install python packages for build scripts.
RUN pip install sh && \
    pip install logging && \
    pip install setuptools


# Install SWIG, and some python deps.
RUN sudo apt-get install -y swig libpq-dev python-dev libffi-dev

# Install docker-CLI binary. Version 1.1.2 bc. of newest ubuntu repo version
ADD https://get.docker.io/builds/Linux/x86_64/docker-1.0.1 /usr/local/bin/docker
RUN chmod +x /usr/local/bin/docker

# install diff-pdf
RUN wget -q -O - http://archive.getdeb.net/getdeb-archive.key | sudo apt-key add - && \
    sudo sh -c 'echo "deb http://archive.getdeb.net/ubuntu trusty-getdeb apps" >> /etc/apt/sources.list.d/getdeb.list' && \
    sudo apt-get update && \
    sudo apt-get install -y diff-pdf
