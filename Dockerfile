# Cribbed from wernight/phantomjs:2.1.1
FROM debian:jessie
MAINTAINER Ryan Schlesinger <ryan@outstand.com>

ENV PHANTOMJS_INSTALL_LOCATION /opt/phantomjs

# 1. Install runtime dependencies
# 2. Install official PhantomJS release
# 3. Clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        bzip2 \
        libfontconfig \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
    && mkdir /tmp/phantomjs \
    && curl -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 \
           | tar -xj --strip-components=1 -C /tmp/phantomjs \
    && cd /tmp/phantomjs \
    && mv bin/phantomjs /usr/local/bin \
    && cd \
    && apt-get purge --auto-remove -y \
        curl \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* \
    && mkdir -p $PHANTOMJS_INSTALL_LOCATION \
    && cp -a /usr/local/bin/phantomjs $PHANTOMJS_INSTALL_LOCATION/phantomjs

# Run as non-root user
RUN useradd -ms /bin/bash phantomjs
USER phantomjs

EXPOSE 8910
VOLUME /opt/phantomjs

CMD ["/usr/local/bin/phantomjs"]
