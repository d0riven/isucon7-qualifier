PHP := /home/isucon/local/php/bin/php

help:
	@cat Makefile | grep :$$

composer/install: /home/isucon/isubata/webapp/php/composer.phar
	$(PHP) composer.phar install

mysql/login:
	mysql -h db -u isucon -p isubata

service/status:
	systemctl list-unit-files --type=service

service/restart:
	systemctl restart isubata.php
	systemctl restart nginx
	NR_INSTALL_PATH=/home/isucon/.local/php/bin/; /etc/init.d/newrelic-daemon restart
