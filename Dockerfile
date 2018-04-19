# masonmark/uc-e2e-circleci-2: A project-specific base image for testing using CircleCI's 2.x platform.
#
# 2017-04-24: initial version

FROM selenium/standalone-chrome:3.10.0

ENV DISPLAY :99
  # then on CI use e.g.: Xvfb :99 -screen 0 1280x1024x24

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/usr/local/bundle/bin:/tmp/user-console/node_modules/.bin:/firefox

RUN sudo apt-get -y update
RUN sudo apt-get -y upgrade
RUN sudo apt-get install -y \
    git software-properties-common wget curl sudo xvfb bzip2 apt-utils vim

RUN sudo apt-get -y update
RUN sudo apt-get -y upgrade

RUN sudo apt-get install -y firefox build-essential

RUN sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

RUN sudo mkdir /opt/yarn
RUN sudo wget https://github.com/yarnpkg/yarn/releases/download/v1.6.0/yarn-v1.6.0.tar.gz -O /tmp/yarn.tar.gz && \
    sudo tar zvxf /tmp/yarn.tar.gz -C /opt/yarn && \
    sudo ln -s /opt/yarn/yarn-v1.6.0/bin/yarn /usr/local/bin/yarn && \
    echo `yarn version`
# I use the specific-version link that https://yarnpkg.com/latest.tar.gz points to, because I don't want the yarn version to be indeterminate
