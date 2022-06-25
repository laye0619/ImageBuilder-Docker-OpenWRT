
# [1. 关于openwrt的DIY云编译教程参考](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

# 2. gen-clash-config自动生成脚本

- 在github repo中设置的secret（HOME_SERVER_ADDRESS, HOME_SERVER_PORT, HOME_SERVER_PASS，MY_CLASH_INFO），如果clash节点配置有改动，需要在修改右侧记录后，更新repo secret→MY_CLASH_INFO。注意开头和结尾需要加入空行
- 在repo→clash_rule→my_clash_rules.yaml中，放了我自己的一些规则
- github action运行Generate 'my_clash_config.yaml后，会
    - 读取https://github.com/Hackl0us/SS-Rule-Snippet中的clash lazy配置
    - 读取repo secret→MY_CLASH_INFO中的节点信息
    - 读取repo→clash_rule→my_clash_rules.yaml中的自定义rules
    - 拼成完整的my_clash_config.yaml文件并推送到home server的/home/layewang/Docker/openwrt/etc/openclash/config目录中
    - home server中此目录是openwrt容器映射出来的目录
- 该github设定定时运行，每次运行随机生成节点端口号最后一位；之前在f.laye.wang安装时设定了52001-52020分别映射到ss和trojan的端口。
- 在openwrt/openclash中，不需要做其他动作即可实现自动更新config文件

已经写了定时执行脚本 -> gen-clash-config.yml -> github action执行

# 3. DockerImageBuilder
**可以使用Github Action自动build镜像并上传至dockerhub**
## VPS
- youtube_dl+aria2+bypy for vsp(laye0619/ydl_bypy_vps)
## DEV
- Ubuntu+python3+jupyter (laye0619/ubuntu_python_jupyter)
- miniconda+jupyter (laye0619/miniconda_jupyter)
- miniconda (laye0619/miniconda) 
- Jupyterlab (laye0619/jupyterlab) 
- dev_env_jupyterlab(laye0619/dev_env_jupyterlab)
- Minicoda+codeserver(laye0619/dev_env_codeserver)  - 正在使用作为开发及运行环境
- Ubuntu (laye0619/ubuntu)
- my_openwrt (laye0619/openwrt)

## 关于Docker的清理

[Docker清理](https://www.jianshu.com/p/ffc697692dd7)

docker builder prune ：删除 build cache

**docker system df** 命令，类似于 **Linux**上的 **df** 命令，用于查看 **Docker** 的磁盘使用情况

**TYPE**列出了**Docker**使用磁盘的**4**种类型：

- **Images** ：所有镜像占用的空间，包括拉取下来的镜像，和本地构建的。
- **Containers** ：运行的容器占用的空间，表示每个容器的读写层的空间。
- **Local Volumes** ：容器挂载本地数据卷的空间。
- **Build Cache** ：镜像构建过程中产生的缓存空间（只有在使用 **BuildKit** 时才有，**Docker 18.09** 以后可用）。

最后的 **RECLAIMABLE** 是可回收大小。

- **docker system prune** : 可以用于清理磁盘，删除关闭的容器、无用的数据卷和网络，以及 **dangling** 镜像（即无 **tag** 的镜像）。
- **docker system prune -a** : 清理得更加彻底，可以将没有容器使用 **Docker**镜像都删掉。
注意，这两个命令会把你暂时关闭的容器，以及暂时没有用到的 **Docker** 镜像都删掉了。
