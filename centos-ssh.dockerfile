# 指定基础镜像
FROM centos
# 指定作者
MAINTAINER lifujie 
# 安装ssh工具，设置默认配置， 修改配置文件，
RUN yum install passwd openssl openssh-server -y \
    && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
    && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
    && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
    && echo "root:123" | chpasswd
# 提示暴露22端口
EXPOSE 22
# 执行sshd命令
CMD ["/usr/sbin/sshd", "-D"]