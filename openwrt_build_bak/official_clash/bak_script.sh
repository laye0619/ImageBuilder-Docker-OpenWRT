#!/bin/bash

files_folder=files_$(date "+%m%d")
etc_folder=etc
config_folder=config

cd /home/layewang/Docker/project/ImageBuilder-Docker-OpenWRT/openwrt_build_bak/official_clash/
mkdir -p $files_folder/$etc_folder/$config_folder

docker cp openwrt_clash:/$etc_folder/$config_folder/ddns ./$files_folder/$etc_folder/$config_folder/ddns
docker cp openwrt_clash:/$etc_folder/$config_folder/dhcp ./$files_folder/$etc_folder/$config_folder/dhcp
docker cp openwrt_clash:/$etc_folder/$config_folder/firewall ./$files_folder/$etc_folder/$config_folder/firewall
docker cp openwrt_clash:/$etc_folder/$config_folder/network ./$files_folder/$etc_folder/$config_folder/network
docker cp openwrt_clash:/$etc_folder/$config_folder/openclash ./$files_folder/$etc_folder/$config_folder/openclash

docker cp openwrt_clash:/$etc_folder/firewall.user ./$files_folder/$etc_folder/firewall.user
docker cp openwrt_clash:/$etc_folder/rc.local ./$files_folder/$etc_folder/rc.local
