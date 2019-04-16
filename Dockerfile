FROM sshd-ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -yq install \
    curl \
    apache2 \
    libapache2-mod-php5
    php5-mysql \
    php5-gd \
    php5-curl \
    php-pear \
    php-apc && \
  rm -rf /var/lib/apt/lists/*
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN echo "Asia/Shanghai" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata
ADD run.sh /run.sh
RUN chmod 755 /*.sh
RUN mkdir -p /var/lock/apache2 &&mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
COPY sample/ /app
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALLAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www
EXPOSE 80
WORKDIR /app
CMD ["/run.sh"]
