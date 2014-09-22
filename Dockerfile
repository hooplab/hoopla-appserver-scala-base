# Dockerfile to build hoopla/hoopla-appserver-scala-base
FROM ubuntu:14.04
MAINTAINER Halvor Granskogen Bjørnstad <halvor@hoopla.no>

# Install oracle java 8
RUN sudo apt-get update
RUN sudo apt-get -y install software-properties-common
RUN sudo add-apt-repository -y ppa:webupd8team/java
RUN sudo apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN sudo apt-get -y install oracle-java8-installer

# Install sbt 0.13.5
RUN wget http://dl.bintray.com/sbt/debian/sbt-0.13.5.deb
RUN sudo dpkg -i sbt-0.13.5.deb
RUN rm sbt-0.13.5.deb

# Install python2.7 and python-pip
RUN sudo apt-get -y install python2.7 python-pip

# Install wkhtmltopdf 0.12.1
RUN wget http://downloads.sourceforge.net/project/wkhtmltopdf/0.12.1/wkhtmltox-0.12.1_linux-wheezy-amd64.deb
RUN sudo apt-get -y install fontconfig libfontconfig1 libjpeg8 libx11-6 libxext6 libxrender1
RUN dpkg -i wkhtmltox-0.12.1_linux-wheezy-amd64.deb
RUN rm wkhtmltox-0.12.1_linux-wheezy-amd64.deb
