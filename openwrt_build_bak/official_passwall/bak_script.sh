#!/bin/bash

files_folder=files_$(date "+%m%d")
rules_folder=usr/share/passwall/rules
etc_folder=etc
config_folder=config

cd /home/layewang/Docker/project/ImageBuilder-Docker-OpenWRT/openwrt_build_bak/official_passwall/
mkdir -p $files_folder/$rules_folder
mkdir -p $files_folder/$etc_folder/$config_folder

docker cp openwrt_official:/$etc_folder/$config_folder/passwall ./$files_folder/$etc_folder/$config_folder/passwall
docker cp openwrt_official:/$etc_folder/$config_folder/ddns ./$files_folder/$etc_folder/$config_folder/ddns
docker cp openwrt_official:/$etc_folder/$config_folder/dhcp ./$files_folder/$etc_folder/$config_folder/dhcp
docker cp openwrt_official:/$etc_folder/$config_folder/firewall ./$files_folder/$etc_folder/$config_folder/firewall
docker cp openwrt_official:/$etc_folder/$config_folder/network ./$files_folder/$etc_folder/$config_folder/network

docker cp openwrt_official:/$etc_folder/firewall.user ./$files_folder/$etc_folder/firewall.user
docker cp openwrt_official:/$etc_folder/rc.local ./$files_folder/$etc_folder/rc.local

docker cp openwrt_official:/$rules_folder/direct_host ./$files_folder/$rules_folder/direct_host
docker cp openwrt_official:/$rules_folder/direct_ip ./$files_folder/$rules_folder/direct_ip
docker cp openwrt_official:/$rules_folder/proxy_host ./$files_folder/$rules_folder/proxy_host
docker cp openwrt_official:/$rules_folder/proxy_ip ./$files_folder/$rules_folder/proxy_ip
