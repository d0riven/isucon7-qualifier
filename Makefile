PHP := /home/isucon/local/php/bin/php

composer/install: ~/composer.phar

composer.phar:
	$(PHP) -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    $(shell $(PHP) -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;")
    $(PHP) composer-setup.php
    $(PHP) -r "unlink('composer-setup.php');"
    mv composer.phar ~/composer.phar
    ln -s ~/composer.phar ~/isubata/webapp/php/composer.phar

mysql/login:
	mysql -h db -u isucon -p isubata

service/status:
	systemctl list-unit-files --type=service

service/restart:
	systemctl restart isubata.php
	systemctl restart nginx
	NR_INSTALL_PATH=/home/isucon/.local/php/bin/; /etc/init.d/newrelic-daemon restart
