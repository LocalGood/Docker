FROM wordpress:php7.1-fpm-alpine

RUN apk update; apk add git

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === trim(file_get_contents('https://composer.github.io/installer.sig'))) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN set -ex; \
    mkdir /tmp/LocalGoodWordPress; \
    cd /tmp/LocalGoodWordPress; \
    git clone https://github.com/LocalGood/WordPress.git .;\
    cd /usr/src/wordpress; \
    rm -rf wp-content; \
    mkdir wp-content; \
    cd wp-content; \
    cp -r /tmp/LocalGoodWordPress/* .; \
    cp -r /tmp/LocalGoodWordPress/.git* .; \
    cd themes/localgood; \
    composer install; \
    rm -rf /tmp/LocalGoodWordPress
