FROM kevinity310/hadoop-base:dev

# MAINTAINER Ivan Ermilov <ivan.s.ermilov@gmail.com>

HEALTHCHECK CMD curl -f http://localhost:8042/ || exit 1

# ADD Service Spark 
# Install python 
# Update package lists and install necessary dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y \
    python3.10 \
    python3.10-dev \
    python3-pip \
    nano \
    iputils-ping \
    net-tools \
    lsof 

# Optionally, set Python 3.10 as the default python version
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Verify Python and pip installation
RUN python3 --version && pip3 --version

LABEL maintainer="kevin-bda"

ARG SPARK_VERSION=3.4.2

# ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

ENV SPARK_HOME=/opt/spark-${SPARK_VERSION}
RUN mkdir -p $SPARK_HOME
WORKDIR $SPARK_HOME
 
# Download and install Spark
RUN curl -k -L https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz -o spark-${SPARK_VERSION}-bin-hadoop3.tgz \
  && tar xvzf spark-${SPARK_VERSION}-bin-hadoop3.tgz --directory ${SPARK_HOME} --strip-components 1 \
  && rm -rf spark-${SPARK_VERSION}-bin-hadoop3.tgz

RUN echo "Install Package Required for Spark"
COPY spark/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

RUN mkdir -p /etc/spark

RUN ln -s $SPARK_HOME/conf /etc/spark/conf
RUN ln -s $SPARK_HOME/jars /etc/spark/jars
RUN ln -s $SPARK_HOME/yarn /etc/spark/yarn
RUN ln -s $SPARK_HOME/python /etc/spark/python

RUN cp /etc/spark/conf/spark-defaults.conf.template /etc/spark/conf/spark-defaults.conf  
# RUN cp /etc/spark/conf/fairscheduler.xml.template /etc/spark/conf/fairscheduler.xml

# file config: fairscheduler.xml.template  log4j2.properties.template  metrics.properties.template  spark-defaults.conf.template  spark-env.sh.template  workers.template

# Set environment variables
ENV PATH $SPARK_HOME/sbin/:$SPARK_HOME/bin:$PATH
ENV SPARK_CONF_DIR=/etc/spark/conf

# Adding Hive  
RUN curl -O https://dist.apache.org/repos/dist/release/hive/KEYS

RUN gpg --import KEYS

ENV HIVE_VERSION 3.1.3
ENV HIVE_URL https://downloads.apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
ENV HIVE_HOME /opt/hive-$HIVE_VERSION

RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && curl -fSL "$HIVE_URL.asc" -o /tmp/hive.tar.gz.asc \
    && gpg --verify /tmp/hive.tar.gz.asc \
    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
    && rm /tmp/hive.tar.gz*

RUN mv /opt/apache-hive-$HIVE_VERSION-bin ${HIVE_HOME}

RUN ln -s ${HIVE_HOME}/conf /etc/hive

RUN mkdir ${HIVE_HOME}/logs

# Set environment variables
ENV PATH $HIVE_HOME/bin:$PATH

# # Remove existing Guava JAR from $HIVE_HOME/lib
RUN rm $HIVE_HOME/lib/guava-19.0.jar

# # Copy the appropriate Guava JAR from $HADOOP_HOME/share/hadoop/hdfs/lib to $HIVE_HOME/lib
RUN cp $HADOOP_HOME/share/hadoop/hdfs/lib/guava-27.0-jre.jar $HIVE_HOME/lib/

COPY hive/conf/* $HIVE_HOME/conf/

WORKDIR /


ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 8042

CMD ["/run.sh"]

# docker build -t kevinity310/hadoop-nodemanager:dev .
# docker run -it --rm --name test-hive-server --env-file hadoop-host-dev.env kevinity310/hadoop-nodemanager:dev /bin/bash 

