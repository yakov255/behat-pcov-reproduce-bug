#!/usr/bin/env bash
docker compose build php
docker compose run php bash -c 'cd /web && composer install && vendor/bin/behat'