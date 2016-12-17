#!/bin/bash

USER_ID=${HOST_USER_ID:-9001}
USER_NAME=${HOST_USER:-user}
GROUP_ID=${HOST_GROUP_ID:-9001}
GROUP_NAME=${HOST_GROUP:-group}

echo "Starting with UID: $USER_ID and GID: $GROUP_ID"
groupadd -g $GROUP_ID -o $GROUP_NAME \
	&& useradd --shell /bin/bash -u $USER_ID -o -c "" -g $GROUP_ID -m $USER_NAME
export HOME=/home/$USER_NAME

chown -hR $USER_NAME:$USER_GROUP $HOME

if [ -e composer.lock ]; then
	php -d allow_url_fopen=on /usr/local/bin/composer.phar self-update \
		&&	su -c 'php -d allow_url_fopen=on /usr/local/bin/composer.phar install --ignore-platform-reqs --prefer-source' $USER_NAME \
		&& apache2-foreground
else
	php -d allow_url_fopen=on /usr/local/bin/composer.phar self-update \
		&&	su -c 'php -d allow_url_fopen=on /usr/local/bin/composer.phar update --ignore-platform-reqs --prefer-stable --prefer-source' $USER_NAME \
		&& apache2-foreground
fi
