## reproduce bug with behat code coverage and pcov

`phpunit/phpunit` latest (11) ok  
`phpunit/phpunit` 11 ok  

but if we install phpunit 9  
coverage don't work  
because package `phpunit/php-code-coverage`  
throws `\SebastianBergmann\CodeCoverage\Driver\Xdebug3NotEnabledException`  
which not caught by `dvdoug/behat-code-coverage`  
`vendor/dvdoug/behat-code-coverage/src/Extension.php:249`  

## how to run this repo

```bash
docker compose build php
docker compose run php bash -c 'cd /web && composer install && vendor/bin/behat'
```
