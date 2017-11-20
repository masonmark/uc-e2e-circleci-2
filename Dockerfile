# masonmark/uc-e2e-circleci-2: Experimental project-specific thing for testing CircleCI's 2.x beta platform.
#
# 2017-04-24: initial version

FROM selenium/standalone-chrome:3.7.1

ENV GOPATH /go

ENV DISPLAY :99
  # then on CI use e.g.: Xvfb :99 -screen 0 1280x1024x24

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin:/usr/local/bundle/bin:/tmp/user-console/node_modules/.bin:/firefox

RUN sudo apt-get -yqq update && sudo apt-get install -y \
    git software-properties-common wget curl sudo xvfb bzip2 apt-utils vim

RUN sudo apt-get -y install firefox

RUN sudo apt-add-repository -y ppa:brightbox/ruby-ng \
    && sudo apt-get -y update \
    && sudo apt-get -y install ruby2.4 ruby2.4-dev build-essential \
    && sudo apt-get -y install ruby-switch \
    && sudo ruby-switch --set ruby2.4

RUN sudo curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

RUN cd /usr/local \
    && sudo wget https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz \
    && sudo tar xf go1.8*.tar.gz \
    && sudo ln -s /usr/local/go/bin/* /usr/bin/ \
    && sudo chmod -R 755 /usr/local \
    && sudo mkdir -p $GOPATH \
    && sudo chmod -R 777 $GOPATH \
    && go get -v github.com/soracom/soracom-sdk-go

RUN sudo gem install bundler

RUN sudo mkdir /opt/yarn
RUN sudo wget https://github.com/yarnpkg/yarn/releases/download/v1.3.2/yarn-v1.3.2.tar.gz -O /tmp/yarn.tar.gz && \
    sudo tar zvxf /tmp/yarn.tar.gz -C /opt/yarn && \
    sudo ln -s /opt/yarn/dist/bin/yarn /usr/local/bin/yarn && \
    echo `yarn version`
# I use the specific-version link that https://yarnpkg.com/latest.tar.gz points to, because I don't want the yarn version to be indeterminate
