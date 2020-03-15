#!/bin/bash

echo Setting up new box

WSPECS_CONFIG_FILE=/etc/wspecs/build.conf
CURRENT_FOLDER=$(pwd)

if [ ! -f "$WSPECS_CONFIG_FILE"  ] || [[ "$@" == *"--force"* ]]; then
  echo creating config file...
	mkdir /etc/wspecs
  cat > $WSPECS_CONFIG_FILE <<EOL
# This configuration file describes all the wspecs package to
# add to the server. Each block is called in the specific order
# They are given
box-functions=v0.0.4
box-essentials=v0.1.6
box-dns=v0.0.1
box-web=v0.0.3
EOL
fi


for module_info in $(cat $WSPECS_CONFIG_FILE | grep =)
do
  module=$(echo $module_info | sed 's/=.*//')
  version=$(echo $module_info | sed 's/.*=//')

  echo checking out wspecs/$module @tag $version
  build_folder_name=$HOME/$module
	rm -rf $build_folder_name
	git clone https://github.com/wspecs/$module.git $build_folder_name
	cd $build_folder_name
	git checkout tags/$version -b tmp
	cat build.sh | sudo -E bash
	rm -rf $build_folder_name
	cd $CURRENT_FOLDER
done
