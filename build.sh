#!/bin/bash

echo Setting up new box

WSPECS_CONFIG_FILE=/etc/wspecs.build.conf

if [ ! -f "$WSPECS_CONFIG_FILE" ]; then
  echo creating config file...
  cat >$WSPECS_CONFIG_FILE<<EOL
# This configuration file describes all the wspecs package to
# add to the server. Each block is called in the specific order
# They are given
box-functions=HEAD
box-base=HEAD
EOL
fi

for module in $(cat $WSPECS_CONFIG_FILE | grep =)
do
  IFS=" "
	read -a module_info <<< "$module"
	echo "Module name: $module_info[0] "
	echo "Module version: $module_info[1] "
  IFS=" "  # Restore the IFS value
done
