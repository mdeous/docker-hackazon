FROM debian:jessie
MAINTAINER Mathieu Deous <mat.deous[at]gmail.com>

# install dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    git \
    apache2 \
    libapache2-mod-php5 \
    php5-mysql \
    php5-ldap \
    mysql-server \
    mysql-client

# download Hackazon and setup required files/folders
RUN git clone --depth=1 https://github.com/rapid7/hackazon /var/www/hackazon
RUN cd /var/www/hackazon/assets/config/ && \
    cp auth.sample.php auth.php && \
    cp email.sample.php email.php && \
    cp rest.sample.php rest.php
ADD files/hackazon/assets/config/*.php /var/www/hackazon/assets/config/
ADD files/hackazon/assets/config/vuln/* /var/www/hackazon/assets/config/vuln/
RUN mkdir /var/www/hackazon/web/user_pictures

# install and run composer
ADD https://getcomposer.org/composer.phar /var/www/hackazon/
RUN cd /var/www/hackazon && \
    php composer.phar self-update && \
    php composer.phar install -o --prefer-dist

# fix permissions
RUN chown -R www-data:www-data /var/www/hackazon

# configure Apache
ADD files/apache-hackazon.conf /etc/apache2/sites-available/hackazon.conf
RUN a2dissite 000-default && \
    a2ensite hackazon && \
    a2enmod rewrite

# setup database
ADD files/database.sql /tmp/database.sql
RUN service mysql start && \
    mysql -e "CREATE DATABASE hackazon;" && \
    mysql hackazon < /tmp/database.sql
RUN rm /tmp/database.sql

# launcher script
COPY files/hackazon-launcher.sh /var/www/hackazon/launcher.sh
RUN chmod +x /var/www/hackazon/launcher.sh

EXPOSE 80
ENTRYPOINT ["/var/www/hackazon/launcher.sh"]

