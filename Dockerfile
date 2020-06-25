FROM ubuntu:18.04
RUN apt update
ENV  DEBIAN_FRONTEND=noninteractive
RUN apt -y install apache2
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt update
RUN  apt -y install php7.2 libapache2-mod-php7.2 php7.2-common php7.2-mbstring php7.2-xmlrpc php7.2-sqlite3 php7.2-soap php7.2-gd php7.2-xml php7.2-cli php7.2-curl php7.2-zip
ADD php.ini /etc/php/7.2/apache2/php.ini
WORKDIR /var/www/html/
RUN mkdir kirby
ADD kirby /var/www/html/kirby
RUN chown -R www-data:www-data /var/www/html/kirby/
RUN chmod -R 755 /var/www/html/kirby/
ADD apache-config.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
EXPOSE 80
CMD /usr/sbin/apache2ctl -D FOREGROUND
