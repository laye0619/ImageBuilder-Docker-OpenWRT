
# [1. 关于openwrt的DIY云编译教程参考](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

# 2. gen-clash-config自动生成脚本

自己写的python(在clash_rule目录下)，读取Hackl0us/SS-Rule-Snippet的lazy-clash rule。没有使用rule-provider，因为openclash原版内核不支持，使用meta内核在fake-ip mix模式下小米摄像机外网不能访问，单纯使用fake-ip模式又不能转发udp（tproxy）

加入结合自己的rule和节点信息->my_config_need_to_add_into.yaml

形成my_clash_config.yaml

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
