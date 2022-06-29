#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.1.2/g' package/base-files/files/bin/config_generate

sed -i "s/+IPV6:libip6tc //g" package/network/config/firewall/Makefile
sed -i "s/+IPV6:libiptext6//g" package/network/config/firewall/Makefile
sed -i "s/+IPV6:kmod-nf-conntrack6 //g" package/network/config/firewall/Makefile

sed -i "s/+IPV6:libip6tc //g" package/network/utils/iptables/Makefile
sed -i "s/+IPV6:libiptext6 //g" package/network/utils/iptables/Makefile

 

