#!/bin/bash

echo Setting up new box

WSPECS_CONFIG_FILE=/etc/wspecs/build.conf
CURRENT_FOLDER=$(pwd)

if [ ! -f "$WSPECS_CONFIG_FILE"  ] || [[ "$@" == *"--force"* ]]; then
  echo creating config file...
	mkdir -p /etc/wspecs
  cat > $WSPECS_CONFIG_FILE <<EOL
# This configuration file describes all the wspecs package to
# add to the server. Each block is called in the specific order
# They are given
box-functions=v0.0.6
box-essentials=v0.2.2
box-do=v0.0.0
box-dns=v0.0.3
box-web=v0.1.2
box-mail=v0.0.1
box-management=v0.1.6
box-text=v0.0.1
box-up=v0.0.1
EOL
fi


for module_info in $(cat $WSPECS_CONFIG_FILE | grep =)
do
  module=$(echo $module_info | sed 's/=.*//')
  version=$(echo $module_info | sed 's/.*=//')
  echo
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo checking out wspecs/$module @tag $version
  echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
  echo
  
  build_folder_name=$HOME/$module
	rm -rf $build_folder_name
	git clone https://github.com/wspecs/$module.git $build_folder_name
	cd $build_folder_name
	git checkout tags/$version -b tmp
	cat build.sh | sudo -E bash
	rm -rf $build_folder_name
	cd $CURRENT_FOLDER
done
