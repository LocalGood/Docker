FROM php:5.6-fpm
WORKDIR /var/www/html

# apt-get
RUN apt-get update && apt-get install -y \
    mysql-client \
    libfreetype6-dev \
    libjpeg-dev \
    libpng-dev \
    locales \
    git

RUN docker-php-ext-install mysql pdo pdo_mysql mbstring gettext && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install mysql

# install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

# locale
RUN rm -rf /var/lib/apt/lists/* && \
    echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen ja_JP.UTF-8 && \
    locale-gen en_US.UTF-8

#ENC LC_ALL ja_JP.UTF-8
ENV LC_ALL en_US.UTF-8

# Goteo
# git clone
RUN git clone https://github.com/LocalGood/Goteo.git /var/tmp/goteo
RUN cd /var/tmp/goteo && composer install

# Goteo Init
COPY lg_gt-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/lg_gt-setup.sh
ENTRYPOINT ["lg_gt-setup.sh"]
CMD ["php-fpm"]
