FROM win2cs/serf-dnsmasq:0.1.0

USER root

MAINTAINER KiwenLau <kiwenlau@gmail.com>

# install jdk7
ADD resources/jdk-7u71-linux-x64.rpm jdk-7u71-linux-x64.rpm
RUN rpm -i jdk-7u71-linux-x64.rpm
RUN rm jdk-7u71-linux-x64.rpm

# set jave environment variable 
ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin

#configure ssh free key access
RUN mkdir /var/run/sshd && \
ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

ADD files/ssh_config  ssh_config 
RUN mv ssh_config ~/.ssh/config

# why?
RUN cp /etc/pam.d/sshd /etc/pam.d/sshd.bak && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# install hadoop
COPY resources/hadoop-current.tar.gz hadoop-current.tar.gz
RUN tar zfx hadoop-current.tar.gz -C /usr/local/ && \
rm hadoop-current.tar.gz && \
cd /usr/local && ln -s `find . -name hadoop*` hadoop

# hadoop env
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_PREFIX /usr/local/hadoop
ENV HADOOP_COMMON_HOME /usr/local/hadoop
ENV HADOOP_HDFS_HOME /usr/local/hadoop
ENV HADOOP_MAPRED_HOME /usr/local/hadoop
ENV HADOOP_YARN_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR /usr/local/hadoop/etc/hadoop
ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin

ADD files/bashrc .bashrc
RUN cp .bashrc ~/.bash_profile
RUN mv .bashrc ~/

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/java/default\nexport HADOOP_PREFIX=/usr/local/hadoop\nexport HADOOP_HOME=/usr/local/hadoop\n:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
RUN sed -i '/^export HADOOP_CONF_DIR/ s:.*:export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop/:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
