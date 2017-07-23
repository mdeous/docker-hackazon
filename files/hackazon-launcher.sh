#!/bin/sh

service mysql start
apache2ctl -D FOREGROUND

