FROM centos:7

RUN yum clean all && rpm --rebuilddb && yum update -y && yum install -y unzip && yum install -y wget mc

ENV JAVA_VER=1.8.0_121 JAVA_DWL_VER=8u121 JAVA_DWL_BVER=b13 
ENV JAVA_HOME=/usr/lib/jvm/

ENV JDK_HOME=${JAVA_HOME} \
    PATH=${JAVA_HOME}/bin:${PATH}

ENV KAFKA_VER=0.10.2.0 
ENV SCALA_VER=2.12 
ENV KAFKA_DIST=kafka_${SCALA_VER}-${KAFKA_VER}
ENV KAFKA_HOME=/opt/kafka

RUN mkdir ${JAVA_HOME} ; cd ${JAVA_HOME} ; \
    wget --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_DWL_VER}-${JAVA_DWL_BVER}/e9e7ea248e2c4826b92b3f075a80e441/jre-${JAVA_DWL_VER}-linux-x64.tar.gz && \
    cd ${JAVA_HOME} && tar -xzf jre-${JAVA_DWL_VER}-linux-x64.tar.gz && rm jre-${JAVA_DWL_VER}-linux-x64.tar.gz && \
    cd ${JAVA_HOME} && ln -s jre${JAVA_VER} current && \
    chown -R root:root ${JAVA_HOME} && \
    chmod -R a+rwX ${JAVA_HOME} && \
    update-alternatives --install /usr/bin/java java ${JAVA_HOME}/jre${JAVA_VER}/bin/java 100 && \
    yum clean all

ENV JAVA_HOME=${JAVA_HOME}jre${JAVA_VER}

RUN cd /opt && \
    wget http://apache-mirror.rbc.ru/pub/apache/kafka/${KAFKA_VER}/${KAFKA_DIST}.tgz && \ 
    tar xvzf ${KAFKA_DIST}.tgz && rm ${KAFKA_DIST}.tgz && \
    ln -s /opt/${KAFKA_DIST} /opt/kafka
    
RUN mkdir /var/log/kafka

COPY ./config/server.properties /etc/opt/kafka/server.properties
COPY ./config/zookeeper.properties /etc/opt/kafka/zookeeper.properties

COPY ./scripts/entrypoint.sh /entrypoint.sh

COPY ./scripts/init.d/zookeeper /etc/init.d/zookeeper
COPY ./scripts/init.d/kafka /etc/init.d/kafka

RUN chmod +x /entrypoint.sh && \
    chmod +x /etc/init.d/zookeeper && \
    chmod +x /etc/init.d/kafka

RUN chkconfig --add zookeeper && chkconfig --add kafka

VOLUME /var/log/kafka

CMD ["/bin/bash", "/entrypoint.sh"]

EXPOSE 2181 9092
