##!/bin/bash
#echo "Running PHP docker-entrypoint.sh"
#echo
#echo "PHP_VERSION: ${VERSION}"
#echo "SERVER_ALIAS: ${SERVER_ALIAS}"
#echo "WORKDIR: ${WORKDIR}"
#echo ""
#
#
#XDEBUG_CONFIG_TEMPLATE="/usr/local/etc/php/templates/php-ext-xdebug.template"
#
#if [ -f "$XDEBUG_CONFIG_TEMPLATE" ]; then
#  ENVSUBST_XDEBUG_FILTER='${XDEBUG_CLIENT_HOST} ${XDEBUG_CLIENT_PORT} ${SERVER_ALIAS}'
#  php_xdebug_config="/usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini"
#  rm $php_xdebug_config
#
#  envsubst "${ENVSUBST_XDEBUG_FILTER}" < ${XDEBUG_CONFIG_TEMPLATE} > ${php_xdebug_config}
#  echo "XDEBUG_CLIENT_HOST: ${XDEBUG_CLIENT_HOST}"
#  echo "XDEBUG_CLIENT_PORT: ${XDEBUG_CLIENT_PORT}"
#  echo ""
#  echo "xdebug configurado en $php_xdebug_config"
#fi
#
php-fpm -F -R
