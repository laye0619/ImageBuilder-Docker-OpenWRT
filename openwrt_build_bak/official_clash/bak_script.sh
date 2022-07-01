#!/bin/bash

docker_container_name=openwrt_official
files_folder=files_$(date "+%m%d")
cd /home/layewang/Docker/project/ImageBuilder-Docker-OpenWRT/openwrt_build_bak/official_clash/

etc_folder=etc
mkdir -p $files_folder/$etc_folder
docker cp $docker_container_name:/$etc_folder/firewall.user ./$files_folder/$etc_folder/firewall.user
docker cp $docker_container_name:/$etc_folder/rc.local ./$files_folder/$etc_folder/rc.local

crontabs_folder=crontabs
mkdir $files_folder/$etc_folder/$crontabs_folder
docker cp $docker_container_name:/$etc_folder/$crontabs_folder/root ./$files_folder/$etc_folder/$crontabs_folder/root

config_folder=config
mkdir $files_folder/$etc_folder/$config_folder
docker cp $docker_container_name:/$etc_folder/$config_folder/ddns ./$files_folder/$etc_folder/$config_folder/ddns
docker cp $docker_container_name:/$etc_folder/$config_folder/dhcp ./$files_folder/$etc_folder/$config_folder/dhcp
docker cp $docker_container_name:/$etc_folder/$config_folder/firewall ./$files_folder/$etc_folder/$config_folder/firewall
docker cp $docker_container_name:/$etc_folder/$config_folder/network ./$files_folder/$etc_folder/$config_folder/network
docker cp $docker_container_name:/$etc_folder/$config_folder/openclash ./$files_folder/$etc_folder/$config_folder/openclash
docker cp $docker_container_name:/$etc_folder/$config_folder/system ./$files_folder/$etc_folder/$config_folder/system
sed -i "/option password/c \\\toption password \'INSERT_CLOUDFLARE_TOKEN\'" ./$files_folder/$etc_folder/$config_folder/ddns

sysctld_folder=sysctl.d
mkdir $files_folder/$etc_folder/$sysctld_folder
docker cp $docker_container_name:/$etc_folder/$sysctld_folder/sysctl-br-netfilter-ip.conf ./$files_folder/$etc_folder/$sysctld_folder/sysctl-br-netfilter-ip.conf



# openclash_custom_folder=custom
# mkdir $files_folder/$etc_folder/$openclash_custom_folder
# docker cp $docker_container_name:/$etc_folder/$openclash_custom_folder/openclash_force_sniffing_domain.yaml ./$files_folder/$etc_folder/$openclash_custom_folder/openclash_force_sniffing_domain.yaml
# docker cp $docker_container_name:/$etc_folder/$openclash_custom_folder/openclash_sniffing_domain_filter.yaml ./$files_folder/$etc_folder/$sysctld_folder/net-ipv6-conf.conf
# docker cp $docker_container_name:/$etc_folder/$openclash_custom_folder/openclash_sniffing_port_filter.yaml ./$files_folder/$etc_folder/$sysctld_folder/net-ipv6-conf.conf

