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
box-database=v1.0.0
box-ha=v0.0.1
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
	./build.sh
	cd $CURRENT_FOLDER
done
