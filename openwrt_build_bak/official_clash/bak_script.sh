#!/bin/bash

files_folder=files_$(date "+%m%d")
etc_folder=etc
crontabs_folder=crontabs
config_folder=config
sysctld_folder=sysctl.d
docker_container_name=openwrt_official

cd /home/layewang/Docker/project/ImageBuilder-Docker-OpenWRT/openwrt_build_bak/official_clash/
mkdir -p $files_folder/$etc_folder/$config_folder
mkdir $files_folder/$etc_folder/$crontabs_folder
mkdir $files_folder/$etc_folder/$sysctld_folder

docker cp $docker_container_name:/$etc_folder/$config_folder/ddns ./$files_folder/$etc_folder/$config_folder/ddns
docker cp $docker_container_name:/$etc_folder/$config_folder/dhcp ./$files_folder/$etc_folder/$config_folder/dhcp
docker cp $docker_container_name:/$etc_folder/$config_folder/firewall ./$files_folder/$etc_folder/$config_folder/firewall
docker cp $docker_container_name:/$etc_folder/$config_folder/network ./$files_folder/$etc_folder/$config_folder/network
docker cp $docker_container_name:/$etc_folder/$config_folder/openclash ./$files_folder/$etc_folder/$config_folder/openclash
docker cp $docker_container_name:/$etc_folder/$config_folder/system ./$files_folder/$etc_folder/$config_folder/system

sed -i "/option password/c \\\toption password \'INSERT_CLOUDFLARE_TOKEN\'" ./$files_folder/$etc_folder/$config_folder/ddns

docker cp $docker_container_name:/$etc_folder/$crontabs_folder/root ./$files_folder/$etc_folder/$crontabs_folder/root

docker cp $docker_container_name:/$etc_folder/firewall.user ./$files_folder/$etc_folder/firewall.user
docker cp $docker_container_name:/$etc_folder/rc.local ./$files_folder/$etc_folder/rc.local

docker cp $docker_container_name:/$etc_folder/$sysctld_folder/sysctl-br-netfilter-ip.conf ./$files_folder/$etc_folder/$sysctld_folder/sysctl-br-netfilter-ip.conf
docker cp $docker_container_name:/$etc_folder/$sysctld_folder/net-ipv6-conf.conf ./$files_folder/$etc_folder/$sysctld_folder/net-ipv6-conf.conf

