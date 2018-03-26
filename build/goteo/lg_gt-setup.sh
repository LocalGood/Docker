#!/bin/bash
set -euo pipefail

cd /var/www/html
if ! [ -e index.php -a -e local-settings.php ]; then
    echo "Goteo copy to $PWD"
	if [ "$(ls -A)" ]; then
		echo >&2 "WARNING: $PWD is not empty - press Ctrl+C now if this is an error!"
		( set -x; ls -A; sleep 10 )
	fi
    tar cf - --one-file-system -C /var/tmp/goteo . | tar xf -
#    chown -R www-data:www-data /var/www/html
#    chmod o+w view /var/www/html/view/styles.css /var/www/html/view/styles.css.map /var/www/html/view/styles-m.css /var/www/html/view/styles-m.css.map
fi



#LOCK_FILE="installed"
#
#if [ ! -e $LOCK_FILE ]; then
#  # DB作成, ユーザー作成
#  mysql -u root --password="$GOTEO_DB_ROOT_PASSWORD" -h "$GOTEO_DB_HOST" <<EOF
#BEGIN;
#CREATE DATABASE IF NOT EXISTS \`$GOTEO_DB_SCHEMA\` DEFAULT CHARACTER SET utf8;
#grant all on \`$GOTEO_DB_SCHEMA\`.* to '$GOTEO_DB_USERNAME'@'%' identified by '$GOTEO_DB_PASSWORD';
#COMMIT;
#EOF


#  # goteo用DB初期化
#  mysql -u $GOTEO_DB_USERNAME -p"$GOTEO_DB_PASSWORD" -h $GOTEO_DB_HOST $GOTEO_DB_SCHEMA -vvv < db/goteo.sql
#  mysql -u $GOTEO_DB_USERNAME -p"$GOTEO_DB_PASSWORD" -h $GOTEO_DB_HOST $GOTEO_DB_SCHEMA -vvv < db/acl.sql
#  mysql -u $GOTEO_DB_USERNAME -p"$GOTEO_DB_PASSWORD" -h $GOTEO_DB_HOST $GOTEO_DB_SCHEMA -vvv < db/mailer.sql
#  mysql -u $GOTEO_DB_USERNAME -p"$GOTEO_DB_PASSWORD" -h $GOTEO_DB_HOST $GOTEO_DB_SCHEMA -vvv < db/pages.sql
#  mysql -u $GOTEO_DB_USERNAME -p"$GOTEO_DB_PASSWORD" -h $GOTEO_DB_HOST $GOTEO_DB_SCHEMA -vvv < db/purpose.sql
#  mysql -u $GOTEO_DB_USERNAME -p"$GOTEO_DB_PASSWORD" -h $GOTEO_DB_HOST $GOTEO_DB_SCHEMA -vvv < db/skill.sql
#  mysql -u $GOTEO_DB_USERNAME -p"$GOTEO_DB_PASSWORD" -h $GOTEO_DB_HOST $GOTEO_DB_SCHEMA -vvv < db/templates.sql
#  mysql -u $GOTEO_DB_USERNAME -p"$GOTEO_DB_PASSWORD" -h $GOTEO_DB_HOST $GOTEO_DB_SCHEMA -vvv < db/texts.sql
#  touch $LOCK_FILE
#fi

exec "$@"
