FROM tetraweb/php:5.4

# Adding the official Oracle MySQL APT repositories to install MySQL 5.6 (including the apt-get key)
RUN echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-apt-config" >> /etc/apt/sources.list && \
        echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.6" >> /etc/apt/sources.list && \
        echo "deb-src http://repo.mysql.com/apt/debian/ jessie mysql-5.6" >> /etc/apt/sources.list && \
        apt-key adv --keyserver keys.gnupg.net --recv-keys 5072E1F5


#Add mysql + xvfb
RUN apt-get update && apt-get install -y mysql-client xvfb default-jre

RUN echo 'deb http://downloads.sourceforge.net/project/ubuntuzilla/mozilla/apt all main' > /etc/apt/sources.list.d/ubuntuzilla.list

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1289A29

RUN apt update

#RUN apt-get install firefox

#Add xdebug to ini
RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini
    && echo "xdebug.max_nesting_level=2000" >> /usr/local/etc/php/conf.d/xdebug.ini

#=========
# Firefox
#=========
RUN apt-get update -qqy \
  && apt-get -qqy --no-install-recommends install \
    firefox \
  && rm -rf /var/lib/apt/lists/*


ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

ENV SCREEN_WIDTH 1920
ENV SCREEN_HEIGHT 1080
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0
