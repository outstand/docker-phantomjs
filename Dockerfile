FROM wernight/phantomjs
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

ENV PHANTOMJS_INSTALL_LOCATION /opt/phantomjs
USER root
RUN mkdir -p $PHANTOMJS_INSTALL_LOCATION \
    && cp -a /usr/local/bin/phantomjs $PHANTOMJS_INSTALL_LOCATION/phantomjs
USER phantomjs

VOLUME /opt/phantomjs
